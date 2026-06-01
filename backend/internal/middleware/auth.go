package middleware

import (
	"context"
	"net/http"
	"strings"

	"github.com/jakej985-rgb/infernal-web/backend/internal/auth"
)

type contextKey string

const (
	UserIDKey         contextKey = "userID"
	EmailKey          contextKey = "email"
	OrganizationIDKey contextKey = "organizationID"
	RoleKey           contextKey = "role"
)

// AuthMiddleware extracts the JWT token from the authorization header and injects claims into context
func AuthMiddleware(secret string) func(http.Handler) http.Handler {
	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			authHeader := r.Header.Get("Authorization")
			if authHeader == "" {
				http.Error(w, `{"error": "Authorization header is required"}`, http.StatusUnauthorized)
				return
			}

			parts := strings.Split(authHeader, " ")
			if len(parts) != 2 || strings.ToLower(parts[0]) != "bearer" {
				http.Error(w, `{"error": "Authorization header must be Bearer token"}`, http.StatusUnauthorized)
				return
			}

			tokenString := parts[1]
			claims, err := auth.ValidateToken(tokenString, secret)
			if err != nil {
				http.Error(w, `{"error": "Invalid or expired token"}`, http.StatusUnauthorized)
				return
			}

			// Inject claims into context
			ctx := context.WithValue(r.Context(), UserIDKey, claims.UserID)
			ctx = context.WithValue(ctx, EmailKey, claims.Email)
			ctx = context.WithValue(ctx, OrganizationIDKey, claims.OrganizationID)
			ctx = context.WithValue(ctx, RoleKey, claims.Role)

			next.ServeHTTP(w, r.WithContext(ctx))
		})
	}
}

// RequireRole checks if the injected role matches the list of allowed roles
func RequireRole(allowedRoles ...string) func(http.Handler) http.Handler {
	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			userRole, ok := r.Context().Value(RoleKey).(string)
			if !ok || userRole == "" {
				http.Error(w, `{"error": "Unauthorized"}`, http.StatusUnauthorized)
				return
			}

			roleAllowed := false
			for _, role := range allowedRoles {
				if strings.ToLower(userRole) == strings.ToLower(role) {
					roleAllowed = true
					break
				}
			}

			if !roleAllowed {
				http.Error(w, `{"error": "Forbidden: insufficient permissions"}`, http.StatusForbidden)
				return
			}

			next.ServeHTTP(w, r)
		})
	}
}

// Context Helpers
func GetUserID(ctx context.Context) string {
	val, _ := ctx.Value(UserIDKey).(string)
	return val
}

func GetEmail(ctx context.Context) string {
	val, _ := ctx.Value(EmailKey).(string)
	return val
}

func GetOrganizationID(ctx context.Context) string {
	val, _ := ctx.Value(OrganizationIDKey).(string)
	return val
}

func GetRole(ctx context.Context) string {
	val, _ := ctx.Value(RoleKey).(string)
	return val
}
