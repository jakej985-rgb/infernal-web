# Presentation — AdminRequestsPage

## Purpose

Allows platform Super Users (`su`) to review new shop requests, generate approved invite links, and directly dispatch setups to invited owners.

## Widgets / Visual Style

* **Super User Authorization Gate**: Strictly restricted. Evaluates the user's role on the active session, throwing an immediate "ACCESS DENIED" panel if the role is not `UserRole.su`.
* **"SEND INVITE" Trigger (Floating Button)**: Prominent extended floating action button in the bottom right with a send icon, styled in deep blood red.
* **Interactive Invite Dialog**: Opens an input panel asking for Owner Email (required) and optional Shop Name, Shop ID slug, and Owner Name.
* **Automated Slug & Value Generation**: If left empty, automatically parses the owner's email prefix to construct default shop names, lowercase slugs, and display names, generating valid database rows.
* **"COPY LINK" Action Button**: Copies the unique claimant URL directly to the clipboard.
* **"EMAIL INVITE" Action Button**: High-end gold action button. Automatically copies the unique link and triggers launching the local OS-native email client via a customized pre-filled **mailto** connection (pre-populating the invited owner's email, subject lines, and pre-compiled claim links).

## Uses Classes

* **UserRole** ([UserRole](../classes/enums.md)): Locked strictly to `su` Super Users.
