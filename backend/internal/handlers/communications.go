package handlers

import (
	"encoding/json"
	"net/http"
	"time"

	"github.com/go-chi/chi/v5"
	"github.com/jackc/pgx/v5"
	"github.com/jakej985-rgb/infernal-web/backend/internal/audit"
	"github.com/jakej985-rgb/infernal-web/backend/internal/database"
	"github.com/jakej985-rgb/infernal-web/backend/internal/middleware"
	ws "github.com/jakej985-rgb/infernal-web/backend/internal/websocket"
)

type CommunicationsHandler struct {
	db  *database.DB
	hub *ws.Hub
}

func NewCommunicationsHandler(db *database.DB, hub *ws.Hub) *CommunicationsHandler {
	return &CommunicationsHandler{db: db, hub: hub}
}

type CommunicationModel struct {
	ID             string    `json:"id"`
	OrganizationID string    `json:"organization_id"`
	ClientID       string    `json:"client_id"`
	Type           string    `json:"type"` // e.g. 'call', 'message', 'note'
	Content        string    `json:"content"`
	CreatedAt      time.Time `json:"created_at"`
	UpdatedAt      time.Time `json:"updated_at"`
}

type CommunicationUpsertRequest struct {
	ClientID string `json:"client_id"`
	Type     string `json:"type"`
	Content  string `json:"content"`
}

func (h *CommunicationsHandler) List(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	orgID := middleware.GetOrganizationID(r.Context())
	clientID := r.URL.Query().Get("client_id")

	var rows pgx.Rows
	var err error
	if clientID != "" {
		rows, err = h.db.Pool.Query(r.Context(),
			"SELECT id, organization_id, client_id, type, content, created_at, updated_at FROM communications WHERE organization_id = $1 AND client_id = $2 ORDER BY created_at DESC",
			orgID, clientID,
		)
	} else {
		rows, err = h.db.Pool.Query(r.Context(),
			"SELECT id, organization_id, client_id, type, content, created_at, updated_at FROM communications WHERE organization_id = $1 ORDER BY created_at DESC",
			orgID,
		)
	}

	if err != nil {
		http.Error(w, `{"error": "Database error"}`, http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	logs := []CommunicationModel{}
	for rows.Next() {
		var c CommunicationModel
		err = rows.Scan(&c.ID, &c.OrganizationID, &c.ClientID, &c.Type, &c.Content, &c.CreatedAt, &c.UpdatedAt)
		if err != nil {
			http.Error(w, `{"error": "Failed to parse records"}`, http.StatusInternalServerError)
			return
		}
		logs = append(logs, c)
	}

	_ = json.NewEncoder(w).Encode(logs)
}

func (h *CommunicationsHandler) Create(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	orgID := middleware.GetOrganizationID(r.Context())

	var req CommunicationUpsertRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, `{"error": "Invalid request body"}`, http.StatusBadRequest)
		return
	}

	if req.ClientID == "" || req.Type == "" || req.Content == "" {
		http.Error(w, `{"error": "client_id, type, and content are required"}`, http.StatusBadRequest)
		return
	}

	// Validate client belongs to organization
	var exists bool
	err := h.db.Pool.QueryRow(r.Context(),
		"SELECT EXISTS(SELECT 1 FROM clients WHERE id = $1 AND organization_id = $2)",
		req.ClientID, orgID,
	).Scan(&exists)
	if err != nil || !exists {
		http.Error(w, `{"error": "Client not found in organization"}`, http.StatusBadRequest)
		return
	}

	var commID string
	query := `
		INSERT INTO communications (organization_id, client_id, type, content)
		VALUES ($1, $2, $3, $4)
		RETURNING id
	`
	err = h.db.Pool.QueryRow(r.Context(), query, orgID, req.ClientID, req.Type, req.Content).Scan(&commID)
	if err != nil {
		http.Error(w, `{"error": "Database error"}`, http.StatusInternalServerError)
		return
	}

	// Log audit
	audit.Log(r.Context(), h.db, "CREATE_COMMUNICATION", "communications", commID, req)

	// WS Broadcast
	h.hub.Broadcast(orgID, map[string]interface{}{
		"event": "communication_created",
		"id":    commID,
	})

	w.WriteHeader(http.StatusCreated)
	_ = json.NewEncoder(w).Encode(map[string]string{"id": commID})
}

func (h *CommunicationsHandler) Delete(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	orgID := middleware.GetOrganizationID(r.Context())
	id := chi.URLParam(r, "id")

	query := "DELETE FROM communications WHERE id = $1 AND organization_id = $2"
	cmd, err := h.db.Pool.Exec(r.Context(), query, id, orgID)
	if err != nil {
		http.Error(w, `{"error": "Database error"}`, http.StatusInternalServerError)
		return
	}

	if cmd.RowsAffected() == 0 {
		http.Error(w, `{"error": "Communication record not found or access denied"}`, http.StatusNotFound)
		return
	}

	// Log audit
	audit.Log(r.Context(), h.db, "DELETE_COMMUNICATION", "communications", id, nil)

	// WS Broadcast
	h.hub.Broadcast(orgID, map[string]interface{}{
		"event": "communication_deleted",
		"id":    id,
	})

	w.WriteHeader(http.StatusOK)
	_, _ = w.Write([]byte(`{"status": "deleted"}`))
}
