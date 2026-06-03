package websocket

import (
	"encoding/json"
	"log/slog"
	"sync"

	"github.com/gorilla/websocket"
)

type Client struct {
	Conn           *websocket.Conn
	OrganizationID string
	writeMu        sync.Mutex
}

type Hub struct {
	mu          sync.RWMutex
	connections map[string]map[*Client]bool
}

func NewHub() *Hub {
	return &Hub{
		connections: make(map[string]map[*Client]bool),
	}
}

func (h *Hub) Register(client *Client) {
	h.mu.Lock()
	defer h.mu.Unlock()

	if _, exists := h.connections[client.OrganizationID]; !exists {
		h.connections[client.OrganizationID] = make(map[*Client]bool)
	}
	h.connections[client.OrganizationID][client] = true
	slog.Info("WebSocket client registered", "orgID", client.OrganizationID)
}

func (h *Hub) Unregister(client *Client) {
	h.mu.Lock()
	defer h.mu.Unlock()

	if clients, exists := h.connections[client.OrganizationID]; exists {
		if _, ok := clients[client]; ok {
			delete(clients, client)
			client.Conn.Close()
			if len(clients) == 0 {
				delete(h.connections, client.OrganizationID)
			}
			slog.Info("WebSocket client unregistered", "orgID", client.OrganizationID)
		}
	}
}

func (h *Hub) Broadcast(orgID string, message interface{}) {
	h.mu.RLock()
	defer h.mu.RUnlock()

	clients, exists := h.connections[orgID]
	if !exists || len(clients) == 0 {
		return
	}

	payload, err := json.Marshal(message)
	if err != nil {
		slog.Error("Failed to marshal WebSocket message", "error", err)
		return
	}

	for client := range clients {
		go func(c *Client) {
			c.writeMu.Lock()
			err := c.Conn.WriteMessage(websocket.TextMessage, payload)
			c.writeMu.Unlock()
			if err != nil {
				slog.Warn("Failed to write to client socket, removing connection...", "error", err)
				h.Unregister(c)
			}
		}(client)
	}
}
