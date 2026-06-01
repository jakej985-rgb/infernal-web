package handlers

import (
	"context"
	"encoding/json"
	"net/http"
	"time"

	"github.com/jakej985-rgb/infernal-web/backend/internal/database"
)

type HealthHandler struct {
	db *database.DB
}

func NewHealthHandler(db *database.DB) *HealthHandler {
	return &HealthHandler{db: db}
}

type HealthResponse struct {
	Status    string    `json:"status"`
	Database  string    `json:"database"`
	Timestamp time.Time `json:"timestamp"`
}

func (h *HealthHandler) HealthCheck(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")

	ctx, cancel := context.WithTimeout(r.Context(), 2*time.Second)
	defer cancel()

	dbStatus := "connected"
	statusCode := http.StatusOK

	if err := h.db.Ping(ctx); err != nil {
		dbStatus = "disconnected"
		statusCode = http.StatusServiceUnavailable
	}

	response := HealthResponse{
		Status:    "ok",
		Database:  dbStatus,
		Timestamp: time.Now(),
	}

	w.WriteHeader(statusCode)
	_ = json.NewEncoder(w).Encode(response)
}
