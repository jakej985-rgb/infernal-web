# Feature — Waivers & File Archives

## Purpose

Supports the electronic management of crucial studio legal artifacts, medical declaration waivers, and reference assets, colloquially defined as **Treaties** or **Scrolls**. This maintains digital records of customer consent and protects the studio from liability risks.

## User Flow

1. **Accessing the Vault**: The user navigates to `/documents` or selects the "Scrolls" tab on a specific client profile page.
2. **Uploading a Treaty**: The operator clicks "Upload Scroll". A form prompts them to input a title (e.g., "Full Back Consent Waiver") and select the target client.
3. **Binary Assignment**: Using tablet controls, the operator clicks "Capture", launches the device camera, snap-shoots a signed paper waiver or a design sketch, and saves it locally.
4. **Filing the Upload**: Tapping "Inscribe Scroll" writes the record metadata to SQLite, copy-writes the image or PDF to the local app folder, and logs the upload in system logs.
5. **Viewing and Printing**: Clicking any list item displays a clean visual preview.

---

## Classes Used

* [Document](../classes/document.md) (The active persistent metadata schema)
* [Client](../classes/client.md) (The customer who signed the treaty)
* [User](../classes/user.md) (The operator auditing the entry)

---

## Commands

* `uploadDocument(Document document, String localTempPath)`: Copies the binary file to safe, sandboxed app folders, generates UUIDs, and writes metadata coordinates to the database.
* `deleteDocument(int docId)`: Triggers a soft-delete toggle (`isDeleted = true`) on the target metadata row to hide it from standard directories, while preserving binary files for archival audits.

---

## Queries

* `List<Document> getDocumentsForClient(int clientId)`: Dynamic query retrieving all active, non-deleted documents attached to the target client.
* `Document? getDocumentById(int docId)`: Fetches a single record's file references.

---

## Validation

* **Completeness**: Title strings and valid file paths are mandatory.
* **Size Limitations**: Form controls restrict image/PDF file sizes to under 15MB to prevent offline device storage bloat.

---

## Edge Cases

* **Missing Files**: If a local binary file is deleted from the tablet's file folders but remains in the database, the UI displays a warning caution icon and allows the operator to click "Re-Upload".

---

## Future Ideas

* **In-App Drawing Waivers**: Standard templates loaded inside the application, allowing clients to review text and sign directly using stylus inputs on tablets.
* **Cryptographic PDF Seals**: Compiling completed metadata and hand-drawn signatures into secure PDF files stamped with local sha256 hashes to prevent tampering.
