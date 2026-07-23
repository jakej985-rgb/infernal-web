# Code Chronicle — auth_service.dart

## 📂 File Registry
* **Workspace Path**: `app/lib/features/auth/domain/auth_service.dart`
* **Type**: Data Model / Utility

## 📖 Operational Purpose
Explicitly initialize user profile document in Supabase after sign-up/login if missing.

---

## ⛓️ Import Dependencies
* `dart:async`
* `package:flutter/foundation.dart`
* `package:riverpod_annotation/riverpod_annotation.dart`
* `../../../shared/cache/id_mapper.dart`
* `../../../shared/core/services/user_service.dart`
* `../../../shared/domain/user.dart`
* `auth_state.dart`

---

## ⚙️ Methods & Routines (CQS Boundaries)
* **`Exception()`**: Handles data retrieval queries (Query).
* **`logout()`**: Handles data retrieval queries (Query).
* **`approveShopRequest()`**: Handles state mutation commands (Command).
* **`rejectShopRequest()`**: Handles state mutation commands (Command).
* **`seedAdmin()`**: Handles data retrieval queries (Query).
* **`initializeUserProfile()`**: Handles data retrieval queries (Query).
* **`login()`**: Handles data retrieval queries (Query).
* **`build()`**: Handles data retrieval queries (Query).

---

## 🛡️ Verification Tiers
* **Static Analysis**: Verified via `flutter analyze` linter constraints.
* **Coverage**: Audited against unit and widget test pipelines.
