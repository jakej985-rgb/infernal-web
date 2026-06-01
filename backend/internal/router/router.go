package router

import (
	"github.com/go-chi/chi/v5"
	chimiddleware "github.com/go-chi/chi/v5/middleware"
	"github.com/jakej985-rgb/infernal-web/backend/internal/database"
	"github.com/jakej985-rgb/infernal-web/backend/internal/handlers"
	mw "github.com/jakej985-rgb/infernal-web/backend/internal/middleware"
	ws "github.com/jakej985-rgb/infernal-web/backend/internal/websocket"
)

func NewRouter(db *database.DB, jwtSecret string, hub *ws.Hub) *chi.Mux {
	r := chi.NewRouter()

	// Global Middlewares
	r.Use(chimiddleware.Logger)
	r.Use(chimiddleware.Recoverer)

	// Handlers
	healthHandler := handlers.NewHealthHandler(db)
	authHandler := handlers.NewAuthHandler(db, jwtSecret)
	wsHandler := handlers.NewWebSocketHandler(hub, jwtSecret)
	clientsHandler := handlers.NewClientsHandler(db, hub)
	appointmentsHandler := handlers.NewAppointmentsHandler(db, hub)
	inventoryHandler := handlers.NewInventoryHandler(db, hub)
	documentsHandler := handlers.NewDocumentsHandler(db, hub, "/app/uploads")
	communicationsHandler := handlers.NewCommunicationsHandler(db, hub)
	syncHandler := handlers.NewSyncHandler(db)

	// Public Routes
	r.Get("/health", healthHandler.HealthCheck)
	r.Post("/auth/register", authHandler.Register)
	r.Post("/auth/login", authHandler.Login)
	r.Get("/ws", wsHandler.Handle)

	// Protected Routes
	r.Group(func(r chi.Router) {
		r.Use(mw.AuthMiddleware(jwtSecret))
		r.Get("/auth/me", authHandler.Me)

		// Sync Engine
		r.Post("/sync", syncHandler.Sync)

		// Clients CRUD
		r.Get("/clients", clientsHandler.List)
		r.Post("/clients", clientsHandler.Create)
		r.Get("/clients/{id}", clientsHandler.Get)
		r.Put("/clients/{id}", clientsHandler.Update)
		r.Delete("/clients/{id}", clientsHandler.Delete)

		// Appointments CRUD
		r.Get("/appointments", appointmentsHandler.List)
		r.Post("/appointments", appointmentsHandler.Create)
		r.Get("/appointments/{id}", appointmentsHandler.Get)
		r.Put("/appointments/{id}", appointmentsHandler.Update)
		r.Delete("/appointments/{id}", appointmentsHandler.Delete)

		// Inventory CRUD
		r.Get("/inventory", inventoryHandler.List)
		r.Post("/inventory", inventoryHandler.Create)
		r.Put("/inventory/{id}", inventoryHandler.Update)
		r.Delete("/inventory/{id}", inventoryHandler.Delete)

		// Documents CRUD
		r.Get("/documents", documentsHandler.List)
		r.Post("/documents/upload", documentsHandler.Upload)
		r.Delete("/documents/{id}", documentsHandler.Delete)

		// Communications CRUD
		r.Get("/communications", communicationsHandler.List)
		r.Post("/communications", communicationsHandler.Create)
		r.Delete("/communications/{id}", communicationsHandler.Delete)
	})

	return r
}
