# ADR-003: Soft-Delete Pattern for Synchronization Compatibility

Status: Approved  
Date: 2026-01-21  

## Context

When designing offline-first architectures that support future cloud synchronization, physical deletion of database records is dangerous.

If Device A deletes an appointment physically on disk, and subsequently connects to sync services, Device B has no mechanism to know that the row was intentionally deleted—it simply appears as though Device A lacks that row, often leading sync systems to re-insert the deleted row from Device B back onto Device A.

## Decision

We will employ a universal **soft-delete pattern** across all primary domain entity collections (`isDeleted == true`).

Physical SQL delete queries are strictly forbidden on primary tables. When users request row deletions, the application triggers a Command mutating `isDeleted` to `true` and updating `lastModifiedUtc`. UI queries automatically filter out any rows where `isDeleted` equals `true`.

## Consequences

* **Positives**:
  * Guarantees complete sync compatibility across multi-device installations.
  * Allows administrators to recover accidentally deleted clients or appointments easily.
* **Negatives**:
  * Unused rows occupy disk space. An Admin utility may be introduced in the future to physically purge soft-deleted data older than a strict legislative retention window (e.g., 5 years for waivers).
