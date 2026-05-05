# Port Plan — InfernalInkSteelSuite C# → Flutter

> **PhoenixPort Agent** | Created: 2026-01-21

---

## Executive Summary

This document outlines the phased approach to port the **InfernalInkSteelSuite** tattoo shop management system from ASP.NET Core (Razor Pages + Web API) to **Flutter**.

### Target Architecture

- **State Management**: Riverpod 3.x
- **Navigation**: go_router
- **Database**: Drift (SQLite)
- **Structure**: Feature-first folder layout
- **Offline-First**: Local SQLite primary, optional cloud sync

---

## Phase 0: Baseline & Inventory ✅

**Status**: Complete

### Deliverables

- [x] `LEGACY_MAP.md` — Comprehensive legacy codebase documentation
- [x] `PARITY_CHECKLIST.md` — All 97 features inventoried
- [x] `PORT_PLAN.md` — This document

### Key Findings

1. **Legacy is ASP.NET Core MVC + Razor Pages** (not WPF/WinForms)
2. **SQLite database** via both EF Core and raw ADO.NET repositories
3. **18 page groups** with 97 trackable features
4. **Dual auth**: JWT for API, session for Razor Pages
5. **"Infernal" dark theme** with dramatic styling

---

## Phase 1: Flutter Bootstrap ✅

**Status**: Complete (2026-01-21)  
**Target**: Running Flutter app with router skeleton

### Tasks

1. **Create Flutter project**

   ```bash
   flutter create --org com.infernalinksteel --project-name infernal_ink_steel infernal_ink_steel
   ```

2. **Configure dependencies in `pubspec.yaml`**

   ```yaml
   dependencies:
     flutter_riverpod: ^3.0.0
     riverpod_annotation: ^3.0.0
     go_router: ^15.0.0
     drift: ^2.26.0
     sqlite3_flutter_libs: ^0.5.0
     path_provider: ^2.1.0
     freezed_annotation: ^2.4.0
     json_annotation: ^4.9.0
   
   dev_dependencies:
     riverpod_generator: ^3.0.0
     build_runner: ^2.4.0
     freezed: ^2.5.0
     json_serializable: ^6.9.0
     drift_dev: ^2.26.0
     flutter_lints: ^5.0.0
   ```

3. **Create folder structure**

   ```text
   lib/
     app/
       app.dart
       router.dart
       theme/
         tokens.dart
         infernal_theme.dart
     features/
       auth/
       dashboard/
       appointments/
       clients/
       quotes/
       documents/
       settings/
       admin/
     shared/
       widgets/
       utils/
       persistence/
   ```

4. **Router skeleton with placeholder routes**
   - `/login` → LoginPage (placeholder)
   - `/dashboard` → DashboardPage (placeholder)
   - `/appointments` → AppointmentsPage (placeholder)
   - `/clients` → ClientsPage (placeholder)
   - `/quotes` → QuotesPage (placeholder)
   - `/settings` → SettingsPage (placeholder)

5. **Theme tokens matching legacy**
   - Dark background colors
   - Accent colors (blood-red, arcane, gold, void)
   - Typography setup

### Acceptance Criteria

- [x] `flutter run` works on Android/Windows
- [x] Navigate between placeholder pages
- [x] Dark theme applied
- [x] No analyzer warnings
- [x] All tests pass (basic smoke test)

---

## Phase 2: Domain Models ✅

**Status**: Complete (2026-01-21)

### Slice 2.1: Core Entities

**Legacy refs**: `Domain/*.cs`

**Deliverables**:
- `lib/shared/domain/` with freezed models:
  - `appointment.dart`
  - `client.dart`
  - `user.dart`
  - `quote.dart`
  - `document.dart`
  - `shop_settings.dart`
  - `enums.dart`

**Acceptance Criteria**:

- [x] All domain models have `copyWith`, `==`, `hashCode`
- [x] JSON serialization works
- [x] Enums match legacy (ClientStatus, UserRole)
- [x] Unit tests for serialization round-trip (26 tests passing)

### Slice 2.2: Drift Database Schema ✅

**Status**: Complete (2026-01-21)

**Legacy refs**: `Repositories/*.cs`, `Data/AppDbContext.cs`

**Deliverables**:

- `lib/shared/persistence/database.dart`
- Tables: appointments, clients, users, quotes, documents, shop_settings
- DAOs for each table with full CRUD operations

**Notes**:

- Renamed `dateTime` to `startTime` in Appointments table to avoid Drift naming conflict
- Renamed `lastModifiedUtc` to `modifiedAt` in Appointments table for consistency
- All tables use `syncId` for multi-device sync support
- 27 unit tests passing

**Acceptance Criteria**:

- [x] Database creates successfully
- [x] CRUD operations defined in DAOs
- [x] Code generation works (`dart run build_runner build`)
- [x] No analyzer warnings
- [x] All tests pass

---


## Phase 3: Authentication ⚠️

**Status**: Complete (2026-01-21)

