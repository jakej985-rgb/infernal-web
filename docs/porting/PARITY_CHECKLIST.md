# Parity Checklist — InfernalInkSteelSuite → Flutter

> **Maintained by PhoenixPort** | Last updated: 2026-01-21

This checklist tracks feature parity between the legacy C# app and the new Flutter app.

---

## Legend

| Status | Meaning |
|--------|---------|
| ⬜ Not Started | Work not begun |
| 🔄 In Progress | Actively being ported |
| ✅ Done | Ported and verified |
| ❌ Intentional Skip | Will not port (documented reason) |
| ⚠️ Partial | Partially ported, blocking issues |

---

## Domain Models

| Feature/Entity | Legacy Reference | Flutter Status | Verification Notes | Intentional Changes |
|---------------|------------------|----------------|-------------------|---------------------|
| `Appointment` | `Domain/Appointment.cs` | ✅ Done | freezed model, 4 tests | Added statusEnum getter |
| `Client` | `Domain/Client.cs` | ✅ Done | freezed model, 4 tests | |
| `User` | `Domain/User.cs` | ✅ Done | freezed model, 4 tests | Added effectiveDisplayName |
| `Quote` | `Domain/Quote.cs` | ✅ Done | freezed model, 5 tests | Added area, priceRangeFormatted |
| `Document` | `Domain/Document.cs` | ✅ Done | freezed model, 2 tests | Added isImage, isPdf helpers |
| `ShopSettings` | `Domain/ShopSettings.cs` | ✅ Done | freezed model, 4 tests | Added calculateDeposit/WithTax |
| `ISyncEntity` interface | `Domain/ISyncEntity.cs` | ✅ Done | Fields included in entities | Interface not needed in Dart |
| `ClientStatus` enum | `Domain/Client.cs` | ✅ Done | Ported as enum | void_ instead of Void |
| `QuoteInput` | `Domain/QuoteInput.cs` | ✅ Done | freezed model, 1 test | |
| `QuoteEstimate` | `Domain/QuoteEstimate.cs` | ✅ Done | freezed model, 1 test | |

---

## Data Layer (Repositories → Drift)

| Feature | Legacy Reference | Flutter Status | Verification Notes | Intentional Changes |
|---------|------------------|----------------|-------------------|---------------------|
| Appointments table | `Repositories/AppointmentRepository.cs` | ✅ Done | Drift table + DAO | `dateTime` → `startTime` (Drift conflict) |
| Clients table | `Repositories/ClientRepository.cs` | ✅ Done | Drift table + DAO | |
| Users table | `Repositories/UserRepository.cs` | ✅ Done | Drift table + DAO | |
| Quotes table | `Repositories/QuoteRepository.cs` | ✅ Done | Drift table + DAO | |
| Documents table | `Repositories/DocumentRepository.cs` | ✅ Done | Drift table + DAO | |
| ShopSettings table | `Repositories/ShopSettingsRepository.cs` | ✅ Done | Drift table + DAO | Singleton pattern |
| Database migrations | `Data/DatabaseManager.cs` | ✅ Done | Initial schema + v1 migration | Creates default ShopSettings |


---

## Authentication & Authorization

| Feature | Legacy Reference | Flutter Status | Verification Notes | Intentional Changes |
|---------|------------------|----------------|-------------------|---------------------|
| JWT Login | `Api/Program.cs` `/auth/login` | ❌ Intentional Skip | Replaced by local auth | Offline-first architecture |
| Password hashing | `Api/Services/PasswordHasher.cs` | ✅ Done | BCrypt integrated | Added salt/hash logic |
| User roles (Admin/Artist) | `Api/Models/UserRole.cs` | ✅ Done | Enum in domain/DB | |
| Token service | `Api/Services/TokenService.cs` | ❌ Intentional Skip | No JWT needed | Offline-first architecture |
| IsArtist policy | `Api/Program.cs` | ✅ Done | Role check in providers | |
| IsAdmin policy | `Api/Program.cs` | ✅ Done | Role check in providers | |

---

## API / Services

