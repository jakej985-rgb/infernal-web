# Feature — Supply Inventory ("The Stockroom")

## Purpose

Enables studio administrators and artists to track, categorize, and log adjustments for consumable studio resources (needles, cartridges, inks, sanitary gear, PPE). This ensures that critical resources never run out during booked studio operations, triggering proactive depleted-inventory warning alerts.

## User Flow

1. **Browse stockroom**: The user accesses the Inventory hub, reviewing a catalog grid. Items listing quantities under threshold limits highlight with orange warning banners ("Depleted Stock").
2. **Review suppliers and logs**: Selecting an item opens its metadata profile detailing units, supplier contact cards, and the last ordered dates.
3. **Register adjustments**: Tapping an item's quick numeric increment selectors adds or subtracts from the current stock balance (e.g., checking in new deliveries, or recording box utilization).
4. **Catalog entry**: Staff can register new item configurations using standard forms, inputting names, categories, initial stock levels, and safety threshold trigger balances.

## Classes Used

* **InventoryItem** ([InventoryItem](../classes/inventory.md)): Core persistent entity.

## Commands

* `createInventoryItem(InventoryItem item)`: Saves a new product profile.
* `adjustStockLevel(int id, double quantityAdjustment)`: Modifies active quantities up or down.
* `deleteInventoryItem(int id)`: Executes a soft delete on catalog entries.

## Queries

* `getInventoryCatalogStream()` (`Stream<List<InventoryItem>>`): Emits reactive, live updates of all non-deleted inventory entries.
* `getLowStockItems()` (`Future<List<InventoryItem>>`): Retrieves products whose balances lie strictly below threshold values.

## Validation

* Item descriptions must not be blank.
* Stock level adjustments must not drive `stockQuantity` totals to negative balances.

## Edge Cases

* **Manual Bulk Counts**: In fast-paced environments, physical counts can drift from software ledger figures. Adjustments are logged with standard audit-trails, enabling admins to correct counts to reconcile physical vs digital counts.

## Future Ideas

* **Purchase Orders Generation**: Automatic compiler assembling re-order PDFs matching depleted products to send to registered suppliers via email.
* **Barcode Camera Scanning**: Harnessing tablet cameras to scan supply barcodes for fast stock checkout.
