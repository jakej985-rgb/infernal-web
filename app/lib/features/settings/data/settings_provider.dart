import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../shared/persistence/database.dart';

part 'settings_provider.g.dart';

/// Provider for shop settings - using raw StreamProvider to avoid generator issues with Drift types
final shopSettingsProvider = StreamProvider<ShopSettingsTableData?>((ref) {
  final dao = ref.watch(databaseProvider).shopSettingsDao;
  return dao.watchSettings();
});

@riverpod
SettingsService settingsService(Ref ref) {
  return SettingsService(ref);
}

class SettingsService {
  final Ref _ref;
  SettingsService(this._ref);

  Future<void> updateShopProfile({
    String? shopName,
    String? logoPath,
    String? accentColor,
  }) async {
    final dao = _ref.read(databaseProvider).shopSettingsDao;
    await dao.updateShopProfile(
      shopName: shopName,
      logoPath: logoPath,
      accentColor: accentColor,
    );
  }

  Future<void> updatePricing({
    double? tattooPerHour,
    double? piercingSingle,
    double? piercingMulti,
    double? shopMinimumRate,
    double? taxRate,
  }) async {
    final dao = _ref.read(databaseProvider).shopSettingsDao;
    await dao.updatePricing(
      tattooPerHour: tattooPerHour,
      piercingSingle: piercingSingle,
      piercingMulti: piercingMulti,
      shopMinimumRate: shopMinimumRate,
      taxRate: taxRate,
    );
  }

  Future<void> updateDepositConfig({
    String? depositType,
    double? depositAmount,
  }) async {
    final dao = _ref.read(databaseProvider).shopSettingsDao;
    await dao.updateDepositConfig(
      depositType: depositType,
      depositAmount: depositAmount,
    );
  }

  Future<void> resetToDefaults() async {
    final dao = _ref.read(databaseProvider).shopSettingsDao;
    await dao.resetToDefaults();
  }
}

