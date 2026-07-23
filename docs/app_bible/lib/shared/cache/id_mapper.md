# Code Chronicle — id_mapper.dart

## 📂 File Registry
* **Workspace Path**: `app/lib/shared/cache/id_mapper.dart`
* **Type**: Data Model / Utility

## 📖 Operational Purpose
Registers a UUID and returns its stable, unique 31-bit positive integer ID. If the UUID already has an integer ID, that ID is returned. Otherwise, a new stable integer ID is generated, cached, and persisted. Look up UUID by integer ID for a specific entity type Look up integer ID by UUID for a specific entity type

---

## ⛓️ Import Dependencies
* `dart:convert`
* `package:flutter/foundation.dart`
* `package:riverpod_annotation/riverpod_annotation.dart`
* `package:shared_preferences/shared_preferences.dart`
* `../util/shared_prefs_provider.dart`

---

## 🏛️ Declared Classes
### `class IdMapper`
* Represents a structured code construct mapping business logic or view layouts for id_mapper.dart.

## ⚙️ Methods & Routines (CQS Boundaries)
* **`_saveMappings()`**: Handles state mutation commands (Command).
* **`IdMapper()`**: Handles data retrieval queries (Query).
* **`registerUuid()`**: Handles data retrieval queries (Query).
* **`_loadMappings()`**: Handles data retrieval queries (Query).
* **`idMapper()`**: Handles data retrieval queries (Query).

---

## 🛡️ Verification Tiers
* **Static Analysis**: Verified via `flutter analyze` linter constraints.
* **Coverage**: Audited against unit and widget test pipelines.
