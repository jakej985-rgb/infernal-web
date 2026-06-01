# Shared Persistence Layer & Architectural Boundaries

## 🚨 SOFT BOUNDARY RULE (CRITICAL)

To prevent architectural leakages and maintain clear feature-level isolation during the controlled migration to a real-time central API:

> **ONLY implementations of services inside `shared/persistence/` (e.g., `drift_client_service.dart`) are allowed to import DAOs, tables, or database helper companions.**

### Why this is enforced

1. **Coupling Prevention**: Feature presentation, state management (providers), and widgets must remain entirely database-agnostic. They should interact solely with standard abstractions (e.g., `ClientService` interface).
2. **Dynamic Swapping**: By isolating raw Drift entities inside the services, we can dynamically swap implementations (between Local Drift SQLite and Central real-time REST API) using a central feature toggle.
3. **No Drift Leakage**: No UI features or local providers should directly perform database transactions, query raw tables, or refer to Drift-specific companions.

### How to apply changes

* Define all database query/mutation methods on the feature's shared service interface (e.g., in `lib/shared/data/interfaces/`).
* Implement the methods in a local persistence adapter (e.g., in `lib/shared/persistence/drift_entity_service.dart`) using the respective Dao.
* Expose the implementation via Riverpod and bind it to the central service provider switcher.
