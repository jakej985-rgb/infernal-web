# Infernal Web - Go Backend Service

This service provides the Go-based API foundation, connected to PostgreSQL.

## 🛠️ Local Development (Docker Compose)

The easiest way to run the service locally is using Docker Compose:

```bash
docker compose up --build
```

This spins up:
1. **`db`**: A Postgres database container mapping port `5432` with persistence volume `infernal_pgdata`.
2. **`backend`**: The Go API service mapping port `8080`.

On startup, the backend automatically runs database migrations located in the `/migrations` folder.

---

## ☁️ Production Database (GCP Cloud SQL)

In production, the backend runs on Google Cloud Run and connects to a Google Cloud SQL Postgres instance:

*   **Instance Name**: `infernal-db`
*   **Connection Name**: `m3tal-project:us-central1:infernal-db`
*   **Database**: `infernal`

### Connection Strategy

Cloud Run uses the **Cloud SQL Connector** to mount the Unix socket of the database instance inside the container.
*   The socket path is: `/cloudsql/m3tal-project:us-central1:infernal-db`
*   In production, the `DATABASE_URL` environment variable should be configured as:
    ```
    postgres://<USER>:<PASSWORD>@/infernal?host=/cloudsql/m3tal-project:us-central1:infernal-db
    ```

---

## 🗄️ Database Migrations

Database migrations are stored in the `/migrations` directory in standard SQL up/down format:
- `000001_init_schema.up.sql`
- `000001_init_schema.down.sql`

### 1. Automatic Migrations (Go Backend)
When the Go backend starts, it runs all pending `.up.sql` files automatically. It tracks migration history in a `schema_migrations` table.

### 2. Manual Migrations (golang-migrate CLI)
To run migrations manually or perform schema rollback against production, use the `golang-migrate` tool.

#### Step A: Run Cloud SQL Auth Proxy
Download the proxy and run it locally to map Cloud SQL port `5432` to your machine:
```bash
curl -o cloud-sql-proxy https://storage.googleapis.com/cloud-sql-connectors/cloud-sql-proxy/v2.11.0/cloud-sql-proxy.linux.amd64
chmod +x cloud-sql-proxy

# Start the proxy (uses local gcloud auth credentials)
./cloud-sql-proxy m3tal-project:us-central1:infernal-db --port 5432
```

#### Step B: Install golang-migrate CLI
On Linux (Ubuntu/Debian):
```bash
curl -L https://github.com/golang-migrate/migrate/releases/download/v4.17.0/migrate.linux-amd64.tar.gz | tar xvz
sudo mv migrate /usr/local/bin/migrate
```

#### Step C: Run Migrations Against Production
With the Cloud SQL Auth Proxy running on port `5432`:

**Apply migrations (UP):**
```bash
migrate -path ./migrations -database "postgres://<USER>:<PASSWORD>@localhost:5432/infernal?sslmode=disable" up
```

**Rollback migrations (DOWN):**
```bash
migrate -path ./migrations -database "postgres://<USER>:<PASSWORD>@localhost:5432/infernal?sslmode=disable" down 1
```
