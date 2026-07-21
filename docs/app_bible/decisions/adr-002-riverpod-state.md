# ADR-002: Riverpod for Unidirectional State Management

Status: Approved  
Date: 2026-01-21  

## Context

A major operational priority is real-time screen reactivity. When stock balances adjust under supply inventory, or client visit histories increment on timeline completions, changes must reflect on dashboards ("The Altar") and logs instantly.

Uncoordinated state handlers lead to caching desynchronizations, visual lag, and analyzer errors in deep widget structures.

## Decision

We will utilize **Riverpod 3.x** as the canonical state management package across all features.

State flows will be unidirectional. UI views read database streams exposed via Riverpod `StreamProvider` and `NotifierProvider` containers. Writes are initiated via explicit action methods (Commands) on the provider's corresponding `Notifier` class, which alters SQLite rows on write transactions, automatically prompting reactive streams to update listening widgets.

## Consequences

* **Positives**:
  * Predictable data cycles (View → Command → DB write → React reload → View update).
  * Direct isolation of state container logic from visual layout code.
  * Simple unit testing of provider structures independent of active simulator runs.
* **Negatives**:
  * Introduces minor code generator overhead (`build_runner` compilation delays).
