package database

import (
	"context"
	"fmt"
	"log/slog"
	"os"
	"path/filepath"
	"strings"
	"time"

	"github.com/jackc/pgx/v5/pgxpool"
)

type DB struct {
	Pool *pgxpool.Pool
}

func Connect(ctx context.Context, databaseURL string) (*DB, error) {
	config, err := pgxpool.ParseConfig(databaseURL)
	if err != nil {
		return nil, fmt.Errorf("unable to parse database url: %w", err)
	}

	// Configure pool parameters
	config.MaxConns = 10
	config.MinConns = 2
	config.MaxConnIdleTime = 30 * time.Minute

	var pool *pgxpool.Pool
	for i := 0; i < 5; i++ {
		pool, err = pgxpool.NewWithConfig(ctx, config)
		if err == nil {
			err = pool.Ping(ctx)
			if err == nil {
				break
			}
		}
		slog.Warn("Retrying database connection...", "attempt", i+1, "delay", "2s")
		time.Sleep(2 * time.Second)
	}

	if err != nil {
		return nil, fmt.Errorf("unable to connect to database: %w", err)
	}

	return &DB{Pool: pool}, nil
}

func (db *DB) Close() {
	if db.Pool != nil {
		db.Pool.Close()
	}
}

func (db *DB) Ping(ctx context.Context) error {
	return db.Pool.Ping(ctx)
}

func (db *DB) RunMigrations(ctx context.Context, migrationsDir string) error {
	// Create schema_migrations table if not exists
	_, err := db.Pool.Exec(ctx, `
		CREATE TABLE IF NOT EXISTS schema_migrations (
			version VARCHAR(255) PRIMARY KEY,
			applied_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
		);
	`)
	if err != nil {
		return fmt.Errorf("failed to create schema_migrations table: %w", err)
	}

	files, err := os.ReadDir(migrationsDir)
	if err != nil {
		return fmt.Errorf("failed to read migrations directory: %w", err)
	}

	for _, file := range files {
		if file.IsDir() || !strings.HasSuffix(file.Name(), ".up.sql") {
			continue
		}

		version := file.Name()
		var exists bool
		err = db.Pool.QueryRow(ctx, "SELECT EXISTS(SELECT 1 FROM schema_migrations WHERE version = $1)", version).Scan(&exists)
		if err != nil {
			return fmt.Errorf("failed to check migration state for %s: %w", version, err)
		}

		if exists {
			continue
		}

		slog.Info("Applying database migration", "version", version)
		content, err := os.ReadFile(filepath.Join(migrationsDir, version))
		if err != nil {
			return fmt.Errorf("failed to read migration file %s: %w", version, err)
		}

		tx, err := db.Pool.Begin(ctx)
		if err != nil {
			return fmt.Errorf("failed to begin transaction: %w", err)
		}
		defer tx.Rollback(ctx)

		if _, err := tx.Exec(ctx, string(content)); err != nil {
			return fmt.Errorf("failed to execute migration sql in %s: %w", version, err)
		}

		if _, err := tx.Exec(ctx, "INSERT INTO schema_migrations (version) VALUES ($1)", version); err != nil {
			return fmt.Errorf("failed to record migration status for %s: %w", version, err)
		}

		if err := tx.Commit(ctx); err != nil {
			return fmt.Errorf("failed to commit migration transaction: %w", err)
		}
		slog.Info("Successfully applied database migration", "version", version)
	}

	return nil
}
