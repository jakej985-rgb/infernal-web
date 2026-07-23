# Code Chronicle — clients_provider.dart

## 📂 File Registry
* **Workspace Path**: `app/lib/features/clients/data/clients_provider.dart`
* **Type**: Data Model / Utility

## 📖 Operational Purpose
Defines the implementation and structures for clients_provider.dart.

---

## ⛓️ Import Dependencies
* `package:riverpod_annotation/riverpod_annotation.dart`
* `package:rxdart/rxdart.dart`
* `../../../../shared/data/interfaces/client_service.dart`
* `../../../../shared/core/services/client_service_supabase_impl.dart`
* `../../../../shared/domain/client_lifecycle.dart`
* `../../appointments/data/appointments_provider.dart`

---

## ⚡ State Providers & Notifiers
* **Provider Key**: `filteredClientsWithLifecycle` (Riverpod container reactive handle)
* **Provider Key**: `clientService` (Riverpod container reactive handle)

## ⚙️ Methods & Routines (CQS Boundaries)
* **`clientService()`**: Handles data retrieval queries (Query).
* **`set()`**: Handles state mutation commands (Command).
* **`ClientServiceSupabaseImpl()`**: Handles data retrieval queries (Query).
* **`_filterClients()`**: Handles data retrieval queries (Query).
* **`build()`**: Handles data retrieval queries (Query).

---

## 🛡️ Verification Tiers
* **Static Analysis**: Verified via `flutter analyze` linter constraints.
* **Coverage**: Audited against unit and widget test pipelines.
