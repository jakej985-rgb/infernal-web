package config

import (
	"log/slog"
	"os"

	"github.com/joho/godotenv"
)

type Config struct {
	Port        string
	DatabaseURL string
	Env         string
	JWTSecret   string
}

func LoadConfig() (*Config, error) {
	// Try to load .env file if it exists, ignore error if it doesn't
	if err := godotenv.Load(); err != nil {
		slog.Warn("No .env file found, relying on system environment variables", "error", err)
	}

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	dbUser := os.Getenv("DB_USER")
	dbPass := os.Getenv("DB_PASS")
	dbName := os.Getenv("DB_NAME")
	dbHost := os.Getenv("DB_HOST")

	var databaseURL string
	if dbUser != "" && dbName != "" && dbHost != "" {
		databaseURL = "user=" + dbUser + " password=" + dbPass + " dbname=" + dbName + " host=" + dbHost + " sslmode=disable"
	} else {
		databaseURL = os.Getenv("DATABASE_URL")
	}

	env := os.Getenv("ENV")
	if env == "" {
		env = "development"
	}

	jwtSecret := os.Getenv("JWT_SECRET")
	if jwtSecret == "" {
		if env == "production" {
			return nil, fmt.Errorf("JWT_SECRET environment variable is required in production")
		}
		slog.Warn("JWT_SECRET not set, using insecure default — DO NOT use in production")
		jwtSecret = "dev-only-insecure-key"
	}

	return &Config{
		Port:        port,
		DatabaseURL: databaseURL,
		Env:         env,
		JWTSecret:   jwtSecret,
	}, nil
}
