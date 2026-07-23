# Code Chronicle — router.dart

## 📂 File Registry
* **Workspace Path**: `app/lib/app/router.dart`
* **Type**: Data Model / Utility

## 📖 Operational Purpose
Application router configuration using go_router Route paths as constants Global navigation key Router provider for app-wide access

---

## ⛓️ Import Dependencies
* `package:flutter/foundation.dart`
* `package:flutter/material.dart`
* `package:go_router/go_router.dart`
* `package:flutter_riverpod/flutter_riverpod.dart`
* `../features/auth/presentation/login_page.dart`
* `../features/auth/presentation/register_page.dart`
* `../features/auth/domain/auth_service.dart`
* `../features/admin/presentation/admin_requests_page.dart`
* `../features/auth/domain/auth_state.dart`
* `../features/dashboard/presentation/dashboard_page.dart`
* `../features/appointments/presentation/appointments_list_page.dart`
* `../features/appointments/presentation/appointment_form_page.dart`
* `../features/appointments/presentation/appointment_details_page.dart`
* `../features/clients/presentation/clients_list_page.dart`
* `../features/clients/presentation/client_details_page.dart`
* `../features/clients/presentation/client_form_page.dart`
* `../features/quotes/presentation/quotes_list_page.dart`
* `../features/quotes/presentation/quote_form_page.dart`
* `../features/quotes/presentation/quote_details_page.dart`
* `../features/documents/presentation/documents_list_page.dart`
* `../features/documents/presentation/document_form_page.dart`
* `../features/documents/presentation/document_details_page.dart`
* `../features/settings/presentation/settings_page.dart`
* `../features/settings/presentation/integrations_page.dart`
* `../features/admin/presentation/user_list_page.dart`
* `../features/admin/presentation/user_form_page.dart`
* `../features/admin/presentation/system_status_page.dart`
* `../features/reports/presentation/stats_overview_page.dart`
* `../features/tools/presentation/tools_hub_page.dart`
* `../features/tools/presentation/pain_estimator_page.dart`
* `../features/tools/presentation/flash_roulette_page.dart`
* `../features/inventory/presentation/inventory_hub_page.dart`
* `../features/communications/presentation/communications_hub_page.dart`
* `../shared/widgets/app_shell.dart`

---

## 🏛️ Declared Classes
### `class AppRoutes`
* Represents a structured code construct mapping business logic or view layouts for router.dart.

### `class _GoRouterRefreshNotifier`
* Represents a structured code construct mapping business logic or view layouts for router.dart.

## ⚡ State Providers & Notifiers
* **Provider Key**: `routerProvider` (Riverpod container reactive handle)

## ⚙️ Methods & Routines (CQS Boundaries)
* **`SystemStatusPage()`**: Handles data retrieval queries (Query).
* **`AdminRequestsPage()`**: Handles data retrieval queries (Query).
* **`NoTransitionPage()`**: Handles data retrieval queries (Query).
* **`ClientFormPage()`**: Handles data retrieval queries (Query).
* **`PainEstimatorPage()`**: Handles data retrieval queries (Query).
* **`QuoteFormPage()`**: Handles data retrieval queries (Query).
* **`UserListPage()`**: Handles data retrieval queries (Query).
* **`IntegrationsPage()`**: Handles data retrieval queries (Query).
* **`DocumentFormPage()`**: Handles data retrieval queries (Query).
* **`UserFormPage()`**: Handles data retrieval queries (Query).
* **`AppointmentFormPage()`**: Handles data retrieval queries (Query).
* **`FlashRoulettePage()`**: Handles data retrieval queries (Query).
* **`LoginPage()`**: Handles data retrieval queries (Query).
* **`RegisterPage()`**: Handles data retrieval queries (Query).

---

## 🛡️ Verification Tiers
* **Static Analysis**: Verified via `flutter analyze` linter constraints.
* **Coverage**: Audited against unit and widget test pipelines.
