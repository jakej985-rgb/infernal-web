# InventoryItem

## Purpose

Represents a tracked consumable item or studio supply resource (such as tattoo needles, cartridges, specialized inks, sanitary gear, barriers, or personal protective equipment) stocked inside the studio, conceptually known as the **Supply Inventory** or **Arsenal Stock**.

## Responsibilities

* Persist the product profile details, current stock quantities, and warning threshold boundaries.
* Identify which supplies require urgent re-ordering or are approaching depletion levels.
* Maintain metadata references for suppliers, allowing quick outbound restock workflows.
* Keep precise timestamps and modifier signatures to support offline database auditing.

## Properties

* `id` (`int`): Primary domain identifier.
* `syncId` (`String`): Globally unique identifier (UUID) for offline synchronization and replication.
* `name` (`String`): Descriptive title of the supply item (e.g., `"3RL Liners Box"`, `"Dynamic Black Ink 8oz"`).
* `category` (`String`): Resource classification group (e.g., `"Needles"`, `"Inks"`, `"Sanitation"`, `"PPE"`).
* `unit` (`String`): Measuring unit format (e.g., `"Box of 50"`, `"Bottle"`, `"Roll"`, `"Box of 100"`).
* `stockQuantity` (`double`): Current physical count remaining in stock. Represented as double to support volume measurements.
* `thresholdLimit` (`double`): Critical count limit trigger. If `stockQuantity` falls strictly below this value, the item is categorized as "Depleted".
* `supplierName` (`String?`): Name of the vendor or distributor supplying the product.
* `supplierContact` (`String?`): Contact coordinates (email or phone) of the vendor for rapid re-orders.
* `lastOrderedDate` (`DateTime?`): Timestamp tracking when the item was last restocked or ordered (UTC).
* `lastModifiedUtc` (`DateTime`): Timestamp of the last local mutation (UTC).
* `lastModifiedBy` (`String`): Signature tag of the user or system thread that executed the last update.
* `isDeleted` (`bool`): Soft-delete flag utilized for synchronization compatibility.

---

## Methods

### Commands

* `InventoryItem.fromJson(Map<String, dynamic> json)`: Reconstructs an inventory item profile from serialized database rows.

### Queries

* `bool get isLowStock`: Calculated query returning `true` if `stockQuantity` is strictly less than `thresholdLimit`.
* `String get stockStatusLabel`: Returns `"LOW STOCK"` if `isLowStock` is `true`, otherwise returns `"IN STOCK"`.
* `toJson()` (`Map<String, dynamic>`): Serializes item metadata into standard persistent JSON maps.

---

## Validation Rules

* **Name**: Must contain at least one non-whitespace character.
* **Quantity Limits**: Both `stockQuantity` and `thresholdLimit` must be non-negative numbers (`>= 0.0`).
* **Minimum Adjustments**: Local adjustment commands must prevent manual subtractions that would reduce `stockQuantity` below `0.0`.

---

## Relationships

### Owns

* None directly. It functions as an independent catalog entry in the inventory registry.

### Owned By

* **The Studio Stockroom**: Managed globally in the database store.

### Uses

* None.

### Used By

* **Supply Inventory Feature** (`SupplyFeature`): Managed by features logging adjustments and catalog configurations.
* **Inventory Catalog Screens** (`InventoryScreens`): Rendered in grid catalog views and creation forms.
* **System Admin Feature** (`AdminFeature`): Monitored for stock level changes and auditing trails.

---

## Future Expansion

* **Supplier Catalogs Integration**: Direct lookup links between inventory items and specific online shop checkout pages.
* **Usage Predictor**: An algorithm calculating average weekly consumption speeds to predict when a stock threshold will be crossed based on future appointment loads.

---

## Open Questions

* Should we introduce a strict Enum for `category` to replace the freeform String classification? (String is kept for legacy compatibility and to support custom user-defined supply categories easily).
