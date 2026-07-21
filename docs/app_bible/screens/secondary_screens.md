# Screen Directory — Secondary Screens

This document provides complete visual, state, and interaction definitions for all secondary screens of the application: **Quotes**, **Documents**, **Inventory**, **Communications**, **Settings**, **Reports**, **Tools**, and **Admin**.

---

## 📐 1. Quote Calculator Screens

### Purpose — Quote Calculator

Calculates and reviews tattoo pricing ranges based on multi-factor visual complexity dimensions.

### Screens Map — Quote Calculator

1. **Quote List (`/quotes`)**: Browse registered estimates.
2. **Quote Form (`/quotes/new`)**: Interactive complexity sliding nodes and calculated outputs.
3. **Quote Details (`/quotes/:id`)**: Displays recommended deposits, confidence ratings, and notes.

### Widgets — Quote Calculator

* **Complexity Sliders**: 5 custom row sliders (Coverage, Lines, Shading, Color, Difficulty) scaling from 1 to 5.
* **Camera Loader**: Tap-action button linking reference sketch files.
* **Price Oracle Panel**: Animated glowing result box printing estimated hours, prices, and recommended deposit totals.

### Navigation — Quote Calculator

* **New Quote FAB** → `/quotes/new`
* **Card Row Tap** → `/quotes/:id`
* **Promote CTA** → `/appointments/new?quoteId=:id`

### Uses Classes — Quote Calculator

* [Quote](../classes/quote.md)

### States — Quote Calculator

* **Empty list state**: Displays placeholder: *"No scrolls written in the quote archives."*

---

## 📂 2. Document Vault Screens

### Purpose — Document Vault

Lists and archives signed legal treaties, consent waivers, and medical history images.

### Screens Map — Document Vault

1. **Documents List (`/documents`)**: Vertical grid of file thumbnails.
2. **Document Upload Form (`/documents/new`)**: Input fields for titles and camera selectors.
3. **Document Viewer (`/documents/:id`)**: Full-screen preview of images/PDFs.

### Widgets — Document Vault

* **Visual Grid Layout**: Card thumbnails separating PDFs from Image stencils.
* **Camera Capture FAB**: Trigger button launch.

### Uses Classes — Document Vault

* [Document](../classes/document.md)

---

## 📦 3. Inventory Stock Screens

### Purpose — Inventory Stock

Visual stock-room tracking of sanitary consumable supplies.

### Screens Map — Inventory Stock

1. **Inventory Hub (`/inventory`)**: Stock catalogs grouped by type (Needles, Pigments, Sanitary, Durables).
2. **Item Form (`/inventory/new` or `/inventory/:id/edit`)**: Fields for units, quantities, alerts, and suppliers.

### Widgets — Inventory Stock

* **Stock Panels Grid**: Multi-tab scrolling tables.
* **Depletion Flash Warning**: Subtle pulsing red borders labeling items whose stock is less than alert thresholds.

### Uses Classes — Inventory Stock

* [InventoryItem](../classes/inventory.md)

---

## 💬 4. Communications Log Screen

### Purpose — Communications Log

Immutable chronological Thread stream auditing out-going client notification alerts.

### Screens Map — Communications Log

* **Log Thread View (`/communications`)**: Dual-pane layout sorting dispatches.

### Widgets — Communications Log

* **Status Badge Indicators**: Color-coded delivery markers (Green: `SENT`, Amber: `PENDING`, Red: `FAILED`).
* **Client Bubble Threads**: Left/Right bubbles displaying text logs.

### Uses Classes — Communications Log

* [CommunicationRitual](../classes/communication.md)

---

## ⚙️ 5. Settings & Config Screens

### Purpose — Settings & Config

Manages administrative visual identities and pricing parameters.

### Screens Map — Settings & Config

1. **Settings Hub (`/settings`)**: Multi-choice list grouping directories.
2. **Integrations Panel (`/settings/integrations`)**: Cloud backup configs and gateway linkages.

### Widgets — Settings & Config

* **Schedule Hour Sliders**: Daily opening/closing minute dial controls.
* **Profile Text Rows**: Simple contact boxes.

### Uses Classes — Settings & Config

* [ShopSettings](../classes/shop_settings.md)

---

## 📈 6. Stats & Reports Screen

### Purpose — Stats & Reports

Business intelligence chart visualizations.

### Screens Map — Stats & Reports

* **Reports Dashboard (`/reports`)**: Date-bounded charts panel.

### Widgets — Stats & Reports

* **Revenue Line Graph**: Custom canvas plot mapping sales over time.
* **Service Type Pie Chart**: Radial category percentage maps.
* **Artist Leaderboard List**: Table listing bills, times, and splits.

### Uses Classes — Stats & Reports

* [Appointment](../classes/appointment.md)
* [User](../classes/user.md)

---

## 🛠️ 7. Arsenal Standalone Tools Screens

### Purpose — Arsenal Standalone Tools

Consultation utilities for body art planning.

### Screens Map — Arsenal Standalone Tools

1. **Tools Hub (`/tools`)**: Choice grid.
2. **Body Pain Estimator (`/tools/pain-estimator`)**: Interactive body pain map.
3. **Flash Roulette (`/tools/flash-roulette`)**: Animated random design wheel.

### Widgets — Arsenal Standalone Tools

* **Interactive Body Silhouette**: SVG-based body mesh highlights returning pain scales and healing text on tap.
* **Animated Spin Wheel**: Staggered spinning wheel executing random selections.

---

## 👑 8. System Administration Screens

### Purpose — System Administration

Roster directories and security logs restricted to Admins.

### Screens Map — System Administration

1. **User Directory (`/admin/users`)**: Staff lists showing billing parameters.
2. **User Form (`/admin/users/new`)**: Fields for commissions, usernames, and passwords.
3. **System Audit Logs (`/admin/logs`)**: Scrolling thread of immutable DB audit items.

### Widgets — System Administration

* **Audit Logs Viewer**: Glowing color-coded log list showing system metadata.
* **Commission Sliders**: Input nodes parsing decimal fractions.

### Uses Classes — System Administration

* [User](../classes/user.md)
* **AuditLog**
