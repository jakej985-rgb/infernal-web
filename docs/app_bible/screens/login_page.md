# Presentation — LoginPage

## Purpose

Enables users (Super Users, Admins, or Artists) to securely authenticate against the Supabase backend authentication system.

## Widgets / Visual Style

* **Themed Background Artwork Frame**: Custom gothic visual style incorporating branding and logo.
* **Header Typography**: Displaying the gothic brand "Infernal Ink & Steel".
* **Email Field**: Standard email address text input.
* **Password Field**: Obscured text field with password visibility toggle.
* **"Summon Session" Button**: Prominent crimson button executing login.

## Inputs

* `email` (`String`): Email address.
* `password` (`String`): Password.

## Outputs

* Triggers state mutations in the Auth Provider.
* Redirects the active viewport to `/home` (Dashboard).

## Navigation

* `/login` → `/home` (upon successful login).
* `/login` → `/register` (to register).

## Uses Classes

* **User** ([User](../classes/user.md)): Validates credentials and parses session.
