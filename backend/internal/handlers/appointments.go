package handlers

import (
	"encoding/json"
	"errors"
	"net/http"
	"time"

	"github.com/go-chi/chi/v5"
	"github.com/jackc/pgx/v5"
	"github.com/jakej985-rgb/infernal-web/backend/internal/audit"
	"github.com/jakej985-rgb/infernal-web/backend/internal/database"
	"github.com/jakej985-rgb/infernal-web/backend/internal/middleware"
	ws "github.com/jakej985-rgb/infernal-web/backend/internal/websocket"
)

type AppointmentsHandler struct {
	db  *database.DB
	hub *ws.Hub
}

func NewAppointmentsHandler(db *database.DB, hub *ws.Hub) *AppointmentsHandler {
	return &AppointmentsHandler{db: db, hub: hub}
}

type AppointmentModel struct {
	ID             string    `json:"id"`
	OrganizationID string    `json:"organization_id"`
	ClientID       string    `json:"client_id"`
	ClientName     string    `json:"client_name,omitempty"`
	Title          string    `json:"title"`
	Notes          string    `json:"notes"`
	StartTime      time.Time `json:"start_time"`
	EndTime        time.Time `json:"end_time"`
	CreatedAt      time.Time `json:"created_at"`
	UpdatedAt      time.Time `json:"updated_at"`
}

type AppointmentUpsertRequest struct {
	ClientID  string    `json:"client_id"`
	Title     string    `json:"title"`
	Notes     string    `json:"notes"`
	StartTime time.Time `json:"start_time"`
	EndTime   time.Time `json:"end_time"`
}

func (h *AppointmentsHandler) List(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	orgID := middleware.GetOrganizationID(r.Context())

	query := `
		SELECT a.id, a.organization_id, a.client_id, c.name as client_name, a.title, a.notes, a.start_time, a.end_time, a.created_at, a.updated_at
		FROM appointments a
		JOIN clients c ON a.client_id = c.id
		WHERE a.organization_id = $1
		ORDER BY a.start_time ASC
	`
	rows, err := h.db.Pool.Query(r.Context(), query, orgID)
	if err != nil {
		http.Error(w, `{"error": "Database error"}`, http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	appointments := []AppointmentModel{}
	for rows.Next() {
		var a AppointmentModel
		var notes *string
		err = rows.Scan(&a.ID, &a.OrganizationID, &a.ClientID, &a.ClientName, &a.Title, &notes, &a.StartTime, &a.EndTime, &a.CreatedAt, &a.UpdatedAt)
		if err != nil {
			http.Error(w, `{"error": "Failed to parse records"}`, http.StatusInternalServerError)
			return
		}
		if notes != nil {
			a.Notes = *notes
		}
		appointments = append(appointments, a)
	}

	_ = json.NewEncoder(w).Encode(appointments)
}

func (h *AppointmentsHandler) Create(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	orgID := middleware.GetOrganizationID(r.Context())

	var req AppointmentUpsertRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, `{"error": "Invalid request body"}` , http.StatusBadRequest)
		return
	}

	if req.ClientID == "" || req.Title == "" || req.StartTime.IsZero() || req.EndTime.IsZero() {
		http.Error(w, `{"error": "client_id, title, start_time, and end_time are required"}`, http.StatusBadRequest)
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

	var appID string
	query := `
		INSERT INTO appointments (organization_id, client_id, title, notes, start_time, end_time)
		VALUES ($1, $2, $3, $4, $5, $6)
		RETURNING id
	`
	var notesVal *string = nil
	if req.Notes != "" {
		notesVal = &req.Notes
	}

	err = h.db.Pool.QueryRow(r.Context(), query, orgID, req.ClientID, req.Title, notesVal, req.StartTime, req.EndTime).Scan(&appID)
	if err != nil {
		http.Error(w, `{"error": "Database error"}`, http.StatusInternalServerError)
		return
	}

	// Log audit
	audit.Log(r.Context(), h.db, "CREATE_APPOINTMENT", "appointments", appID, req)

	// WS Broadcast
	h.hub.Broadcast(orgID, map[string]interface{}{
		"event": "appointment_created",
		"id":    appID,
	})

	w.WriteHeader(http.StatusCreated)
	_ = json.NewEncoder(w).Encode(map[string]string{"id": appID})
}

func (h *AppointmentsHandler) Get(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	orgID := middleware.GetOrganizationID(r.Context())
	id := chi.URLParam(r, "id")

	query := `
		SELECT a.id, a.organization_id, a.client_id, c.name as client_name, a.title, a.notes, a.start_time, a.end_time, a.created_at, a.updated_at
		FROM appointments a
		JOIN clients c ON a.client_id = c.id
		WHERE a.id = $1 AND a.organization_id = $2
	`
	var a AppointmentModel
	var notes *string
	err := h.db.Pool.QueryRow(r.Context(), query, id, orgID).Scan(&a.ID, &a.OrganizationID, &a.ClientID, &a.ClientName, &a.Title, &notes, &a.StartTime, &a.EndTime, &a.CreatedAt, &a.UpdatedAt)

	if err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			http.Error(w, `{"error": "Appointment not found"}`, http.StatusNotFound)
			return
		}
		http.Error(w, `{"error": "Database error"}`, http.StatusInternalServerError)
		return
	}

	if notes != nil {
		a.Notes = *notes
	}

	_ = json.NewEncoder(w).Encode(a)
}

