# Document

## Purpose

Represents a legal consent sheet, medical liability waiver, stencil reference sketch, or client file archive uploaded to the application, known as a **Treaty** or **Scroll**. It maintains digital metadata and local sandboxed file path mappings for customer validation records.

## Responsibilities

* Persist metadata for uploaded legal waivers, stencils, and liability forms.
* Store safe, sandboxed file path mappings pointing to local disk directories.
* Track file properties (sizes, types) to prevent system storage bloat.
* Associate files directly with a specific Client (Soul) profile for rapid audit and lookups.

## Properties

* `id` (`int`): Primary domain identification key.
* `syncId` (`String`): Globally unique identifier (UUID) for offline synchronization and replication.
* `clientId` (`int`): Foreign key identifying the associated parent [Client](./client.md) (Soul) who signed or owns the treaty.
* `title` (`String`): Descriptive display title of the document (e.g., `"Full Back Consent Waiver"`, `"Chest Tattoo Stencil Sketch"`).
* `filePath` (`String`): Local storage path referencing the copied image or PDF file on the device filesystem.
* `fileSize` (`int`): Size of the local binary file in bytes.
* `mimeType` (`String?`): Standard MIME format string (e.g., `"image/jpeg"`, `"application/pdf"`, `"image/png"`).
* `uploadedAt` (`DateTime`): Timestamp tracking when the document was first inscribed into the database (UTC).
* `lastModifiedUtc` (`DateTime`): Timestamp of the last local update (UTC).
* `lastModifiedBy` (`String`): Signature tag of the user/operator auditing or performing the last modification.
* `isDeleted` (`bool`): Soft-delete flag utilized for synchronization compatibility.

---

## Methods

### Commands

* `Document.fromJson(Map<String, dynamic> json)`: Reconstructs a Document instance from serialized JSON maps.

### Queries

* `bool get isPdf`: Computed query returning `true` if `mimeType` is `"application/pdf"`.
* `bool get isImage`: Computed query returning `true` if `mimeType` starts with `"image/"`.
* `String get fileSizeFormatted`: Converts raw `fileSize` bytes into a readable string (e.g., `"1.4 MB"`, `"450 KB"`).
* `toJson()` (`Map<String, dynamic>`): Serializes document metadata.

---

## Validation Rules

* **Title**: Must not be empty or consist solely of whitespace.
* **File Path**: Standard file path must be verified to exist on the filesystem during upload commands.
* **Size Limitations**: Raw `fileSize` must be strictly less than 15,728,640 bytes (15MB) to protect device storage.
* **Parent Association**: Must point to a valid registered `clientId` in the customer ledger.

---

## Relationships

### Owns

* **Local Disk File Asset**: Direct mapping to the binary image/PDF saved on the device filesystem.

### Owned By

* **Client** ([Client](./client.md)): Directly owned by the client who signed or provided the document.

### Uses

* None.

### Used By

* **Waivers & Documents Feature** (`WaiverFeature`): Managed by features handling upload pipelines, soft deletes, and file copy operations.
* **Document Vault Screens** (`DocumentScreens`): Rendered in grid and detail view interfaces, upload forms, and client profile sub-tabs.

---

## Future Expansion

* **Cryptographic Signing Service**: Dedicated signing engine where the document metadata registers a SHA-256 checksum matching the hand-drawn signature bytes before writing to database logs.
* **Cloud Backup Optimizer**: Local sync process that sends binary file copies to private Supabase or S3 storage in the background.

---

## Open Questions

* Should we introduce a `documentType` enum (e.g., `waiver`, `stencil`, `referencePhoto`) to make catalog grouping cleaner? (Currently derived based on the title, file format, and client notes).
