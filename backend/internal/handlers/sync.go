package handlers

import (
	"encoding/json"
	"net/http"
	"time"

	"github.com/jakej985-rgb/infernal-web/backend/internal/audit"
	"github.com/jakej985-rgb/infernal-web/backend/internal/database"
	"github.com/jakej985-rgb/infernal-web/backend/internal/middleware"
)

type SyncHandler struct {
	db *database.DB
}

func NewSyncHandler(db *database.DB) *SyncHandler {
	return &SyncHandler{db: db}
}

// SyncRequest payload containing local client changes
type SyncRequest struct {
	LastSyncTimestamp time.Time          `json:"last_sync_timestamp"`
	Clients           []ClientSyncDTO    `json:"clients"`
	Appointments      []ApptSyncDTO      `json:"appointments"`
	Inventory         []InvSyncDTO       `json:"inventory"`
	Documents         []DocSyncDTO       `json:"documents"`
	Communications    []CommSyncDTO      `json:"communications"`
}

// SyncResponse payload containing server updates since the client's last sync
type SyncResponse struct {
	CurrentTimestamp time.Time          `json:"current_timestamp"`
	Clients          []ClientSyncDTO    `json:"clients"`
	Appointments     []ApptSyncDTO      `json:"appointments"`
	Inventory        []InvSyncDTO       `json:"inventory"`
	Documents        []DocSyncDTO       `json:"documents"`
	Communications   []CommSyncDTO      `json:"communications"`
}

type ClientSyncDTO struct {
	ID        string    `json:"id"`
	Name      string    `json:"name"`
	Email     string    `json:"email"`
	Phone     string    `json:"phone"`
	IsDeleted bool      `json:"is_deleted"`
	UpdatedAt time.Time `json:"updated_at"`
}

type ApptSyncDTO struct {
	ID        string    `json:"id"`
	ClientID  string    `json:"client_id"`
	Title     string    `json:"title"`
	Notes     string    `json:"notes"`
	StartTime time.Time `json:"start_time"`
	EndTime   time.Time `json:"end_time"`
	IsDeleted bool      `json:"is_deleted"`
	UpdatedAt time.Time `json:"updated_at"`
}

type InvSyncDTO struct {
	ID                string     `json:"id"`
	Name              string     `json:"name"`
	Description       string     `json:"description"`
	Quantity          int        `json:"quantity"`
	LowStockThreshold int        `json:"low_stock_threshold"`
	Category          string     `json:"category"`
	Unit              string     `json:"unit"`
	Supplier          *string    `json:"supplier"`
	LastOrderedAt     *time.Time `json:"last_ordered_at"`
	IsDeleted         bool       `json:"is_deleted"`
	UpdatedAt         time.Time  `json:"updated_at"`
}

type DocSyncDTO struct {
	ID        string    `json:"id"`
	ClientID  *string   `json:"client_id"`
	Name      string    `json:"name"`
	FilePath  string    `json:"file_path"`
	FileSize  int64     `json:"file_size"`
	IsDeleted bool      `json:"is_deleted"`
	UpdatedAt time.Time `json:"updated_at"`
}

type CommSyncDTO struct {
	ID        string    `json:"id"`
	ClientID  string    `json:"client_id"`
	Type      string    `json:"type"`
	Content   string    `json:"content"`
	IsDeleted bool      `json:"is_deleted"`
	UpdatedAt time.Time `json:"updated_at"`
}

