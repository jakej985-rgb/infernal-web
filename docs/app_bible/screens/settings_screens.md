# Screen — Settings & Integrations Screens

## Purpose

Enables Administrators to configure studio profiles, default rates, weekly operating schedules, and local database backup destinations.

## Widgets

* **Shop Profile Collapsible Panel**: Contains text fields for shop name, custom logos, and primary brand colors.
* **Pricing Parameters Panel**: Holds input grids to adjust hourly tattoo rates, piercing fees, minimum charges, and sales tax multipliers.
* **Operational Schedule Table Grid**: A styled list of weekdays displaying toggles to open/close slots and integer sliders to adjust hour boundaries.
* **"Inscribe Decree" Button**: Primary commit panel.
* **"Reset Default Settings" Command**: secondary trigger purging manual settings values.

## Inputs

* Form values and toggles.

## Outputs

* Persists singleton shop configurations.

## Navigation

* `/settings` → `/dashboard` (exit navigation).

## Uses Classes

* **ShopSettings** ([ShopSettings](../classes/shop_settings.md)): Persistent global data structure.
* **ShopDaySetting** ([ShopSettings](../classes/shop_settings.md)): Weekend open/close ranges.

## States

* **Active**: Draws configuration forms.
* **Submitting**: Spinner states disabling input controls.
* **Empty State**: Bypassed. Seeding algorithms guarantee settings rows are present.
* **Error State**: Outlines invalid hours or negative prices with glows.
