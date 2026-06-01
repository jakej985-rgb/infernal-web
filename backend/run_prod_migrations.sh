#!/bin/bash

# Fail on errors
set -e

# Default settings
INSTANCE_CONNECTION_NAME="m3tal-project:us-central1:infernal-db"
PROXY_PORT=5433  # Use 5433 to avoid conflicts with local postgres
DB_NAME="infernal"

echo "=========================================================="
echo "      Cloud SQL Production Migrations Helper Script       "
echo "=========================================================="

# Check if migrate tool is installed
if ! command -v migrate &> /dev/null; then
    echo "❌ Error: 'migrate' command line tool is not installed."
    echo "Please download it from: https://github.com/golang-migrate/migrate/releases"
    exit 1
fi

# Check if cloud-sql-proxy is installed
if ! command -v cloud-sql-proxy &> /dev/null && [ ! -f "./cloud-sql-proxy" ]; then
    echo "📥 Downloading Cloud SQL Auth Proxy..."
    curl -sSL -o cloud-sql-proxy https://storage.googleapis.com/cloud-sql-connectors/cloud-sql-proxy/v2.11.0/cloud-sql-proxy.linux.amd64
    chmod +x cloud-sql-proxy
fi

PROXY_CMD="cloud-sql-proxy"
if [ -f "./cloud-sql-proxy" ]; then
    PROXY_CMD="./cloud-sql-proxy"
fi

# Prompt for credentials
read -p "Enter Database Username [postgres]: " DB_USER
DB_USER=${DB_USER:-postgres}

read -sp "Enter Database Password: " DB_PASS
echo ""

if [ -z "$DB_PASS" ]; then
    echo "❌ Error: Password cannot be empty."
    exit 1
fi

read -p "Enter Migration Command (up/down/force) [up]: " ACTION
ACTION=${ACTION:-up}

# Check if we need version argument for force/down
EXTRA_ARGS=""
if [ "$ACTION" == "down" ]; then
    read -p "Enter number of migrations to roll back [1]: " STEPS
    STEPS=${STEPS:-1}
    EXTRA_ARGS="$STEPS"
elif [ "$ACTION" == "force" ]; then
    read -p "Enter version version to force: " VERSION
    if [ -z "$VERSION" ]; then
        echo "❌ Error: Version is required for force command."
        exit 1
    fi
    EXTRA_ARGS="$VERSION"
fi

echo "🚀 Starting Cloud SQL Auth Proxy on port $PROXY_PORT..."
# Start proxy in background and store PID
$PROXY_CMD $INSTANCE_CONNECTION_NAME --port $PROXY_PORT &
PROXY_PID=$!

# Ensure we terminate proxy on exit or error
cleanup() {
    echo "🧹 Stopping Cloud SQL Auth Proxy..."
    kill $PROXY_PID 2>/dev/null || true
}
trap cleanup EXIT

# Wait a couple of seconds for proxy to bind port
sleep 2

# Connection string
DB_URL="postgres://${DB_USER}:${DB_PASS}@localhost:${PROXY_PORT}/${DB_NAME}?sslmode=disable"

echo "⚡ Running migrations ($ACTION)..."
migrate -path ./migrations -database "$DB_URL" $ACTION $EXTRA_ARGS

echo "✅ Migrations completed successfully!"
