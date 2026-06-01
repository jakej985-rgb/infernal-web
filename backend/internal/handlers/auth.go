package handlers

import (
	"encoding/json"
	"errors"
	"net/http"

	"github.com/jackc/pgx/v5"
	"github.com/jakej985-rgb/infernal-web/backend/internal/auth"
	"github.com/jakej985-rgb/infernal-web/backend/internal/database"
	"github.com/jakej985-rgb/infernal-web/backend/internal/middleware"
	"golang.org/x/crypto/bcrypt"
)

type AuthHandler struct {
	db        *database.DB
	jwtSecret string
}

func NewAuthHandler(db *database.DB, jwtSecret string) *AuthHandler {
	return &AuthHandler{
		db:        db,
		jwtSecret: jwtSecret,
	}
}

type RegisterRequest struct {
	OrganizationName string `json:"organization_name"`
	Email            string `json:"email"`
	Password         string `json:"password"`
}

type LoginRequest struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

type AuthResponse struct {
	Token string `json:"token"`
}

func (h *AuthHandler) Register(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")

	var req RegisterRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, `{"error": "Invalid request payload"}`, http.StatusBadRequest)
		return
	}

	if req.OrganizationName == "" || req.Email == "" || req.Password == "" {
		http.Error(w, `{"error": "organization_name, email, and password are required"}`, http.StatusBadRequest)
		return
	}

	// Hash password
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(req.Password), bcrypt.DefaultCost)
	if err != nil {
		http.Error(w, `{"error": "Failed to process password"}`, http.StatusInternalServerError)
		return
	}

	// Transaction to create organization and user
	tx, err := h.db.Pool.Begin(r.Context())
	if err != nil {
		http.Error(w, `{"error": "Database error"}`, http.StatusInternalServerError)
		return
	}
	defer tx.Rollback(r.Context())

	// 1. Create Organization
	var orgID string
	err = tx.QueryRow(r.Context(),
		"INSERT INTO organizations (name) VALUES ($1) RETURNING id",
		req.OrganizationName,
	).Scan(&orgID)
	if err != nil {
		http.Error(w, `{"error": "Failed to create organization"}`, http.StatusInternalServerError)
		return
	}

	// 2. Create User (defaults to role 'owner')
	var userID string
	err = tx.QueryRow(r.Context(),
		"INSERT INTO users (organization_id, email, password_hash, role) VALUES ($1, $2, $3, 'owner') RETURNING id",
		orgID, req.Email, string(hashedPassword),
	).Scan(&userID)
	if err != nil {
		// Handle duplicate email unique constraint error
		http.Error(w, `{"error": "Email is already registered"}`, http.StatusConflict)
		return
	}

	// Commit Transaction
	if err := tx.Commit(r.Context()); err != nil {
		http.Error(w, `{"error": "Database error"}`, http.StatusInternalServerError)
		return
	}

	// Generate JWT Token
	token, err := auth.GenerateToken(userID, req.Email, orgID, "owner", h.jwtSecret)
	if err != nil {
		http.Error(w, `{"error": "Failed to generate token"}`, http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusCreated)
	_ = json.NewEncoder(w).Encode(AuthResponse{Token: token})
}

func (h *AuthHandler) Login(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")

	var req LoginRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, `{"error": "Invalid request payload"}`, http.StatusBadRequest)
		return
	}

	if req.Email == "" || req.Password == "" {
		http.Error(w, `{"error": "email and password are required"}`, http.StatusBadRequest)
		return
	}

	var userID, orgID, passwordHash, role string
	err := h.db.Pool.QueryRow(r.Context(),
		"SELECT id, organization_id, password_hash, role FROM users WHERE email = $1",
		req.Email,
	).Scan(&userID, &orgID, &passwordHash, &role)

	if err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			http.Error(w, `{"error": "Invalid email or password"}`, http.StatusUnauthorized)
			return
		}
		http.Error(w, `{"error": "Database error"}`, http.StatusInternalServerError)
		return
	}

	// Compare password
	if err := bcrypt.CompareHashAndPassword([]byte(passwordHash), []byte(req.Password)); err != nil {
		http.Error(w, `{"error": "Invalid email or password"}`, http.StatusUnauthorized)
		return
	}

	// Generate token
	token, err := auth.GenerateToken(userID, req.Email, orgID, role, h.jwtSecret)
	if err != nil {
		http.Error(w, `{"error": "Failed to generate token"}`, http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusOK)
	_ = json.NewEncoder(w).Encode(AuthResponse{Token: token})
}

type UserProfileResponse struct {
	UserID         string `json:"user_id"`
	Email          string `json:"email"`
	OrganizationID string `json:"organization_id"`
	Role           string `json:"role"`
}

func (h *AuthHandler) Me(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")

	userID := middleware.GetUserID(r.Context())
	email := middleware.GetEmail(r.Context())
	orgID := middleware.GetOrganizationID(r.Context())
	role := middleware.GetRole(r.Context())

	response := UserProfileResponse{
		UserID:         userID,
		Email:          email,
		OrganizationID: orgID,
		Role:           role,
	}

	w.WriteHeader(http.StatusOK)
	_ = json.NewEncoder(w).Encode(response)
}
