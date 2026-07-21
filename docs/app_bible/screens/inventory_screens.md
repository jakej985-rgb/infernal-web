# Screen — Inventory Hub & Form Screens

## Purpose

Enables studio staff to track, adjust, and catalog consumable studio resources and alert administrators about low stock.

## Widgets

### 1. Inventory Catalog Screen

* **Catalog Grid Grid**: Responsive grid displaying inventory items with color-coded depleting border highlights.
* **Filter Toggle Buttons**: Filters list items by category (e.g., Needles, Inks, Sanitation, PPE).
* **Search Input Field**: Live catalog search text.
* **Quick-Adjustment Buttons**: Plus/minus increment panels on cards to alter stock levels rapidly.

### 2. Supply Registry Form Screen

* **Data Field Fields**: Labeled text inputs for product name, category, standard measuring units, and supplier details.
* **Quantity Limits Fields**: Numeric inputs for initial stock and minimum alert thresholds.
* **"Inscribe Stock" Button**: Commits product entry.

## Inputs

* Catalog filter parameters and form input values.

## Outputs

* Persists and updates inventory rows in local storage.

## Navigation

* `/inventory` → `/inventory/new` (adding catalog items).

## Uses Classes

* **InventoryItem** ([InventoryItem](../classes/inventory.md)): Active persistent entity.

## States

* **Loading**: Catalog cards display glowing gray skeletons.
* **Active**: Renders product catalog grids.
* **Empty State**: Displays clear prompts if search entries match nothing ("The stockroom has no entries matching this search...").
* **Error State**: Outlines invalid stock increments or empty mandatory fields.