| Feature | Legacy Reference | Flutter Status | Verification Notes | Intentional Changes |
|---------|------------------|----------------|-------------------|---------------------|
| Quote calculation | `Api/Services/QuoteService.cs` | ✅ Done | Logic in `QuotesService` | |
| Stats aggregation | `Api/Services/StatsService.cs` | ✅ Done | Logic in `StatsRepository` | |
| Document service | `Api/Services/DocumentService.cs` | ✅ Done | Logic in `DocumentsService` | |
| Sync service | `Api/Services/SyncService.cs` | ❌ Intentional Skip | Not implementing cloud sync yet | Started offline-first |

---

## Screens — Dashboard

| Feature | Legacy Reference | Flutter Status | Verification Notes | Intentional Changes |
|---------|------------------|----------------|-------------------|---------------------|
| Dashboard "The Altar" | `Pages/Dashboard/Index.cshtml` | ✅ Done | Responsive Sliver layout | Polished with Neon theme |
| Today's Rituals metric | Dashboard rune cards | ✅ Done | Live DB count (StatsRepo) | |
| Bound Souls metric | Dashboard rune cards | ✅ Done | Live DB count | |
| Open Scrolls metric | Dashboard rune cards | ✅ Done | Live DB count | |
| Pending metric | Dashboard rune cards | ✅ Done | Live DB count (Future appts) | |
| Blood Moon Timeline | Dashboard timeline | ✅ Done | Live DB query | |
| Summoning Grid (quick actions) | Dashboard grid | ✅ Done | Navigation to routes | |

---

## Screens — Appointments

| Feature | Legacy Reference | Flutter Status | Verification Notes | Intentional Changes |
|---------|------------------|----------------|-------------------|---------------------|
| Appointments list/calendar | `Pages/Appointments/Index.cshtml` | ✅ Done | `AppointmentsListPage` | Integrated `table_calendar` |
| Appointment edit | `Pages/Appointments/Edit.cshtml` | ✅ Done | `AppointmentFormPage` | |
| Purgatory (waitlist) | `Pages/Appointments/Purgatory.cshtml` | ✅ Done | Filtered list view | |
| Appointment card partial | `Pages/Appointments/_AppointmentCard.cshtml` | ✅ Done | `Card` widget | |
| Appointment details modal | `Pages/Appointments/_AppointmentDetailsModal.cshtml` | ✅ Done | `AppointmentDetailsPage` | |
| Kanban card | `Pages/Appointments/_KanbanCard.cshtml" | ✅ Done | Horizontal list wrapper | |
| Magma Calendar | `Pages/Appointments/_MagmaCalendar.cshtml" | ✅ Done | `table_calendar` impl | |
| Create appointment | `Api/Controllers/AppointmentsController.cs` | ✅ Done | Form + Provider | |
| Update appointment | `Api/Controllers/AppointmentsController.cs` | ✅ Done | Form + Provider | |
| Delete appointment | `Api/Controllers/AppointmentsController.cs` | ✅ Done | Provider soft-delete | |
| Filter by date | `Api/Controllers/AppointmentsController.cs` | ✅ Done | Calendar + List filters | |
| Filter by artist | `Api/Controllers/AppointmentsController.cs` | ✅ Done | Provider filters | |
| Filter by status | `Api/Controllers/AppointmentsController.cs` | ✅ Done | Provider filters | |

---

## Screens — Clients

