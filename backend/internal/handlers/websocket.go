package handlers

import (
	"log/slog"
	"net/http"

	"github.com/gorilla/websocket"
	"github.com/jakej985-rgb/infernal-web/backend/internal/auth"
	ws "github.com/jakej985-rgb/infernal-web/backend/internal/websocket"
)

type WebSocketHandler struct {
	hub       *ws.Hub
	jwtSecret string
}

func NewWebSocketHandler(hub *ws.Hub, jwtSecret string) *WebSocketHandler {
	return &WebSocketHandler{
		hub:       hub,
		jwtSecret: jwtSecret,
	}
}

var upgrader = websocket.Upgrader{
	ReadBufferSize:  1024,
	WriteBufferSize: 1024,
	CheckOrigin: func(r *http.Request) bool {
		return true
	},
}

func (h *WebSocketHandler) Handle(w http.ResponseWriter, r *http.Request) {
	token := r.URL.Query().Get("token")
	if token == "" {
		http.Error(w, `{"error": "Unauthorized: token is required"}`, http.StatusUnauthorized)
		slog.Warn("WebSocket upgrade rejected: missing token query param")
		return
	}

	claims, err := auth.ValidateToken(token, h.jwtSecret)
	if err != nil {
		http.Error(w, `{"error": "Unauthorized: invalid token"}`, http.StatusUnauthorized)
		slog.Warn("WebSocket upgrade rejected: invalid token", "error", err)
		return
	}

	conn, err := upgrader.Upgrade(w, r, nil)
	if err != nil {
		slog.Error("Failed to upgrade HTTP connection to WebSocket", "error", err)
		return
	}

	client := &ws.Client{
		Conn:           conn,
		OrganizationID: claims.OrganizationID,
	}

	h.hub.Register(client)

	// Spin read loop to monitor connection closure
	go func() {
		defer h.hub.Unregister(client)
		for {
			_, _, err := conn.ReadMessage()
			if err != nil {
				slog.Info("WebSocket client disconnected or connection lost", "orgID", client.OrganizationID)
				break
			}
		}
	}()
}
