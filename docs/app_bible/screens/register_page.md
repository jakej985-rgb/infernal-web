# Presentation — RegisterPage

## Purpose

Allows new shop owners to claim an invitation sent by a Super User, or submit a request to create a new multi-tenant shop database.

## Widgets / Visual Style

* **Invited Owner Mode (Claim Link)**: If loaded with query parameters `?id=[requestId]&token=[inviteToken]`, acts as a claim setup form. Pre-fills any pre-defined details, and keeps the Shop Name, Shop ID slug, Owner Display Name fully editable so the claiming owner can configure them.
* **Auto-generated Slug**: Dynamically generates the clean, URL-safe lowercase Shop Code / ID slug in real-time as the owner types their Shop Name.
* **Password Validation**: Validates that a robust password of at least 6 characters is supplied.
* **Submit Request Button**: Displays "INITIALIZE SHOP" in claim mode or "SUBMIT REQUEST" in public request mode.

## Inputs

* Shop Name, Shop Code / ID slug, Owner Email, Owner Name, Password.

## Outputs

* Inserts/claims a tenant in Supabase and initializes their user profile.

## Uses Classes

* **UserRole** ([UserRole](../classes/enums.md)): Standard initial roles configured.
