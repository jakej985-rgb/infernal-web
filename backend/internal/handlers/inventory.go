package handlers

import (
	"encoding/json"
	"net/http"
	"time"

	"github.com/go-chi/chi/v5"
	"github.com/jakej985-rgb/infernal-web/backend/internal/audit"
	"github.com/jakej985-rgb/infernal-web/backend/internal/database"
	"github.com/jakej985-rgb/infernal-web/backend/internal/middleware"
	ws "github.com/jakej985-rgb/infernal-web/backend/internal/websocket"
)

type InventoryHandler struct {
	db  *database.DB
	hub *ws.Hub
}

func NewInventoryHandler(db *database.DB, hub *ws.Hub) *InventoryHandler {
	return &InventoryHandler{db: db, hub: hub}
}

type InventoryModel struct {
	ID                string    `json:"id"`
	OrganizationID    string    `json:"organization_id"`
	Name              string    `json:"name"`
	Description       string    `json:"description"`
	Quantity          int       `json:"quantity"`
	LowStockThreshold int       `json:"low_stock_threshold"`
	LowStock          bool      `json:"low_stock"`
	CreatedAt         time.Time `json:"created_at"`
	UpdatedAt         time.Time `json:"updated_at"`
}

type InventoryUpsertRequest struct {
	Name              string `json:"name"`
	Description       string `json:"description"`
	Quantity          int    `json:"quantity"`
	LowStockThreshold int    `json:"low_stock_threshold"`
}

func (h *InventoryHandler) List(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	orgID := middleware.GetOrganizationID(r.Context())

	query := `
		SELECT id, organization_id, name, description, quantity, low_stock_threshold, created_at, updated_at
		FROM inventory
		WHERE organization_id = $1
		ORDER BY name ASC
	`
	rows, err := h.db.Pool.Query(r.Context(), query, orgID)
	if err != nil {
		http.Error(w, `{"error": "Database error"}`, http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	items := []InventoryModel{}
	for rows.Next() {
		var item InventoryModel
		var desc *string
		err = rows.Scan(&item.ID, &item.OrganizationID, &item.Name, &desc, &item.Quantity, &item.LowStockThreshold, &item.CreatedAt, &item.UpdatedAt)
		if err != nil {
			http.Error(w, `{"error": "Failed to parse records"}`, http.StatusInternalServerError)
			return
		}
		if desc != nil {
			item.Description = *desc
		}
		// Calculate low stock status dynamically
		item.LowStock = item.Quantity <= item.LowStockThreshold
		items = append(items, item)
	}

	_ = json.NewEncoder(w).Encode(items)
}

func (h *InventoryHandler) Create(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	orgID := middleware.GetOrganizationID(r.Context())

	var req InventoryUpsertRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, `{"error": "Invalid request body"}`, http.StatusBadRequest)
		return
	}

	if req.Name == "" {
		http.Error(w, `{"error": "Name is required"}`, http.StatusBadRequest)
		return
	}

	// Default threshold to 5 if not provided or invalid
	if req.LowStockThreshold <= 0 {
		req.LowStockThreshold = 5
	}

	var itemID string
	query := `
		INSERT INTO inventory (organization_id, name, description, quantity, low_stock_threshold)
		VALUES ($1, $2, $3, $4, $5)
		RETURNING id
	`
	var descVal *string = nil
	if req.Description != "" {
		descVal = &req.Description
	}

	err := h.db.Pool.QueryRow(r.Context(), query, orgID, req.Name, descVal, req.Quantity, req.LowStockThreshold).Scan(&itemID)
	if err != nil {
		http.Error(w, `{"error": "Database error"}`, http.StatusInternalServerError)
		return
	}

	// Log audit
	audit.Log(r.Context(), h.db, "CREATE_INVENTORY", "inventory", itemID, req)

	// WS Broadcast
	h.hub.Broadcast(orgID, map[string]interface{}{
		"event": "inventory_created",
		"id":    itemID,
	})

	w.WriteHeader(http.StatusCreated)
	_ = json.NewEncoder(w).Encode(map[string]string{"id": itemID})
}

func (h *InventoryHandler) Update(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	orgID := middleware.GetOrganizationID(r.Context())
	id := chi.URLParam(r, "id")

	var req InventoryUpsertRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, `{"error": "Invalid request body"}`, http.StatusBadRequest)
		return
	}

	if req.Name == "" {
		http.Error(w, `{"error": "Name is required"}`, http.StatusBadRequest)
		return
	}

	if req.LowStockThreshold <= 0 {
		req.LowStockThreshold = 5
	}

	var descVal *string = nil
	if req.Description != "" {
		descVal = &req.Description
	}

	query := `
		UPDATE inventory
		SET name = $1, description = $2, quantity = $3, low_stock_threshold = $4, updated_at = CURRENT_TIMESTAMP
		WHERE id = $5 AND organization_id = $6
	`
	cmd, err := h.db.Pool.Exec(r.Context(), query, req.Name, descVal, req.Quantity, req.LowStockThreshold, id, orgID)
	if err != nil {
		http.Error(w, `{"error": "Database error"}`, http.StatusInternalServerError)
		return
	}

	if cmd.RowsAffected() == 0 {
		http.Error(w, `{"error": "Inventory item not found or access denied"}`, http.StatusNotFound)
		return
	}

	// Log audit
	audit.Log(r.Context(), h.db, "UPDATE_INVENTORY", "inventory", id, req)

	// WS Broadcast
	h.hub.Broadcast(orgID, map[string]interface{}{
		"event": "inventory_updated",
		"id":    id,
	})

	w.WriteHeader(http.StatusOK)
	_, _ = w.Write([]byte(`{"status": "updated"}`))
}

func (h *InventoryHandler) Delete(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	orgID := middleware.GetOrganizationID(r.Context())
	id := chi.URLParam(r, "id")

	query := "DELETE FROM inventory WHERE id = $1 AND organization_id = $2"
	cmd, err := h.db.Pool.Exec(r.Context(), query, id, orgID)
	if err != nil {
		http.Error(w, `{"error": "Database error"}`, http.StatusInternalServerError)
		return
	}

	if cmd.RowsAffected() == 0 {
		http.Error(w, `{"error": "Inventory item not found or access denied"}`, http.StatusNotFound)
		return
	}

	// Log audit
	audit.Log(r.Context(), h.db, "DELETE_INVENTORY", "inventory", id, nil)

	// WS Broadcast
	h.hub.Broadcast(orgID, map[string]interface{}{
		"event": "inventory_deleted",
		"id":    id,
	})

	w.WriteHeader(http.StatusOK)
	_, _ = w.Write([]byte(`{"status": "deleted"}`))
}