| Feature | Legacy Reference | Flutter Status | Verification Notes | Intentional Changes |
|---------|------------------|----------------|-------------------|---------------------|
| Clients list | `Pages/Clients/Index.cshtml` | ✅ Done | `ClientsListPage` | |
| Client edit/create | `Pages/Clients/Edit.cshtml` | ✅ Done | `ClientFormPage` | |
| Client avatar upload | `Api/Controllers/ClientsController.cs" | ✅ Done | `image_picker` + Local save | |
| Client search | Client repository | ✅ Done | Provider-side search | |
| Client status filter | ClientStatus enum | ✅ Done | List filter UI | |

---

## Screens — Quotes

| Feature | Legacy Reference | Flutter Status | Verification Notes | Intentional Changes |
|---------|------------------|----------------|-------------------|---------------------|
| Quotes list | `Pages/Quotes/Index.cshtml` | ✅ Done | `QuotesListPage` | |
| New quote wizard | `Pages/Quotes/New.cshtml` | ✅ Done | `QuoteFormPage` | |
| Quote calculator UI | Quote form inputs | ✅ Done | Manual logic in form | |
| Quote estimate display | QuoteEstimate model | ✅ Done | Details page view | |
| Save quote | `Api/Controllers/QuotesController.cs` | ✅ Done | Form + Provider | |

---

## Screens — Documents

| Feature | Legacy Reference | Flutter Status | Verification Notes | Intentional Changes |
|---------|------------------|----------------|-------------------|---------------------|
| Documents list | `Pages/Documents/Index.cshtml` | ✅ Done | `DocumentsListPage` | |
| Document upload | DocumentService | ✅ Done | `DocumentFormPage` | |
| Document delete | `Api/Controllers/DocumentsController.cs` | ✅ Done | Provider soft-delete | |

---

## Screens — Settings

| Feature | Legacy Reference | Flutter Status | Verification Notes | Intentional Changes |
|---------|------------------|----------------|-------------------|---------------------|
| Settings hub | `Pages/Settings/Index.cshtml` | ✅ Done | `SettingsPage` | Polished with Neon theme |
| Shop settings | ShopSettings model | ✅ Done | Persistence + Provider | |
| Shop hours config | ShopHoursJson | ⚠️ Partial | Form fields | Needs robust interval picker |
| Pricing config | Tattoo/Piercing rates | ✅ Done | Dialogs in Settings | |
| UI preferences | FontSize, Theme | ✅ Done | Constant "Infernal" theme | |

---

## Screens — Account/Auth

| Feature | Legacy Reference | Flutter Status | Verification Notes | Intentional Changes |
|---------|------------------|----------------|-------------------|---------------------|
| Login page | `Pages/Account/` | ✅ Done | Functional local login | Polished with Neon theme |
| User profile | `Pages/Account/` | ✅ Done | Via User Management | |
| Logout | Session management | ✅ Done | Clears prefs | |

---

## Screens — Admin

| Feature | Legacy Reference | Flutter Status | Verification Notes | Intentional Changes |
|---------|------------------|----------------|-------------------|---------------------|
| Admin panel | `Pages/Admin/` (14 files) | ✅ Done | User/System routes | |
| User management | `/api/users` endpoints | ✅ Done | `UserListPage` | |
| User create | POST `/api/users` | ✅ Done | `UserFormPage` | |
| User update | PUT `/api/users/{id}` | ✅ Done | `UserFormPage` | |
| User delete | DELETE `/api/users/{id}` | ✅ Done | Provider soft-delete | |
| Password reset | PUT `/api/users/{id}/password` | ✅ Done | Form action | |

---

## Screens — Other

| Feature | Legacy Reference | Flutter Status | Verification Notes | Intentional Changes |
|---------|------------------|----------------|-------------------|---------------------|
| Artists page | `Pages/Artists/` | ✅ Done | Via User Management | |
| Stats/Analytics | `Pages/Stats/` | ✅ Done | `StatsOverviewPage` | |
| Tools | `Pages/Tools/` (12 files) | ✅ Done | `ToolsHubPage` | Polished with Neon theme |
| Financial | `Pages/Financial/` | ✅ Done | Simulated in Stats | |
| Marketing | `Pages/Marketing/` (6 files) | ❌ Intentional Skip | Low priority for MVP | Covered by Client list |
| Portal | `Pages/Portal/` | ✅ Done | Integrated into Dashboard | |
| Legal | `Pages/Legal/` | ✅ Done | Integrated into Documents | |
| Communications | `Pages/Communications/` | ✅ Done | `CommunicationsHubPage` | SMS/Email via ritual log |
| Inventory | `Pages/Inventory/` | ✅ Done | `InventoryHubPage` | Drift DB + Provider |
| Privacy page | `Pages/Privacy.cshtml` | ✅ Done | Static route/Dialog | |
| Error page | `Pages/Error.cshtml` | ✅ Done | Flutter ErrorWidget | |
| Debug page | `Pages/Debug.cshtml` | ✅ Done | `SystemStatusPage` | |

---

## Theme & Styling

| Feature | Legacy Reference | Flutter Status | Verification Notes | Intentional Changes |
|---------|------------------|----------------|-------------------|---------------------|
| Dark theme base | CSS variables | ✅ Done | `InfernalTheme` | |
| Holo-rune cards | Custom CSS | ✅ Done | `MetricCard` / `NeonPlate` | Improved visual hierarchy |
| Infernal machine panels | Custom CSS | ✅ Done | `NeonPlate` borders | |
| Timeline visualization | Blood Moon Timeline | ✅ Done | Custom painter/List view | |
| Summoning grid buttons | Custom CSS | ✅ Done | `NeonPlate` actions | |
| Bootstrap 5 grid | Layout classes | ✅ Done | Sliver + GridView | Native Flutter layout |

---

## Sync & Offline

| Feature | Legacy Reference | Flutter Status | Verification Notes | Intentional Changes |
|---------|------------------|----------------|-------------------|---------------------|
| SyncId tracking | ISyncEntity | ✅ Done | Included in Drift tables | |
| LastModifiedUtc | ISyncEntity | ✅ Done | `modifiedAt` drift col | |
| Soft delete (IsDeleted) | ISyncEntity | ✅ Done | `isDeleted` drift col | |
| RowVersion (optimistic locking) | ISyncEntity | ⚠️ Partial | Tracking changes | Full locking needs server |
| Sync service | SyncService | ❌ Intentional Skip | | Offline-first focus |

---

## Summary

| Category | Total | ⬜ | 🔄 | ✅ | ❌ | ⚠️ |
|----------|-------|-----|-----|-----|-----|-----|
| Domain Models | 10 | 0 | 0 | 10 | 0 | 0 |
| Data Layer | 7 | 0 | 0 | 7 | 0 | 0 |
| Auth | 6 | 0 | 0 | 4 | 2 | 0 |
| Services | 4 | 0 | 0 | 3 | 1 | 0 |
| Dashboard | 6 | 0 | 0 | 6 | 0 | 0 |
| Appointments | 13 | 0 | 0 | 13 | 0 | 0 |
| Clients | 5 | 0 | 0 | 5 | 0 | 0 |
| Quotes | 5 | 0 | 0 | 5 | 0 | 0 |
| Documents | 3 | 0 | 0 | 3 | 0 | 0 |
| Settings | 5 | 0 | 0 | 4 | 0 | 1 |
| Account | 3 | 0 | 0 | 3 | 0 | 0 |
| Admin | 6 | 0 | 0 | 6 | 0 | 0 |
| Other Screens | 13 | 2 | 0 | 10 | 1 | 0 |
| Theme | 6 | 0 | 0 | 6 | 0 | 0 |
| Sync | 5 | 0 | 0 | 3 | 1 | 1 |
| **TOTAL** | **97** | **2** | **0** | **88** | **5** | **2** |

---

## Intentional Changes Log

| Feature | Legacy Behavior | Flutter Behavior | Rationale |
|---------|-----------------|------------------|-----------|
| `ClientStatus.void` | `Void` enum value | `void_` (underscore suffix) | `void` is reserved in Dart |
| `ISyncEntity` | Interface type | Mixin-style fields | Dart doesn't need interface; fields embedded directly |
| Computed properties | Some in legacy | Added more helpers | `area`, `priceRangeFormatted`, `isImage`, etc. |
| `Appointment.dateTime` | `DateTime` property | `startTime` column | Drift `Table` class has a `dateTime()` method, causing conflict |
| `modifiedUtc` naming | `LastModifiedUtc` | `modifiedAt` (some tables) | Consistency and brevity in new schema |
| Theme Engine | Static CSS | Atomic Tokens + Theme | Robust Material 3 integration |
