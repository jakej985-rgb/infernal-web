import 'package:drift/drift.dart';

import '../database.dart';
import '../tables/shop_settings_table.dart';

part 'shop_settings_dao.g.dart';

/// Data Access Object for ShopSettings table
/// This manages a singleton settings row (typically id=1)
@DriftAccessor(tables: [ShopSettingsTable])
class ShopSettingsDao extends DatabaseAccessor<AppDatabase>
    with _$ShopSettingsDaoMixin {
  ShopSettingsDao(super.db);

  /// Get the current shop settings
  /// Returns the first (and typically only) settings row
  Future<ShopSettingsTableData?> getSettings() {
    return (select(shopSettingsTable)..limit(1)).getSingleOrNull();
  }

  /// Watch the current shop settings
  Stream<ShopSettingsTableData?> watchSettings() {
    return (select(shopSettingsTable)..limit(1)).watchSingleOrNull();
  }

  /// Update shop settings
  /// If no settings exist, creates a new row
  Future<void> updateSettings(ShopSettingsTableCompanion settings) async {
    final existing = await getSettings();

    final updatedSettings = settings.copyWith(updatedAt: Value(DateTime.now()));

    if (existing == null) {
      // Create new settings
      await into(
        shopSettingsTable,
      ).insert(updatedSettings.copyWith(createdAt: Value(DateTime.now())));
    } else {
      // Update existing
      await (update(
        shopSettingsTable,
      )..where((s) => s.id.equals(existing.id))).write(updatedSettings);
    }
  }

  /// Update only shop profile fields
  Future<void> updateShopProfile({
    String? shopName,
    String? logoPath,
    String? accentColor,
  }) {
    return updateSettings(
      ShopSettingsTableCompanion(
        shopName: shopName != null ? Value(shopName) : const Value.absent(),
        logoPath: logoPath != null ? Value(logoPath) : const Value.absent(),
        accentColor: accentColor != null
            ? Value(accentColor)
            : const Value.absent(),
      ),
    );
  }

  /// Update pricing configuration
  Future<void> updatePricing({
    double? tattooPerHour,
    double? piercingSingle,
    double? piercingMulti,
    double? shopMinimumRate,
    double? taxRate,
  }) {
    return updateSettings(
      ShopSettingsTableCompanion(
        tattooPerHour: tattooPerHour != null
            ? Value(tattooPerHour)
            : const Value.absent(),
        piercingSingle: piercingSingle != null
            ? Value(piercingSingle)
            : const Value.absent(),
        piercingMulti: piercingMulti != null
            ? Value(piercingMulti)
            : const Value.absent(),
        shopMinimumRate: shopMinimumRate != null
            ? Value(shopMinimumRate)
            : const Value.absent(),
        taxRate: taxRate != null ? Value(taxRate) : const Value.absent(),
      ),
    );
  }

  /// Update deposit configuration
  Future<void> updateDepositConfig({
    String? depositType,
    double? depositAmount,
  }) {
    return updateSettings(
      ShopSettingsTableCompanion(
        depositType: depositType != null
            ? Value(depositType)
            : const Value.absent(),
        depositAmount: depositAmount != null
            ? Value(depositAmount)
            : const Value.absent(),
      ),
    );
  }

  /// Update shop hours JSON
  Future<void> updateShopHours(String shopHoursJson) {
    return updateSettings(
      ShopSettingsTableCompanion(shopHoursJson: Value(shopHoursJson)),
    );
  }

  /// Reset settings to defaults
  Future<void> resetToDefaults() async {
    final existing = await getSettings();
    if (existing != null) {
      await (delete(
        shopSettingsTable,
      )..where((s) => s.id.equals(existing.id))).go();
    }

    await into(shopSettingsTable).insert(
      ShopSettingsTableCompanion.insert(
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  }
}
