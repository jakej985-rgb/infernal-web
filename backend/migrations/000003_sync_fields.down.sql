-- Remove indexes
DROP INDEX IF EXISTS idx_clients_updated;
DROP INDEX IF EXISTS idx_appointments_updated;
DROP INDEX IF EXISTS idx_inventory_updated;
DROP INDEX IF EXISTS idx_documents_updated;
DROP INDEX IF EXISTS idx_communications_updated;

-- Remove columns from inventory
ALTER TABLE inventory DROP COLUMN IF EXISTS category;
ALTER TABLE inventory DROP COLUMN IF EXISTS unit;
ALTER TABLE inventory DROP COLUMN IF EXISTS supplier;
ALTER TABLE inventory DROP COLUMN IF EXISTS last_ordered_at;

-- Remove is_deleted columns
ALTER TABLE clients DROP COLUMN IF EXISTS is_deleted;
ALTER TABLE appointments DROP COLUMN IF EXISTS is_deleted;
ALTER TABLE inventory DROP COLUMN IF EXISTS is_deleted;
ALTER TABLE documents DROP COLUMN IF EXISTS is_deleted;
ALTER TABLE communications DROP COLUMN IF EXISTS is_deleted;
