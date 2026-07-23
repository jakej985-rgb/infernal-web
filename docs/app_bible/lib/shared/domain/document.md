# Code Chronicle — document.dart

## 📂 File Registry
* **Workspace Path**: `app/lib/shared/domain/document.dart`
* **Type**: Data Model / Utility

## 📖 Operational Purpose
Document entity matching legacy Domain/Document.cs Represents a file upload attached to a client (waivers, reference images, etc.) Primary key Sync identifier for multi-device sync Foreign key to User who uploaded Foreign key to Client Document title/name File storage path Upload timestamp Last modification timestamp (UTC) User who last modified this record Soft delete flag Private constructor for custom getters File extension from path Whether this is an image file Whether this is a PDF file Create from JSON

---

## ⛓️ Import Dependencies
* `package:freezed_annotation/freezed_annotation.dart`

---

---

## 🛡️ Verification Tiers
* **Static Analysis**: Verified via `flutter analyze` linter constraints.
* **Coverage**: Audited against unit and widget test pipelines.
