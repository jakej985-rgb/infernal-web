package handlers

import (
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"log/slog"
	"net/http"
	"os"
	"path/filepath"
	"time"

	"github.com/go-chi/chi/v5"
	"github.com/jackc/pgx/v5"
	"github.com/jakej985-rgb/infernal-web/backend/internal/audit"
	"github.com/jakej985-rgb/infernal-web/backend/internal/database"
	"github.com/jakej985-rgb/infernal-web/backend/internal/middleware"
	ws "github.com/jakej985-rgb/infernal-web/backend/internal/websocket"
)

type DocumentsHandler struct {
	db        *database.DB
	hub       *ws.Hub
	uploadDir string
}

func NewDocumentsHandler(db *database.DB, hub *ws.Hub, uploadDir string) *DocumentsHandler {
	// Auto create upload directory if it doesn't exist
	if err := os.MkdirAll(uploadDir, 0755); err != nil {
		slog.Error("Failed to create upload directory", "path", uploadDir, "error", err)
	}
	return &DocumentsHandler{
		db:        db,
		hub:       hub,
		uploadDir: uploadDir,
	}
}

type DocumentModel struct {
	ID             string    `json:"id"`
	OrganizationID string    `json:"organization_id"`
	ClientID       string    `json:"client_id,omitempty"`
	Name           string    `json:"name"`
	FilePath       string    `json:"file_path"`
	FileSize       int64     `json:"file_size"`
	CreatedAt      time.Time `json:"created_at"`
	UpdatedAt      time.Time `json:"updated_at"`
}

func (h *DocumentsHandler) List(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	orgID := middleware.GetOrganizationID(r.Context())
	clientID := r.URL.Query().Get("client_id")

	var rows pgx.Rows
	var err error
	if clientID != "" {
		rows, err = h.db.Pool.Query(r.Context(),
			"SELECT id, organization_id, client_id, name, file_path, file_size, created_at, updated_at FROM documents WHERE organization_id = $1 AND client_id = $2 ORDER BY created_at DESC",
			orgID, clientID,
		)
	} else {
		rows, err = h.db.Pool.Query(r.Context(),
			"SELECT id, organization_id, client_id, name, file_path, file_size, created_at, updated_at FROM documents WHERE organization_id = $1 ORDER BY created_at DESC",
			orgID,
		)
	}

	if err != nil {
		http.Error(w, `{"error": "Database error"}`, http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	docs := []DocumentModel{}
	for rows.Next() {
		var doc DocumentModel
		var cID *string
		err = rows.Scan(&doc.ID, &doc.OrganizationID, &cID, &doc.Name, &doc.FilePath, &doc.FileSize, &doc.CreatedAt, &doc.UpdatedAt)
		if err != nil {
			http.Error(w, `{"error": "Failed to parse records"}`, http.StatusInternalServerError)
			return
		}
		if cID != nil {
			doc.ClientID = *cID
		}
		docs = append(docs, doc)
	}

	_ = json.NewEncoder(w).Encode(docs)
}

func (h *DocumentsHandler) Upload(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	orgID := middleware.GetOrganizationID(r.Context())

	// Limit upload size to 10MB
	err := r.ParseMultipartForm(10 << 20)
	if err != nil {
		http.Error(w, `{"error": "File size exceeds limit (10MB)"}`, http.StatusBadRequest)
		return
	}

	file, handler, err := r.FormFile("file")
	if err != nil {
		http.Error(w, `{"error": "File field is required"}`, http.StatusBadRequest)
		return
	}
	defer file.Close()

	clientID := r.FormValue("client_id")
	if clientID != "" {
		// Validate client belongs to user organization
		var exists bool
		err := h.db.Pool.QueryRow(r.Context(),
			"SELECT EXISTS(SELECT 1 FROM clients WHERE id = $1 AND organization_id = $2)",
			clientID, orgID,
		).Scan(&exists)
		if err != nil || !exists {
			http.Error(w, `{"error": "Client not found in organization"}`, http.StatusBadRequest)
			return
		}
	}

	// Create unique file name on disk
	uniqueFileName := fmt.Sprintf("%d_%s", time.Now().UnixNano(), handler.Filename)
	filePath := filepath.Join(h.uploadDir, uniqueFileName)

	destFile, err := os.OpenFile(filePath, os.O_WRONLY|os.O_CREATE, 0644)
	if err != nil {
		http.Error(w, `{"error": "Failed to save file on server"}`, http.StatusInternalServerError)
		return
	}
	defer destFile.Close()

	fileSize, err := io.Copy(destFile, file)
	if err != nil {
		http.Error(w, `{"error": "Failed to write file contents"}`, http.StatusInternalServerError)
		return
	}

	var docID string
	query := `
		INSERT INTO documents (organization_id, client_id, name, file_path, file_size)
		VALUES ($1, $2, $3, $4, $5)
		RETURNING id
	`
	var clientIDVal *string = nil
	if clientID != "" {
		clientIDVal = &clientID
	}

	err = h.db.Pool.QueryRow(r.Context(), query, orgID, clientIDVal, handler.Filename, filePath, fileSize).Scan(&docID)
	if err != nil {
		// Cleanup saved file on database insertion failure
		os.Remove(filePath)
		http.Error(w, `{"error": "Database error saving metadata"}`, http.StatusInternalServerError)
		return
	}

	// Log audit
	audit.Log(r.Context(), h.db, "UPLOAD_DOCUMENT", "documents", docID, map[string]interface{}{
		"name":      handler.Filename,
		"client_id": clientID,
		"file_size": fileSize,
	})

	// WS Broadcast
	h.hub.Broadcast(orgID, map[string]interface{}{
		"event": "document_uploaded",
		"id":    docID,
	})

	w.WriteHeader(http.StatusCreated)
	_ = json.NewEncoder(w).Encode(map[string]string{"id": docID, "file_name": handler.Filename})
}

func (h *DocumentsHandler) Delete(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	orgID := middleware.GetOrganizationID(r.Context())
	id := chi.URLParam(r, "id")

	var filePath string
	err := h.db.Pool.QueryRow(r.Context(),
		"SELECT file_path FROM documents WHERE id = $1 AND organization_id = $2",
		id, orgID,
	).Scan(&filePath)

	if err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			http.Error(w, `{"error": "Document not found or access denied"}`, http.StatusNotFound)
			return
		}
		http.Error(w, `{"error": "Database error"}`, http.StatusInternalServerError)
		return
	}

	// Delete from database
	_, err = h.db.Pool.Exec(r.Context(), "DELETE FROM documents WHERE id = $1", id)
	if err != nil {
		http.Error(w, `{"error": "Failed to delete record"}`, http.StatusInternalServerError)
		return
	}

	// Delete physical file from disk (log warning if missing but continue)
	if err := os.Remove(filePath); err != nil && !os.IsNotExist(err) {
		slog.Warn("Failed to remove file from disk", "path", filePath, "error", err)
	}

	// Log audit
	audit.Log(r.Context(), h.db, "DELETE_DOCUMENT", "documents", id, nil)

	// WS Broadcast
	h.hub.Broadcast(orgID, map[string]interface{}{
		"event": "document_deleted",
		"id":    id,
	})

	w.WriteHeader(http.StatusOK)
	_, _ = w.Write([]byte(`{"status": "deleted"}`))
}
