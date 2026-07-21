# ADR-001: Offline-First SQLite with Drift

Status: Approved  
Date: 2026-01-21  

## Context

Tattoo studios frequently operate in environments with flaky internet connections (e.g., thick concrete studio walls, remote locations). High-stress, fast-paced operations require real-time scheduling checks, customer directory searches, and quote compilation with zero latency.

A centralized SaaS approach requiring synchronous API round-trips for basic workflows introduces unacceptable lag, loading spinners, and single-points-of-failure if internet connectivity drops.

## Decision

We will employ an **offline-first local database architecture** utilizing SQLite managed via the **Drift (Dart)** persistence library.

All reads and writes occur directly against the device's local SQLite file. Synchronous API gates are eliminated. Drift DAOs (Data Access Objects) will manage transaction boundaries and output reactive Streams of database records, allowing the UI to reload automatically when data transitions occur.

## Consequences

* **Positives**:
  * Zero lag on UI actions (reads/writes are instantaneous against local disk).
  * System remains fully functional during network blackouts.
  * Local database schema migrations are cleanly handled by Drift.
* **Negatives**:
  * Multi-device synchronization must be handled asynchronously in a secondary background sync layer (soft-delete pattern, last-writer-wins reconciliations).
  * Schema shifts require structured sqlite migration pipelines.
