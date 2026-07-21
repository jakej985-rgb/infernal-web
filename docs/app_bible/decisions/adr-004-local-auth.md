# ADR-004: Role-Based Local Hashed Authentication

Status: Approved  
Date: 2026-01-21  

## Context

Because the application is offline-first and coordinates business activities locally, authentication must also operate standalone without requiring connection to a secure cloud identity provider (like Auth0 or Firebase Auth) or an active backend server during startup.

However, storing raw passwords in plaintext inside the local SQLite database leaves client medical data and billing records vulnerable to simple extraction if devices are lost, stolen, or accessed by unauthorized actors.

## Decision

We will execute all user logins against local database credentials, verifying passwords against highly secure **BCrypt hashes** stored within the `passwordHash` column.

The application incorporates a local BCrypt verification package. Plaintext password strings entered by users on the login splash undergo hashing before comparison queries run against SQL tables. Session tokens are held in Riverpod memory slots, automatically cleared when logging out or during session expirations.

## Consequences

* **Positives**:
  * Guarantees secure, standalone authentication during network blackouts.
  * Protects credentials from simple extraction and dump attacks.
  * Seamlessly isolates permissions matching active UserRole attributes (`admin` or `artist`).
* **Negatives**:
  * Password recovery requires another active Admin user to execute a reset Command on their profile (or seeding the database back to demo states if the lone admin password is lost).
