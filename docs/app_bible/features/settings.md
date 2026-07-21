# Feature — Shop Settings ("The Decree Setup")

## Purpose

Allows administrators to establish global studio parameters, tax rates, standard hourly pricing, operating hour schedules, and visual styling configs. This serves as the master policy database.

## User Flow

1. **Access Panel**: An authenticated Admin navigates to the Settings menu.
2. **Review Options**: The user browses collapsible sections for Shop Profile, Pricing, Operating Hours, and Advanced.
3. **Form Customization**: The user updates values (e.g., changes hourly tattoo rates, updates cancellation policies, or modifies weekend opening hours).
4. **Trigger Registry Writes**: Tapping "Inscribe Decree" saves the state. Changes propagate immediately to all booking and quote components.
5. **Reset Default Configurations**: An override command exists to purge local tweaks, restoring parameters back to default studio specifications.

## Classes Used

* **ShopSettings** ([ShopSettings](../classes/shop_settings.md)): Active global configuration structure.
* **ShopDaySetting** ([ShopSettings](../classes/shop_settings.md)): Daily operational bounds.

## Commands

* `updateShopSettings(ShopSettings settings)`: Commits updated configuration matrices to local storage.
* `resetSettingsToDefault()`: Purges local modifications, restoring global parameters back to default studio configurations.

## Queries

* `getShopSettingsStream()` (`Stream<ShopSettings>`): Returns a reactive Stream of the global settings row.
* `getShopSettings()` (`Future<ShopSettings>`): Resolves standard configurations immediately.

## Validation

* Tax rate fractions must fall within 0.0 and 1.0 limits.
* All pricing variables (hourly rate, piercing fees, shop minimum) must be non-negative.
* Closing hour minutes must exceed opening minutes on any operational day.

## Edge Cases

* **Missing Settings Row**: On fresh installations, SQLite tables will be empty. The system intercepts the null check, executing automatic migrations to seed standard global configurations immediately before drawing UI forms.

## Future Ideas

* **Custom Color Themes**: Custom theme compilers letting admins tweak theme accent colors to generate customized CSS glow patterns.
* **Automatic Cloud Backups**: Toggle to automatically upload database backup snapshots to private S3 cloud folders on schedule.
