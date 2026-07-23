# Code Chronicle — appointments_list_page.dart

## 📂 File Registry
* **Workspace Path**: `app/lib/features/appointments/presentation/appointments_list_page.dart`
* **Type**: Presentation Page

## 📖 Operational Purpose
Defines the implementation and structures for appointments_list_page.dart.

---

## ⛓️ Import Dependencies
* `package:infernal_ink_steel/shared/data/org_labels_provider.dart`
* `package:flutter/material.dart`
* `package:flutter_riverpod/flutter_riverpod.dart`
* `package:flutter_riverpod/legacy.dart`
* `package:go_router/go_router.dart`
* `package:intl/intl.dart`
* `package:table_calendar/table_calendar.dart`
* `../../../app/theme/tokens.dart`
* `../../../shared/presentation/widgets/neon_plate.dart`
* `../data/appointments_provider.dart`
* `widgets/appointment_status_chip.dart`
* `../../../shared/data/infernal_labels_provider.dart`
* `../../../app/router.dart`

---

## 🏛️ Declared Classes
### `class AppointmentsListPage`
* Represents a structured code construct mapping business logic or view layouts for appointments_list_page.dart.

### `class _ListView`
* Represents a structured code construct mapping business logic or view layouts for appointments_list_page.dart.

### `class _CalendarView`
* Represents a structured code construct mapping business logic or view layouts for appointments_list_page.dart.

### `class _SectionHeader`
* Represents a structured code construct mapping business logic or view layouts for appointments_list_page.dart.

### `class _AppointmentList`
* Represents a structured code construct mapping business logic or view layouts for appointments_list_page.dart.

## 📊 Stored Enumerations
### `enum AppointmentsViewMode`
* Defines typed, validated operational categories for workflows.

## ⚡ State Providers & Notifiers
* **Provider Key**: `appointmentsViewModeProvider` (Riverpod container reactive handle)
* **Provider Key**: `selectedDateProvider` (Riverpod container reactive handle)

## ⚙️ Methods & Routines (CQS Boundaries)
* **`SizedBox()`**: Handles data retrieval queries (Query).
* **`TextStyle()`**: Handles data retrieval queries (Query).
* **`_getEventsForDay()`**: Handles data retrieval queries (Query).
* **`_CalendarView()`**: Handles data retrieval queries (Query).
* **`_ListView()`**: Handles data retrieval queries (Query).
* **`AlwaysScrollableScrollPhysics()`**: Handles data retrieval queries (Query).
* **`Icon()`**: Handles data retrieval queries (Query).
* **`createState()`**: Handles state mutation commands (Command).
* **`AppointmentsListPage()`**: Handles data retrieval queries (Query).
* **`NeverScrollableScrollPhysics()`**: Handles data retrieval queries (Query).
* **`Divider()`**: Handles data retrieval queries (Query).
* **`Center()`**: Handles data retrieval queries (Query).
* **`_SectionHeader()`**: Handles data retrieval queries (Query).
* **`build()`**: Handles data retrieval queries (Query).

---

## 🛡️ Verification Tiers
* **Static Analysis**: Verified via `flutter analyze` linter constraints.
* **Coverage**: Audited against unit and widget test pipelines.