func (h *AppointmentsHandler) Update(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	orgID := middleware.GetOrganizationID(r.Context())
	id := chi.URLParam(r, "id")

	var req AppointmentUpsertRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, `{"error": "Invalid request body"}`, http.StatusBadRequest)
		return
	}

	if req.ClientID == "" || req.Title == "" || req.StartTime.IsZero() || req.EndTime.IsZero() {
		http.Error(w, `{"error": "client_id, title, start_time, and end_time are required"}`, http.StatusBadRequest)
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

	query := `
		UPDATE appointments
		SET client_id = $1, title = $2, notes = $3, start_time = $4, end_time = $5, updated_at = CURRENT_TIMESTAMP
		WHERE id = $6 AND organization_id = $7
	`
	var notesVal *string = nil
	if req.Notes != "" {
		notesVal = &req.Notes
	}

	cmd, err := h.db.Pool.Exec(r.Context(), query, req.ClientID, req.Title, notesVal, req.StartTime, req.EndTime, id, orgID)
	if err != nil {
		http.Error(w, `{"error": "Database error"}`, http.StatusInternalServerError)
		return
	}

	if cmd.RowsAffected() == 0 {
		http.Error(w, `{"error": "Appointment not found or access denied"}`, http.StatusNotFound)
		return
	}

	// Log audit
	audit.Log(r.Context(), h.db, "UPDATE_APPOINTMENT", "appointments", id, req)

	// WS Broadcast
	h.hub.Broadcast(orgID, map[string]interface{}{
		"event": "appointment_updated",
		"id":    id,
	})

	w.WriteHeader(http.StatusOK)
	_, _ = w.Write([]byte(`{"status": "updated"}`))
}

func (h *AppointmentsHandler) Delete(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	orgID := middleware.GetOrganizationID(r.Context())
	id := chi.URLParam(r, "id")

	query := "DELETE FROM appointments WHERE id = $1 AND organization_id = $2"
	cmd, err := h.db.Pool.Exec(r.Context(), query, id, orgID)
	if err != nil {
		http.Error(w, `{"error": "Database error"}`, http.StatusInternalServerError)
		return
	}

	if cmd.RowsAffected() == 0 {
		http.Error(w, `{"error": "Appointment not found or access denied"}`, http.StatusNotFound)
		return
	}

	// Log audit
	audit.Log(r.Context(), h.db, "DELETE_APPOINTMENT", "appointments", id, nil)

	// WS Broadcast
	h.hub.Broadcast(orgID, map[string]interface{}{
		"event": "appointment_deleted",
		"id":    id,
	})

	w.WriteHeader(http.StatusOK)
	_, _ = w.Write([]byte(`{"status": "deleted"}`))
}
