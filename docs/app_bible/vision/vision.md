# Vision — Infernal Ink & Steel Suite

## 🩸 Mission Statement

The mission of the **Infernal Ink & Steel Suite** is to provide elite tattoo and piercing studios with an ultra-reliable, highly aesthetic, and completely sovereign management system. By merging an immersive, dark-industrial aesthetic ("The Infernal Engine") with state-of-the-art local-first performance, we empower artists and studio administrators to master their calendars, clients, and assets without relying on flaky internet connections or renting out their data.

---

## 🎯 Goals

### 1. Zero-Latency Offline Operations (Resilience)

Every operational detail — from looking up a client to compiling a quote or booking an appointment — must occur in local memory instantly. No loading spinners for API calls during high-stress shop operations.

### 2. Radical Data Sovereignty (Privacy & Control)

A shop's client database and financial records are its most valuable business assets. The software operates primarily on the local device, ensuring the studio maintains full custody of its sensitive client, medical, and financial data.

### 3. High-Fidelity Thematic UX (The Aesthetic)

Tattoo and piercing studios are centers of creative self-expression. The software must reflect this culture, rejecting generic corporate SaaS design in favor of a dramatic, dark-themed, glow-accented, tactical dashboard ("The Altar") that artists are proud to have open on their iPads, tablets, or screens.

### 4. Low-Triction Onboarding

The system should require minimal setup, running immediately upon installation with a pre-configured local SQLite database, allowing shops to transition from legacy paper or bloated SaaS apps in minutes.

---

## 🖤 Core Principles

1. **Local-First, Sync-Compatible**: Write and read locally as the default. If a sync layer is added in the future, it must be designed as an asynchronous background companion, never a blocking gatekeeper.
2. **Strict Command-Query Separation (CQS)**: Methods in the domain either request state transitions (Commands) or read state (Queries). This prevents unintended side-effects and makes the codebase predictable and testable.
3. **Immutability by Default**: Domain models are immutable. When state updates are requested, new instances are generated with explicit alterations (e.g., using `copyWith` patterns).
4. **No Code in the App Bible**: The App Bible is the conceptual design language of the business. It contains domain definitions, operational rules, and screen layouts, serving as a blueprint for the code rather than a downstream reflection.
5. **No Database Leakage into Domain**: The domain must know nothing about database IDs, primary keys, foreign keys, or ORM annotations. These are details managed by the persistent layer.

---

## 📦 MVP (Minimum Viable Product) Scope

The MVP encompasses the necessary components for running a single physical tattoo and body art studio:

* **Authentication**: Hashed local database login containing Admin and Artist profiles.
* **Dashboard ("The Altar")**: Timeline view showing the current day's tattoo sessions, quick-summon shortcuts, and real-time metric cards.
* **Client Directory ("The Soul Ledger")**: Complete client profiles with automatic lifecycle labeling, detailed histories, custom notes, and image attachments.
* **Rituals Calendar ("The Appointment Ledger")**: Responsive calendar interface with waitlist handling ("Purgatory") and time blocking capability.
* **Smart Quote Calculator**: Interactive estimator that standardizes pricing based on style, placement, dimensions, and visual complexity factors.
* **Waiver & Document Vault**: Digital asset storage matching waiver metadata with clients and sessions.
* **Arsenal Utilities**: Visual tools including an interactive body pain map estimator and an animated flash tattoo roulette wheel.
* **Supply Inventory**: Stock tracking with safety threshold triggers for needles, ink, and studio consumables.
* **Omens & Reports**: Local financial analytics showing revenue trends, service breakdown charts, and active artist metrics.

---

## 🗺️ Roadmap

### Phase 1 — Local-First Single Studio (MVP) 🌟

*Establish the local operational baseline.*

* Complete localized database mapping using SQLite/Drift.
* Polished Neon-Infernal dark Material 3 theme.
* Local role-based permissions (Admin vs. Artist).
* Complete standalone Client, Appointment, Quote, Document, Inventory, and Report flows.

### Phase 2 — Studio Multi-Device Sync & Backups 🔄

*Bridge the gap between tablets and desktop monitors without centralized SaaS overhead.*

* Peer-to-peer or lightweight local network database replication.
* Encrypted local file synchronization (portraits, documents, sketches).
* Optional automated backup to secure private cloud storage (Supabase/S3).

### Phase 3 — Digital Consent & Waiver Signatures ✍️

*Eliminate paper waste and legal risks entirely.*

* In-app hand-drawn signatures on tablet devices.
* Automatic PDF generation and cryptographic sealing.
* Automated email delivery of completed waivers to clients.

### Phase 4 — Client Portal & Online Waitlist 🌐

*Extend the Infernal experience outwards.*

* Client-facing standalone web portal for submitting quote inquiries and booking requests directly into "Purgatory" (the waitlist).
* Artist portfolio highlights and automated communication alerts.
* Direct SMS status updates for waitlisted clients.
