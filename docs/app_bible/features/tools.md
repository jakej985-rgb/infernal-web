# Feature — Arsenal Utilities ("Standalone Tools")

## Purpose

Provides interactive visual tools supporting artist consultations and client engagement, specifically an interactive body-pain map estimator and an animated flash-design selection roulette wheel.

## User Flow

1. **Entering the Arsenal**: The user opens `/tools`, displaying the utilities grid.
2. **Consulting the Pain Estimator**:
   * The user clicks "Pain Estimator", rendering an interactive front/back body silhouette.
   * Selecting any body region highlight flashes its pain rating (scale 1 to 5) and estimated healing ranges (e.g., "Ribs: Pain 5/5, Healing 3-4 Weeks").
3. **Triggering Flash Roulette**:
   * The user clicks "Flash Roulette" to choose random designs.
   * Tapping "Spin the Wheel" starts an overlay animation, cycling through standard flash designs until it settles on a random result.

---

## Classes Used

None. (These visual helpers are entirely procedural UI widgets and do not persist data records in domain classes).

---

## Commands

None. (This standalone feature consists of transient animation and query states).

---

## Queries

* `PainMetadata getRegionPain(String bodyPartId)`: Returns predefined pain levels and average healing runtimes for body parts.
* `FlashDesign getRandomFlash()`: Pulls a random flash item from configured asset collections.

---

## Validation

None.

---

## Edge Cases

* **No Assets Available**: If no flash images are found in local assets, the Roulette falls back to rendering standard placeholder designs containing themed text prompt cards (e.g., "Reaper", "Skull", "Snake").

---

## Future Ideas

* **Direct Booking integration**: Clicking the roulette result directly triggers `/appointments/new` pre-populated with the selected flash item.
