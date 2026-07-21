# Open Questions & Future Extensions

This document lists architectural open items, design trade-offs, and planned future extensions for the Infernal Ink & Steel Suite.

---

## ❓ Open Architectural Questions

### 1. Manual vs. Automated Client Status Overrides

Currently, client status is represented both by a legacy persistent SQLite enum (`ClientStatus`: `bound`, `freshSoul`, etc.) and a dynamic domain evaluator (`ClientLifecycleLabel` based on active completed bookings).

* **The Question**: Should the legacy `status` table column be physically pruned from SQLite in a future migration, making status entirely dynamic? Or do studio owners require manual, override control (e.g., manually blacklisting a client to `void_` status)?

### 2. Synchronization Conflicts Reconciliations

When Device A and Device B both modify the same Appointment or Client while offline and subsequently sync:

* **The Question**: Should the sync service default to a strict "last-writer-wins" (timestamp comparison) policy, or should we design interactive, visual conflict merge panels letting staff inspect overlapping edits side-by-side?

### 3. Local Encryption Scales

Currently, passwords are BCrypt-hashed, but standard client records (such as names, phone numbers, and liability waiver images) are stored in plaintext SQLite databases and file-systems on device.

* **The Question**: Does local legislative compliance (medical privacy laws, waiver storage rules) require full-disk SQLite encryption (e.g., SQLCipher integration) to safeguard client profiles on physically compromised devices?

---

## 🌟 Planned Future Extensions

### 1. In-App Cryptographic Waiver Signing

Generating legal PDF sheets containing hand-drawn client signatures captured directly on tablet touch screens. These PDFs will be encrypted and stamped with sha256 checksum tags in database transaction logs.

### 2. Peer-to-Peer Local Studio Replication

Allowing tablets (iPads/Android) in the studio to sync files and databases directly with a central local shop computer over local Wi-Fi networks, eliminating any internet sync requirements entirely.

### 3. Predictive Roster Scheduling

An analytical daemon analyzing past artist speeds, appointment lengths, and calendar data to automatically suggest optimize schedules and booking intervals during quote creation.