func (h *SyncHandler) Sync(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	orgID := middleware.GetOrganizationID(r.Context())

	var req SyncRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, `{"error": "Invalid request body"}`, http.StatusBadRequest)
		return
	}

	ctx := r.Context()
	tx, err := h.db.Pool.Begin(ctx)
	if err != nil {
		http.Error(w, `{"error": "Failed to start transaction"}`, http.StatusInternalServerError)
		return
	}
	defer tx.Rollback(ctx)

	pushedClientIDs := []string{}
	pushedApptIDs := []string{}
	pushedInvIDs := []string{}
	pushedDocIDs := []string{}
	pushedCommIDs := []string{}

	// 1. Process client updates (LWW)
	for _, c := range req.Clients {
		pushedClientIDs = append(pushedClientIDs, c.ID)
		query := `
			INSERT INTO clients (id, organization_id, name, email, phone, is_deleted, updated_at)
			VALUES ($1, $2, $3, $4, $5, $6, $7)
			ON CONFLICT (id) DO UPDATE SET
				name = EXCLUDED.name,
				email = EXCLUDED.email,
				phone = EXCLUDED.phone,
				is_deleted = EXCLUDED.is_deleted,
				updated_at = EXCLUDED.updated_at
			WHERE EXCLUDED.updated_at > clients.updated_at
		`
		var emailVal *string = nil
		if c.Email != "" {
			emailVal = &c.Email
		}
		var phoneVal *string = nil
		if c.Phone != "" {
			phoneVal = &c.Phone
		}
		_, err := tx.Exec(ctx, query, c.ID, orgID, c.Name, emailVal, phoneVal, c.IsDeleted, c.UpdatedAt)
		if err != nil {
			http.Error(w, `{"error": "Sync error processing clients"}`, http.StatusInternalServerError)
			return
		}
	}

	// 2. Process appointment updates (LWW)
	for _, a := range req.Appointments {
		pushedApptIDs = append(pushedApptIDs, a.ID)
		query := `
			INSERT INTO appointments (id, organization_id, client_id, title, notes, start_time, end_time, is_deleted, updated_at)
			VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)
			ON CONFLICT (id) DO UPDATE SET
				client_id = EXCLUDED.client_id,
				title = EXCLUDED.title,
				notes = EXCLUDED.notes,
				start_time = EXCLUDED.start_time,
				end_time = EXCLUDED.end_time,
				is_deleted = EXCLUDED.is_deleted,
				updated_at = EXCLUDED.updated_at
			WHERE EXCLUDED.updated_at > appointments.updated_at
		`
		var notesVal *string = nil
		if a.Notes != "" {
			notesVal = &a.Notes
		}
		_, err := tx.Exec(ctx, query, a.ID, orgID, a.ClientID, a.Title, notesVal, a.StartTime, a.EndTime, a.IsDeleted, a.UpdatedAt)
		if err != nil {
			http.Error(w, `{"error": "Sync error processing appointments"}`, http.StatusInternalServerError)
			return
		}
	}

	// 3. Process inventory updates (LWW)
	for _, iv := range req.Inventory {
		pushedInvIDs = append(pushedInvIDs, iv.ID)
		query := `
			INSERT INTO inventory (id, organization_id, name, description, quantity, low_stock_threshold, category, unit, supplier, last_ordered_at, is_deleted, updated_at)
			VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12)
			ON CONFLICT (id) DO UPDATE SET
				name = EXCLUDED.name,
				description = EXCLUDED.description,
				quantity = EXCLUDED.quantity,
				low_stock_threshold = EXCLUDED.low_stock_threshold,
				category = EXCLUDED.category,
				unit = EXCLUDED.unit,
				supplier = EXCLUDED.supplier,
				last_ordered_at = EXCLUDED.last_ordered_at,
				is_deleted = EXCLUDED.is_deleted,
				updated_at = EXCLUDED.updated_at
			WHERE EXCLUDED.updated_at > inventory.updated_at
		`
		var descVal *string = nil
		if iv.Description != "" {
			descVal = &iv.Description
		}
		_, err := tx.Exec(ctx, query, iv.ID, orgID, iv.Name, descVal, iv.Quantity, iv.LowStockThreshold, iv.Category, iv.Unit, iv.Supplier, iv.LastOrderedAt, iv.IsDeleted, iv.UpdatedAt)
		if err != nil {
			http.Error(w, `{"error": "Sync error processing inventory"}`, http.StatusInternalServerError)
			return
		}
	}

	// 4. Process document updates (LWW)
	for _, d := range req.Documents {
		pushedDocIDs = append(pushedDocIDs, d.ID)
		query := `
			INSERT INTO documents (id, organization_id, client_id, name, file_path, file_size, is_deleted, updated_at)
			VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
			ON CONFLICT (id) DO UPDATE SET
				client_id = EXCLUDED.client_id,
				name = EXCLUDED.name,
				file_path = EXCLUDED.file_path,
				file_size = EXCLUDED.file_size,
				is_deleted = EXCLUDED.is_deleted,
				updated_at = EXCLUDED.updated_at
			WHERE EXCLUDED.updated_at > documents.updated_at
		`
		_, err := tx.Exec(ctx, query, d.ID, orgID, d.ClientID, d.Name, d.FilePath, d.FileSize, d.IsDeleted, d.UpdatedAt)
		if err != nil {
			http.Error(w, `{"error": "Sync error processing documents"}`, http.StatusInternalServerError)
			return
		}
	}

	// 5. Process communications updates (LWW)
	for _, cm := range req.Communications {
		pushedCommIDs = append(pushedCommIDs, cm.ID)
		query := `
			INSERT INTO communications (id, organization_id, client_id, type, content, is_deleted, updated_at)
			VALUES ($1, $2, $3, $4, $5, $6, $7)
			ON CONFLICT (id) DO UPDATE SET
				client_id = EXCLUDED.client_id,
				type = EXCLUDED.type,
				content = EXCLUDED.content,
				is_deleted = EXCLUDED.is_deleted,
				updated_at = EXCLUDED.updated_at
			WHERE EXCLUDED.updated_at > communications.updated_at
		`
		_, err := tx.Exec(ctx, query, cm.ID, orgID, cm.ClientID, cm.Type, cm.Content, cm.IsDeleted, cm.UpdatedAt)
		if err != nil {
			http.Error(w, `{"error": "Sync error processing communications"}`, http.StatusInternalServerError)
			return
		}
	}

	// Fetch updates from database for client (excluding their own pushed IDs)
	resp := SyncResponse{
		CurrentTimestamp: time.Now().UTC(),
		Clients:          []ClientSyncDTO{},
		Appointments:     []ApptSyncDTO{},
		Inventory:        []InvSyncDTO{},
		Documents:        []DocSyncDTO{},
		Communications:   []CommSyncDTO{},
	}

	// Clients pull
	rows, err := tx.Query(ctx,
		"SELECT id, name, email, phone, is_deleted, updated_at FROM clients WHERE organization_id = $1 AND updated_at > $2 AND NOT (id = ANY($3))",
		orgID, req.LastSyncTimestamp, pushedClientIDs,
	)
	if err == nil {
		defer rows.Close()
		for rows.Next() {
			var c ClientSyncDTO
			var emailVal, phoneVal *string
			_ = rows.Scan(&c.ID, &c.Name, &emailVal, &phoneVal, &c.IsDeleted, &c.UpdatedAt)
			if emailVal != nil {
				c.Email = *emailVal
			}
			if phoneVal != nil {
				c.Phone = *phoneVal
			}
			resp.Clients = append(resp.Clients, c)
		}
	}

	// Appointments pull
	rows2, err := tx.Query(ctx,
		"SELECT id, client_id, title, notes, start_time, end_time, is_deleted, updated_at FROM appointments WHERE organization_id = $1 AND updated_at > $2 AND NOT (id = ANY($3))",
		orgID, req.LastSyncTimestamp, pushedApptIDs,
	)
	if err == nil {
		defer rows2.Close()
		for rows2.Next() {
			var a ApptSyncDTO
			var notesVal *string
			_ = rows2.Scan(&a.ID, &a.ClientID, &a.Title, &notesVal, &a.StartTime, &a.EndTime, &a.IsDeleted, &a.UpdatedAt)
			if notesVal != nil {
				a.Notes = *notesVal
			}
			resp.Appointments = append(resp.Appointments, a)
		}
	}

	// Inventory pull
	rows3, err := tx.Query(ctx,
		"SELECT id, name, description, quantity, low_stock_threshold, category, unit, supplier, last_ordered_at, is_deleted, updated_at FROM inventory WHERE organization_id = $1 AND updated_at > $2 AND NOT (id = ANY($3))",
		orgID, req.LastSyncTimestamp, pushedInvIDs,
	)
	if err == nil {
		defer rows3.Close()
		for rows3.Next() {
			var iv InvSyncDTO
			var descVal *string
			_ = rows3.Scan(&iv.ID, &iv.Name, &descVal, &iv.Quantity, &iv.LowStockThreshold, &iv.Category, &iv.Unit, &iv.Supplier, &iv.LastOrderedAt, &iv.IsDeleted, &iv.UpdatedAt)
			if descVal != nil {
				iv.Description = *descVal
			}
			resp.Inventory = append(resp.Inventory, iv)
		}
	}

	// Documents pull
	rows4, err := tx.Query(ctx,
		"SELECT id, client_id, name, file_path, file_size, is_deleted, updated_at FROM documents WHERE organization_id = $1 AND updated_at > $2 AND NOT (id = ANY($3))",
		orgID, req.LastSyncTimestamp, pushedDocIDs,
	)
	if err == nil {
		defer rows4.Close()
		for rows4.Next() {
			var d DocSyncDTO
			_ = rows4.Scan(&d.ID, &d.ClientID, &d.Name, &d.FilePath, &d.FileSize, &d.IsDeleted, &d.UpdatedAt)
			resp.Documents = append(resp.Documents, d)
		}
	}

	// Communications pull
	rows5, err := tx.Query(ctx,
		"SELECT id, client_id, type, content, is_deleted, updated_at FROM communications WHERE organization_id = $1 AND updated_at > $2 AND NOT (id = ANY($3))",
		orgID, req.LastSyncTimestamp, pushedCommIDs,
	)
	if err == nil {
		defer rows5.Close()
		for rows5.Next() {
			var cm CommSyncDTO
			_ = rows5.Scan(&cm.ID, &cm.ClientID, &cm.Type, &cm.Content, &cm.IsDeleted, &cm.UpdatedAt)
			resp.Communications = append(resp.Communications, cm)
		}
	}

	err = tx.Commit(ctx)
	if err != nil {
		http.Error(w, `{"error": "Transaction commit failed"}`, http.StatusInternalServerError)
		return
	}

	// Logging Audit Trail
	audit.Log(ctx, h.db, "SYNC_COMPLETE", "sync", orgID, map[string]interface{}{
		"clients_pushed":      len(req.Clients),
		"clients_pulled":      len(resp.Clients),
		"appointments_pushed": len(req.Appointments),
		"appointments_pulled": len(resp.Appointments),
		"inventory_pushed":    len(req.Inventory),
		"inventory_pulled":    len(resp.Inventory),
	})

	_ = json.NewEncoder(w).Encode(resp)
}
