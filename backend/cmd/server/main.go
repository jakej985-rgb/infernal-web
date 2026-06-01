package main

import (
	"context"
	"errors"
	"log/slog"
	"net/http"
	"os"
	"os/signal"
	"syscall"
	"time"

	"github.com/jakej985-rgb/infernal-web/backend/internal/config"
	"github.com/jakej985-rgb/infernal-web/backend/internal/database"
	"github.com/jakej985-rgb/infernal-web/backend/internal/router"
	"github.com/jakej985-rgb/infernal-web/backend/internal/websocket"
)

func main() {
	// Configure global structured JSON logger
	logger := slog.New(slog.NewJSONHandler(os.Stdout, nil))
	slog.SetDefault(logger)

	slog.Info("Starting Go backend service...")

	// 1. Load config
	cfg, err := config.LoadConfig()
	if err != nil {
		slog.Error("Failed to load config", "error", err)
		os.Exit(1)
	}

	if cfg.DatabaseURL == "" {
		slog.Error("DATABASE_URL environment variable is required")
		os.Exit(1)
	}

	// Create root background context
	ctx, stop := signal.NotifyContext(context.Background(), os.Interrupt, syscall.SIGTERM)
	defer stop()

	// 2. Connect to database
	slog.Info("Connecting to Postgres database...")
	db, err := database.Connect(ctx, cfg.DatabaseURL)
	if err != nil {
		slog.Error("Failed to connect to database", "error", err)
		os.Exit(1)
	}
	defer db.Close()
	slog.Info("Connected to Postgres database successfully.")

	// 3. Run database migrations
	slog.Info("Running database migrations...")
	migrationsDir := os.Getenv("MIGRATIONS_DIR")
	if migrationsDir == "" {
		migrationsDir = "migrations"
	}
	if err := db.RunMigrations(ctx, migrationsDir); err != nil {
		slog.Error("Failed to run migrations", "error", err)
		os.Exit(1)
	}
	slog.Info("Database migrations applied successfully.")

	// 4. Initialize real-time WebSocket Hub
	hub := websocket.NewHub()

	// 5. Initialize router
	r := router.NewRouter(db, cfg.JWTSecret, hub)

	// 5. Start HTTP server
	srv := &http.Server{
		Addr:    ":" + cfg.Port,
		Handler: r,
	}

	go func() {
		slog.Info("Server listening", "port", cfg.Port)
		if err := srv.ListenAndServe(); err != nil && !errors.Is(err, http.ErrServerClosed) {
			slog.Error("Server ListenAndServe failed", "error", err)
			os.Exit(1)
		}
	}()

	// Wait for interruption signal
	<-ctx.Done()
	slog.Info("Shutting down server gracefully...")

	// Create a timeout context for shutdown
	shutdownCtx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	if err := srv.Shutdown(shutdownCtx); err != nil {
		slog.Error("Server forced to shutdown", "error", err)
	}

	slog.Info("Go backend service stopped.")
}
