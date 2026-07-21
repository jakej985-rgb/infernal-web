# Screen — Login Screen

## Purpose

Enables users (Admins or Artists) to securely authenticate locally against the SQLite database using BCrypt credential hashing.

## Widgets

* **Themed Background Artwork Frame**: Custom visual frame incorporating background imagery.
* **Header Typography**: Displaying the gothic-themed brand.
* **Username Field**: Custom input field with hover effects and focus states.
* **Password Field**: Obscured text field with eye toggle icons to show/hide plaintext keys.
* **"Summon Session" Button**: Primary execution button.
* **"Bootstrap Demo" Button**: Discrete, secondary button allowing admins to bootstrap default credentials.

## Inputs

* `username` (`String`): Extracted text input.
* `password` (`String`): Extracted obscured password text.

## Outputs

* Triggers state mutations in the Auth Provider.
* Relocates the active router viewport to `/dashboard`.

## Navigation

* `/login` → `/dashboard` (upon successful login).

## Uses Classes

* **User** ([User](../classes/user.md)): Fetches credentials to evaluate hashes.

## States

* **Unauthenticated**: Standard form display.
* **Submitting**: Spinner overlays disabling all buttons.
* **Empty State**: Bypassed (standard form draws fields).
* **Error State**: Outlines invalid credentials, locked accounts, or empty forms with detailed, red glow warning badges.
