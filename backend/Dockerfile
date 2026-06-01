# ---------- BUILD STAGE ----------
FROM golang:alpine AS build

WORKDIR /app

# Copy dependency files and download
COPY go.mod go.sum ./
RUN go mod download

# Copy source code
COPY . .

# Build clean static binary
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -o server ./cmd/server/main.go

# ---------- RUN STAGE ----------
FROM alpine:latest

# Install CA certs for outbound SSL/TLS connections
RUN apk --no-cache add ca-certificates

WORKDIR /app

# Copy binary and migrations from build stage
COPY --from=build /app/server .
COPY --from=build /app/migrations ./migrations

EXPOSE 8080

CMD ["./server"]
