package audit

import (
	"context"
	"encoding/json"
	"log/slog"

	"github.com/jakej985-rgb/infernal-web/backend/internal/database"
	"github.com/jakej985-rgb/infernal-web/backend/internal/middleware"
)

func Log(ctx context.Context, db *database.DB, action, entityType, entityID string, details interface{}) {
	orgID := middleware.GetOrganizationID(ctx)
	userID := middleware.GetUserID(ctx)

	if orgID == "" {
		slog.Warn("Skipping audit log: organization_id is missing from context", "action", action)
		return
	}

	var detailsJSON []byte
	var err error
	if details != nil {
		detailsJSON, err = json.Marshal(details)
		if err != nil {
			slog.Error("Failed to marshal audit details", "error", err)
		}
	}

	query := `
		INSERT INTO audit_logs (organization_id, user_id, action, entity_type, entity_id, details)
		VALUES ($1, $2, $3, $4, $5, $6)
	`

	var uID *string
	if userID != "" {
		uID = &userID
	}

	// Write asynchronously to avoid blocking the request thread
	go func() {
		_, err := db.Pool.Exec(context.Background(), query, orgID, uID, action, entityType, entityID, detailsJSON)
		if err != nil {
			slog.Error("Failed to write audit log to database", "error", err, "action", action)
		}
	}()
}
