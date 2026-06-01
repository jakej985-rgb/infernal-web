-- Add is_deleted column to support soft deletes during synchronization
ALTER TABLE clients ADD COLUMN IF NOT EXISTS is_deleted BOOLEAN NOT NULL DEFAULT FALSE;
ALTER TABLE appointments ADD COLUMN IF NOT EXISTS is_deleted BOOLEAN NOT NULL DEFAULT FALSE;
ALTER TABLE inventory ADD COLUMN IF NOT EXISTS is_deleted BOOLEAN NOT NULL DEFAULT FALSE;
ALTER TABLE documents ADD COLUMN IF NOT EXISTS is_deleted BOOLEAN NOT NULL DEFAULT FALSE;
ALTER TABLE communications ADD COLUMN IF NOT EXISTS is_deleted BOOLEAN NOT NULL DEFAULT FALSE;

-- Align inventory columns with the Flutter app domain model
ALTER TABLE inventory ADD COLUMN IF NOT EXISTS category VARCHAR(100) NOT NULL DEFAULT 'General';
ALTER TABLE inventory ADD COLUMN IF NOT EXISTS unit VARCHAR(20) NOT NULL DEFAULT 'pcs';
ALTER TABLE inventory ADD COLUMN IF NOT EXISTS supplier VARCHAR(255);
ALTER TABLE inventory ADD COLUMN IF NOT EXISTS last_ordered_at TIMESTAMP WITH TIME ZONE;

-- Add updated_at index for performant delta sync queries
CREATE INDEX IF NOT EXISTS idx_clients_updated ON clients(updated_at);
CREATE INDEX IF NOT EXISTS idx_appointments_updated ON appointments(updated_at);
CREATE INDEX IF NOT EXISTS idx_inventory_updated ON inventory(updated_at);
CREATE INDEX IF NOT EXISTS idx_documents_updated ON documents(updated_at);
CREATE INDEX IF NOT EXISTS idx_communications_updated ON communications(updated_at);
