# Presentation — SettingsPage

## Purpose

Centralized hub for all local shop profiles, pricing rates, deposit rules, language terminology override parameters, and admin tools.

## Widgets / Visual Style

* **Adaptive Settings Sections (Neon Cards)**: Settings categories structured into beautiful `NeonPlate` sections:
  * Shop Configuration (Pricing, Deposits, Google/SMTP integrations)
  * Administration (Shop Requests - visible ONLY to `su` Super Users, User Management, System status)
  * Theme (Terminology settings, custom label override dialogs)
  * System (Factory resets)
* **Access Control Partitioning**: Uses the user's logged-in session role to evaluate `isSystemAdmin`. If `role == UserRole.su` (Super User), displays the "Shop Requests" option; otherwise, hides it.

## Uses Classes

* **ShopSettings** ([ShopSettings](../classes/shop_settings.md)): Active shop settings state.
* **UserRole** ([UserRole](../classes/enums.md)): For Super User authorization checks.