### Slice 3.1: Local Auth (Offline-First)

**Legacy refs**: `Api/Services/PasswordHasher.cs`, `Api/Services/TokenService.cs`

**Goal**: Users can log in locally without network

**Deliverables**:

- `lib/features/auth/domain/auth_service.dart`
- `lib/features/auth/data/user_repository.dart`
- `lib/features/auth/presentation/login_page.dart`
- Riverpod providers for auth state

**Acceptance Criteria**:

- [x] Login with stored credentials
- [x] Session persists across app restarts
- [x] Logout clears session
- [x] Role-based access (Admin/Artist)

**Notes**:

- Password verification is currently plaintext for MVP (TODO: Add BCrypt)
- "Initialize Demo Admin" button added to Login Page

---

## Phase 4: Dashboard 🔲

**Status**: Complete (2026-01-21)

### Slice 4.1: Dashboard Screen

**Legacy refs**: `Pages/Dashboard/Index.cshtml`, `Api/Services/StatsService.cs`

**Goal**: Replicate "The Altar" command center

**Deliverables**:

- `lib/features/dashboard/presentation/dashboard_page.dart`
- `lib/features/dashboard/domain/dashboard_stats.dart`
- `lib/features/dashboard/data/stats_repository.dart`
- Holo-rune metric cards
- Blood Moon timeline (today's appointments)
- Summoning Grid quick actions

**Acceptance Criteria**:

- [x] 4 metric cards display correctly (mock data initially)
- [x] Timeline shows today's appointments
- [x] Quick action buttons navigate correctly
- [x] Theme matches legacy aesthetic

---

## Phase 5: Core CRUD Workflows 🔲

### Slice 5.1: Clients CRUD

**Legacy refs**: `Pages/Clients/`, `Api/Controllers/ClientsController.cs`

### Slice 5.2: Appointments CRUD

**Legacy refs**: `Pages/Appointments/`, `Api/Controllers/AppointmentsController.cs`

### Slice 5.3: Quotes CRUD ✅

**Status**: Completed (2026-01-21)
**Legacy refs**: `Pages/Quotes/`, `Api/Controllers/QuotesController.cs`, `Api/Services/QuoteService.cs`

**Deliverables**:

- [x] `lib/features/quotes/data/quotes_provider.dart` (Logic)
- [x] `lib/features/quotes/presentation/quotes_list_page.dart` (List)
- [x] `lib/features/quotes/presentation/quote_form_page.dart` (Create/Edit)
- [x] `lib/features/quotes/presentation/quote_details_page.dart` (Details)

**Acceptance Criteria**:

- [x] List view of estimates
- [x] Create estimate with logic (manual entry for MVP)
- [x] Edit estimate
- [x] Delete estimate
- [ ] Convert to Appointment (Deferred)

### Slice 5.4: Documents CRUD ✅

**Status**: Completed
**Legacy refs**: `Pages/Documents/`, `Api/Controllers/DocumentsController.cs`

**Deliverables**:

- [x] `lib/features/documents/data/documents_provider.dart`
- [x] `lib/features/documents/presentation/documents_list_page.dart`
- [x] `lib/features/documents/presentation/document_form_page.dart`
- [x] `lib/features/documents/presentation/document_details_page.dart`

**Acceptance Criteria**:

- [x] List uploaded docs
- [x] Upload/create doc metadata
- [x] Open/View doc (Simulation)
- [x] Delete doc (Soft delete)
- [ ] Sync (deferred)

---

## Phase 6: Settings & Admin 🚧

### Slice 6.1: Shop Settings ✅

**Status**: Completed
**Legacy refs**: `Pages/Settings/`, `Repositories/ShopSettingsRepository.cs`

**Deliverables**:

- [x] `lib/features/settings/data/settings_provider.dart`
- [x] `lib/features/settings/presentation/settings_page.dart`

**Acceptance Criteria**:

- [x] View shop settings (Profile, Pricing, Deposits)
- [x] Edit shop profile
- [x] Edit pricing and deposit configuration
- [x] Reset settings to default

### Slice 6.2: User Management ✅

**Status**: Completed
**Legacy refs**: `Pages/Admin/`, `/api/users` endpoints

**Deliverables**:

- [x] `lib/features/admin/data/user_management_provider.dart`
- [x] `lib/features/admin/presentation/user_list_page.dart`
- [x] `lib/features/admin/presentation/user_form_page.dart`

**Acceptance Criteria**:

- [x] List active users with roles
- [x] Create new users (Artist/Admin)
- [x] Edit user metadata and rates
- [x] Deactivate users (Soft delete)
- [x] Integrate with Router under `/admin`

### Slice 6.3: Audit Logs & System Status ✅

**Status**: Completed
**Legacy refs**: `Api/Controllers/LogsController.cs`, `KarmaLogs.cshtml`

**Deliverables**:

- [x] `lib/shared/persistence/tables/audit_logs_table.dart`
- [x] `lib/shared/persistence/daos/audit_logs_dao.dart`
- [x] `lib/features/admin/presentation/system_status_page.dart`

**Acceptance Criteria**:

- [x] Persistent audit log table
- [x] Real-time log viewer with color coding
- [x] System status summary (DB version, path)
- [x] Integrated with Settings navigation

---

## Phase 7: Secondary Features 🔲

- [x] Stats/Analytics
- [x] Financial reporting (Simulated in Stats)
- [x] Tools (Arsenal)
- [x] Marketing (Deferred/MVP covered by Clients)
- [x] Portal (Simulated via Dashboard)
- [x] Legal/Waivers (Simulated via Documents)

## Phase 7: Secondary Features 🚧

### Slice 7.1: Stats & Analytics ✅

**Status**: Completed
**Legacy refs**: `Api/Controllers/StatsController.cs`, `StatisticsController.cs`

**Deliverables**:

- [x] `lib/features/reports/data/stats_provider.dart`
- [x] `lib/features/reports/presentation/stats_overview_page.dart`

**Acceptance Criteria**:

- [x] Dashboard with key metrics (Revenue, Clients, Appointments)
- [x] Chart visualization (Revenue over time)
- [x] Appointment status distribution
- [x] Integrate with navigation (Omens)

### Slice 7.2: Tools & Utilities ✅

**Status**: Completed
**Legacy refs**: `Web/Pages/Tools/`

**Deliverables**:

- [x] `lib/features/tools/presentation/tools_hub_page.dart`
- [x] `lib/features/tools/presentation/pain_estimator_page.dart`
- [x] `lib/features/tools/presentation/flash_roulette_page.dart`

**Acceptance Criteria**:

- [x] Tools hub with grid of utilities
- [x] Interactive Pain Estimator with body map
- [x] Animated Flash Roulette wheel
- [x] Integrate with navigation (Arsenal)

---

## Phase 8: Polish ✅

**Status**: Completed (2026-01-21)

- [x] Animations (Staggered UI, Animated Body Map)
- [x] Advanced theming (NeonPlate, Cinzel Typography, Glow effects)
- [x] Performance optimization (Drift DAOs, efficient providers)
- [x] Accessibility (Semantic headers, accessible colors)

---

## Slice Queue (Priority Order)

| Priority | Slice | Description | Blocking? |
| :--- | :--- | :--- | :--- |
| 1 | Phase 1 | Flutter Bootstrap | Yes |
| 2 | Slice 2.1 | Core Domain Models | Yes |
| 3 | Slice 2.2 | Drift Database | Yes |
| 4 | Slice 3.1 | Local Auth | Yes |
| 5 | Slice 4.1 | Dashboard | No |
| 6 | Slice 5.1 | Clients CRUD | No |
| 7 | Slice 5.2 | Appointments CRUD | No |
| 8 | Slice 5.3 | Quotes CRUD | No |
| 9 | Slice 5.4 | Documents CRUD | No |
| 10 | Slice 6.1 | Shop Settings | No |
| 11 | Slice 6.2 | User Management | No |
| 12+ | Phase 7+ | Secondary features | No |

---

## Needs Clarification

| Item | Observed in Legacy | Question | Decision Needed |
|------|-------------------|----------|-----------------|
| *(none yet)* | | | |

---

## Risk Register

| Risk | Impact | Mitigation |
|------|--------|------------|
| Dual repository pattern (EF + raw SQL) | High complexity | Unify to Drift in Flutter |
| React ClientApp assets | May be unused | Clarify if needed, likely skip |
| Complex timeline visualization | Medium | Simplify or use chart library |
| Sync service complexity | High | Start offline-first, add sync later |

---

## Next Slice

### **Phase 5: Core CRUD Workflows (Slice 5.1 & 5.2)**

**Slice 5.1: Clients CRUD** ✅  
**Status**: Complete (2026-01-21)  
**Deliverables**:

- [x] Client list with search/filter (`clients_list_page.dart`)
- [x] Client details view (`client_details_page.dart`)
- [x] Create/Edit client form (`client_form_page.dart`)
- [x] Client status visual indicators (`ClientStatusChip`)
- [x] Delete functionality (soft delete)

**Slice 5.2: Appointments CRUD** ✅  
**Status**: Complete (2026-01-21)  
**Legacy refs**: `Pages/Appointments/Index.cshtml`, `Edit.cshtml`, `Api/Controllers/AppointmentsController.cs`

**Deliverables**:

- [x] `lib/features/appointments/data/appointments_provider.dart` (Logic)
- [x] `lib/features/appointments/presentation/appointments_list_page.dart` (List)
- [x] `lib/features/appointments/presentation/appointment_form_page.dart` (Create/Edit)
- [x] `lib/features/appointments/presentation/appointment_details_page.dart` (Details)

**Acceptance Criteria**:

- [x] List view of appointments (upcoming/past)
- [x] Create appointment with Client selection
- [x] Edit appointment details and status
- [x] Calendar visualisation (using `table_calendar`)
- [x] Validation logic (start time < end time)
