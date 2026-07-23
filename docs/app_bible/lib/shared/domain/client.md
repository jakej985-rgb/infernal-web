# Code Chronicle — client.dart

## 📂 File Registry
* **Workspace Path**: `app/lib/shared/domain/client.dart`
* **Type**: Data Model / Utility

## 📖 Operational Purpose
Client entity matching legacy Domain/Client.cs Represents a customer in the tattoo shop system. Primary key Sync identifier for multi-device sync First name Middle name (optional) Last name Phone number Email address Free-form notes about the client Number of visits Path to profile photo Client status (Bound/FreshSoul/HighValue/Void) Creation timestamp (UTC) Last modification timestamp (UTC) User who last modified this record Soft delete flag Private constructor for custom getters Computed full name from parts Create from JSON

---

## ⛓️ Import Dependencies
* `package:freezed_annotation/freezed_annotation.dart`
* `enums.dart`

---

---

## 🛡️ Verification Tiers
* **Static Analysis**: Verified via `flutter analyze` linter constraints.
* **Coverage**: Audited against unit and widget test pipelines.
