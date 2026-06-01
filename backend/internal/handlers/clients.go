package handlers

import (
	"encoding/json"
	"errors"
	"net/http"

	"github.com/go-chi/chi/v5"
	"github.com/jackc/pgx/v5"
	"github.com/jakej985-rgb/infernal-web/backend/internal/audit"
	"github.com/jakej985-rgb/infernal-web/backend/internal/database"
	"github.com/jakej985-rgb/infernal-web/backend/internal/middleware"
	ws "github.com/jakej985-rgb/infernal-web/backend/internal/websocket"
)

type ClientsHandler struct {
	db  *database.DB
	hub *ws.Hub
}

func NewClientsHandler(db *database.DB, hub *ws.Hub) *ClientsHandler {
	return &ClientsHandler{db: db, hub: hub}
}

type ClientModel struct {
	ID             string `json:"id"`
	OrganizationID string `json:"organization_id"`
	Name           string `json:"name"`
	Email          string `json:"email"`
	Phone          string `json:"phone"`
	CreatedAt      string `json:"created_at"`
	UpdatedAt      string `json:"updated_at"`
}

type ClientUpsertRequest struct {
	Name  string `json:"name"`
	Email string `json:"email"`
	Phone string `json:"phone"`
}

func (h *ClientsHandler) List(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	orgID := middleware.GetOrganizationID(r.Context())

	rows, err := h.db.Pool.Query(r.Context(),
		"SELECT id, organization_id, name, email, phone, created_at, updated_at FROM clients WHERE organization_id = $1 ORDER BY name ASC",
		orgID,
	)
	if err != nil {
		http.Error(w, `{"error": "Database error"}`, http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	clients := []ClientModel{}
	for rows.Next() {
		var c ClientModel
		var emailStr, phoneStr *string
		err = rows.Scan(&c.ID, &c.OrganizationID, &c.Name, &emailStr, &phoneStr, &c.CreatedAt, &c.UpdatedAt)
		if err != nil {
			http.Error(w, `{"error": "Failed to parse records"}`, http.StatusInternalServerError)
			return
		}
		if emailStr != nil {
			c.Email = *emailStr
		}
		if phoneStr != nil {
			c.Phone = *phoneStr
		}
		clients = append(clients, c)
	}

	_ = json.NewEncoder(w).Encode(clients)
}

func (h *ClientsHandler) Create(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	orgID := middleware.GetOrganizationID(r.Context())

	var req ClientUpsertRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, `{"error": "Invalid request body"}`, http.StatusBadRequest)
		return
	}

	if req.Name == "" {
		http.Error(w, `{"error": "Name is required"}`, http.StatusBadRequest)
		return
	}

	var clientID string
	query := `
		INSERT INTO clients (organization_id, name, email, phone)
		VALUES ($1, $2, $3, $4)
		RETURNING id
	`
	// Handle empty string as null in DB
	var emailVal *string = nil
	if req.Email != "" {
		emailVal = &req.Email
	}
	var phoneVal *string = nil
	if req.Phone != "" {
		phoneVal = &req.Phone
	}

	err := h.db.Pool.QueryRow(r.Context(), query, orgID, req.Name, emailVal, phoneVal).Scan(&clientID)
	if err != nil {
		http.Error(w, `{"error": "Database error"}`, http.StatusInternalServerError)
		return
	}

	// Logging Audit Trail
	audit.Log(r.Context(), h.db, "CREATE_CLIENT", "clients", clientID, req)

	// Broadcast updates real-time
	h.hub.Broadcast(orgID, map[string]interface{}{
		"event": "client_created",
		"id":    clientID,
	})

	w.WriteHeader(http.StatusCreated)
	_ = json.NewEncoder(w).Encode(map[string]string{"id": clientID})
}

func (h *ClientsHandler) Get(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	orgID := middleware.GetOrganizationID(r.Context())
	id := chi.URLParam(r, "id")

	var c ClientModel
	var emailStr, phoneStr *string
	query := "SELECT id, organization_id, name, email, phone FROM clients WHERE id = $1 AND organization_id = $2"
	err := h.db.Pool.QueryRow(r.Context(), query, id, orgID).Scan(&c.ID, &c.OrganizationID, &c.Name, &emailStr, &phoneStr)

	if err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			http.Error(w, `{"error": "Client not found"}`, http.StatusNotFound)
			return
		}
		http.Error(w, `{"error": "Database error"}`, http.StatusInternalServerError)
		return
	}

	if emailStr != nil {
		c.Email = *emailStr
	}
	if phoneStr != nil {
		c.Phone = *phoneStr
	}

	_ = json.NewEncoder(w).Encode(c)
}

func (h *ClientsHandler) Update(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	orgID := middleware.GetOrganizationID(r.Context())
	id := chi.URLParam(r, "id")

	var req ClientUpsertRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, `{"error": "Invalid request body"}`, http.StatusBadRequest)
		return
	}

	if req.Name == "" {
		http.Error(w, `{"error": "Name is required"}`, http.StatusBadRequest)
		return
	}

	var emailVal *string = nil
	if req.Email != "" {
		emailVal = &req.Email
	}
	var phoneVal *string = nil
	if req.Phone != "" {
		phoneVal = &req.Phone
	}

	query := `
		UPDATE clients
		SET name = $1, email = $2, phone = $3, updated_at = CURRENT_TIMESTAMP
		WHERE id = $4 AND organization_id = $5
	`
	cmd, err := h.db.Pool.Exec(r.Context(), query, req.Name, emailVal, phoneVal, id, orgID)
	if err != nil {
		http.Error(w, `{"error": "Database error"}`, http.StatusInternalServerError)
		return
	}

	if cmd.RowsAffected() == 0 {
		http.Error(w, `{"error": "Client not found or access denied"}`, http.StatusNotFound)
		return
	}

	// Logging Audit Trail
	audit.Log(r.Context(), h.db, "UPDATE_CLIENT", "clients", id, req)

	// Broadcast updates real-time
	h.hub.Broadcast(orgID, map[string]interface{}{
		"event": "client_updated",
		"id":    id,
	})

	w.WriteHeader(http.StatusOK)
	_, _ = w.Write([]byte(`{"status": "updated"}`))
}

func (h *ClientsHandler) Delete(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	orgID := middleware.GetOrganizationID(r.Context())
	id := chi.URLParam(r, "id")

	query := "DELETE FROM clients WHERE id = $1 AND organization_id = $2"
	cmd, err := h.db.Pool.Exec(r.Context(), query, id, orgID)
	if err != nil {
		http.Error(w, `{"error": "Database error"}`, http.StatusInternalServerError)
		return
	}

	if cmd.RowsAffected() == 0 {
		http.Error(w, `{"error": "Client not found or access denied"}`, http.StatusNotFound)
		return
	}

	// Logging Audit Trail
	audit.Log(r.Context(), h.db, "DELETE_CLIENT", "clients", id, nil)

	// Broadcast updates real-time
	h.hub.Broadcast(orgID, map[string]interface{}{
		"event": "client_deleted",
		"id":    id,
	})

	w.WriteHeader(http.StatusOK)
	_, _ = w.Write([]byte(`{"status": "deleted"}`))
}
