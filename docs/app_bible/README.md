# Infernal Ink & Steel Suite — App Bible

Welcome to the **App Bible** for the **Infernal Ink & Steel Suite** (also known as *Infernal Web* or *InkSteel Studio Suite*). This document is the ultimate, canonical **Source of Truth** for the system's design, domain, and architecture.

A brand-new developer, designer, or stakeholder should be able to read this Bible and completely understand how the application functions, the relationships between its domain entities, and its architectural rules without reading a single line of code.

---

## 📖 Philosophical Foundation

This App Bible is constructed around a strict set of design and domain principles:

1. **Domain-First Design**: The domain reflects the real-world operations of an infernal-themed tattoo and piercing studio. It is decoupled from storage details, persistence concerns, and UI states.
2. **Offline-First**: Local storage (SQLite via Drift) is the primary source of truth. Users own and control their data, which can function seamlessly without an active internet connection.
3. **Single Responsibility (SRP)**: Every class, service, and feature has one well-defined responsibility.
4. **Composition Over Inheritance**: Complex entities are built by composing smaller, immutable structures.
5. **YAGNI (You Aren't Gonna Need It)**: We build precisely what is required to satisfy active workflows, avoiding speculative engineering.
6. **Strict Ownership**: Every entity, behavior, and collection has an explicit owner. Behavior is never placed in a class that does not own it.
7. **Command-Query Separation (CQS)**: Methods are explicitly classified as **Commands** (which mutate state and return `void`) or **Queries** (which read state and return values without side effects).

---

## 📂 App Bible Map

The App Bible is modularized into dedicated directories to make maintenance, navigation, and onboarding seamless.

### [1. Vision](./vision/vision.md)

The high-level mission, product goals, core principles, MVP scope, and long-term roadmap.

### 2. Domain Modeling (`/classes`)

The real-world entities that constitute the heart of the business domain. Decoupled from SQL/ORM specifics.

* [Client](./classes/client.md) — Studio customers, their history, notes, and metrics.
* [ClientLifecycle](./classes/client_lifecycle.md) — Automatic status evaluation based on behavior.
* [User](./classes/user.md) — Artists, admins, default rates, and configurations.
* [Appointment](./classes/appointment.md) — Calendar events, tattoos, piercings, waitlist, or time-blocks.
* [Quote](./classes/quote.md) — Smart estimators based on body location, size, and complexity.
* [Document](./classes/document.md) — Waivers, consent forms, and client file archives.
* [ShopSettings](./classes/shop_settings.md) — Hourly rates, tax percentages, deposits, and operating schedules.
* [Inventory](./classes/inventory.md) — Consumables, studio supplies, stock counts, and safety thresholds.
* [Communication](./classes/communication.md) — Historical logs of SMS, email, and automated reminders.
* [Enums](./classes/enums.md) — Core domain-level enumerations and validation boundaries.

### [3. Features](./features/)

End-to-end user workflows, detailing rules, classes, and edge cases:

* [Authentication](./features/auth.md) — Local role-based session management.
* [Dashboard](./features/dashboard.md) — "The Altar" timeline and quick-summon operations.
* [Clients Ledger](./features/clients.md) — Customer records and status progression.
* [Rituals Scheduler](./features/appointments.md) — Calendar bookings and the "Purgatory" waitlist.
* [Smart Quote Calculator](./features/quotes.md) — Algorithmic estimate generation.
* [Waivers & Documents](./features/documents.md) — Client consent tracking and file uploads.
* [Arsenal Utilities](./features/tools.md) — Body pain mapping and the "Flash Roulette".
* [Communications Log](./features/communications.md) — Outgoing notifications and logs.
* [Supply Inventory](./features/inventory.md) — Needles, inks, and consumable stock management.
* [Omens & Reports](./features/reports.md) — Financial stats, charts, and shop health checks.
* [Shop Settings](./features/settings.md) — Configuring studio metadata, rates, and schedules.
* [System Administration](./features/admin.md) — Managing users, passwords, and viewing the system audit ledger.

### [4. Screens](./screens/)

UI/UX screen-by-screen specifications including empty states, inputs/outputs, and widget mappings, with one dedicated document matching each Dart presentation file:

* **Authentication**: [Login Page](./screens/login_page.md) • [Register Page / Claim Setup](./screens/register_page.md)
* **Dashboard**: [Dashboard Page](./screens/dashboard_page.md)
* **Appointments / Calendar**: [Appointments List Page](./screens/appointments_list_page.md) • [Appointment Form Page](./screens/appointment_form_page.md) • [Appointment Details Page](./screens/appointment_details_page.md)
* **Clients**: [Clients List Page](./screens/clients_list_page.md) • [Client Form Page](./screens/client_form_page.md) • [Client Details Page](./screens/client_details_page.md)
* **Quotes**: [Quotes List Page](./screens/quotes_list_page.md) • [Quote Form Page](./screens/quote_form_page.md) • [Quote Details Page](./screens/quote_details_page.md)
* **Documents**: [Documents List Page](./screens/documents_list_page.md) • [Document Form Page](./screens/document_form_page.md) • [Document Details Page](./screens/document_details_page.md)
* **Settings**: [Settings Page](./screens/settings_page.md) • [Integrations Page](./screens/integrations_page.md)
* **Statistics**: [Stats Overview Page](./screens/stats_overview_page.md)
* **Tools**: [Tools Hub Page](./screens/tools_hub_page.md) • [Pain Estimator Page](./screens/pain_estimator_page.md) • [Flash Roulette Page](./screens/flash_roulette_page.md)
* **Inventory**: [Inventory Hub Page](./screens/inventory_hub_page.md) • [Inventory Form Page](./screens/inventory_form_page.md)
* **Communications**: [Communications Hub Page](./screens/communications_hub_page.md)
* **Administration**: [User List Page](./screens/user_list_page.md) • [User Form Page](./screens/user_form_page.md) • [System Status Page](./screens/system_status_page.md) • [Admin Requests Page](./screens/admin_requests_page.md)

### [5. Architecture](./architecture/architecture.md)

Directory layouts, package boundaries, state management structures, and exact data-flow lifecycles.

### [6. ADRs (Architectural Decision Records)](./decisions/)

Canonical records of key technical choices:

* [ADR-001: Offline-First SQLite with Drift](./decisions/adr-001-offline-first.md)
* [ADR-002: Riverpod for Unidirectional State Management](./decisions/adr-002-riverpod-state.md)
* [ADR-003: Soft-Delete Pattern for Synchronization Compatibility](./decisions/adr-003-soft-delete-sync.md)
* [ADR-004: Role-Based Local Hashed Authentication](./decisions/adr-004-local-auth.md)

### [7. UI and Theming Style Guide](./ui/theme.md)

Details the dark "Neon-Infernal" aesthetic: typography (Cinzel & Roboto Mono), color tokens (Blood Red, Arcane Purple, Gilded Gold, Void Black), and tactile layouts (NeonPlate borders, glowing card structures).

### [8. Implementation Status](./implementation/status.md)

Tracks ported features, system health, and known areas of technical alignment.

### [9. Open Questions & Future Extensions](./questions/open_questions.md)

A list of active design considerations, system expansions, and clarifications.
