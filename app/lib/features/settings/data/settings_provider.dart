import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../shared/util/shared_prefs_provider.dart';

part 'settings_provider.g.dart';

class ShopSettings {
  final String shopName;
  final String logoPath;
  final String accentColor;
  final String depositType;
  final double depositAmount;
  final double tattooPerHour;
  final double piercingSingle;
  final double piercingMulti;
  final double shopMinimumRate;
  final double taxRate;

  const ShopSettings({
    this.shopName = 'Infernal Ink & Steel',
    this.logoPath = '',
    this.accentColor = '#FF0000',
    this.depositType = 'percentage',
    this.depositAmount = 20.0,
    this.tattooPerHour = 150.0,
    this.piercingSingle = 50.0,
    this.piercingMulti = 80.0,
    this.shopMinimumRate = 80.0,
    this.taxRate = 0.08,
  });

  ShopSettings copyWith({
    String? shopName,
    String? logoPath,
    String? accentColor,
    String? depositType,
    double? depositAmount,
    double? tattooPerHour,
    double? piercingSingle,
    double? piercingMulti,
    double? shopMinimumRate,
    double? taxRate,
  }) {
    return ShopSettings(
      shopName: shopName ?? this.shopName,
      logoPath: logoPath ?? this.logoPath,
      accentColor: accentColor ?? this.accentColor,
      depositType: depositType ?? this.depositType,
      depositAmount: depositAmount ?? this.depositAmount,
      tattooPerHour: tattooPerHour ?? this.tattooPerHour,
      piercingSingle: piercingSingle ?? this.piercingSingle,
      piercingMulti: piercingMulti ?? this.piercingMulti,
      shopMinimumRate: shopMinimumRate ?? this.shopMinimumRate,
      taxRate: taxRate ?? this.taxRate,
    );
  }
}

@riverpod
class ShopSettingsNotifier extends _$ShopSettingsNotifier {
  @override
  ShopSettings build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return ShopSettings(
      shopName: prefs.getString('settings_shop_name') ?? 'Infernal Ink & Steel',
      logoPath: prefs.getString('settings_logo_path') ?? '',
      accentColor: prefs.getString('settings_accent_color') ?? '#FF0000',
      depositType: prefs.getString('settings_deposit_type') ?? 'percentage',
      depositAmount: prefs.getDouble('settings_deposit_amount') ?? 20.0,
      tattooPerHour: prefs.getDouble('settings_tattoo_per_hour') ?? 150.0,
      piercingSingle: prefs.getDouble('settings_piercing_single') ?? 50.0,
      piercingMulti: prefs.getDouble('settings_piercing_multi') ?? 80.0,
      shopMinimumRate: prefs.getDouble('settings_shop_minimum_rate') ?? 80.0,
      taxRate: prefs.getDouble('settings_tax_rate') ?? 0.08,
    );
  }

  Future<void> updateShopProfile({
    String? shopName,
    String? logoPath,
    String? accentColor,
  }) async {
    final prefs = ref.read(sharedPreferencesProvider);
    if (shopName != null) await prefs.setString('settings_shop_name', shopName);
    if (logoPath != null) await prefs.setString('settings_logo_path', logoPath);
    if (accentColor != null) await prefs.setString('settings_accent_color', accentColor);
    ref.invalidateSelf();
  }

  Future<void> updatePricing({
    double? tattooPerHour,
    double? piercingSingle,
    double? piercingMulti,
    double? shopMinimumRate,
    double? taxRate,
  }) async {
    final prefs = ref.read(sharedPreferencesProvider);
    if (tattooPerHour != null) await prefs.setDouble('settings_tattoo_per_hour', tattooPerHour);
    if (piercingSingle != null) await prefs.setDouble('settings_piercing_single', piercingSingle);
    if (piercingMulti != null) await prefs.setDouble('settings_piercing_multi', piercingMulti);
    if (shopMinimumRate != null) await prefs.setDouble('settings_shop_minimum_rate', shopMinimumRate);
    if (taxRate != null) await prefs.setDouble('settings_tax_rate', taxRate);
    ref.invalidateSelf();
  }

  Future<void> updateDepositConfig({
    String? depositType,
    double? depositAmount,
  }) async {
    final prefs = ref.read(sharedPreferencesProvider);
    if (depositType != null) await prefs.setString('settings_deposit_type', depositType);
    if (depositAmount != null) await prefs.setDouble('settings_deposit_amount', depositAmount);
    ref.invalidateSelf();
  }

  Future<void> resetToDefaults() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.remove('settings_shop_name');
    await prefs.remove('settings_logo_path');
    await prefs.remove('settings_accent_color');
    await prefs.remove('settings_deposit_type');
    await prefs.remove('settings_deposit_amount');
    await prefs.remove('settings_tattoo_per_hour');
    await prefs.remove('settings_piercing_single');
    await prefs.remove('settings_piercing_multi');
    await prefs.remove('settings_shop_minimum_rate');
    await prefs.remove('settings_tax_rate');
    ref.invalidateSelf();
  }
}

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
    await _ref.read(shopSettingsProvider.notifier).updateShopProfile(
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
    await _ref.read(shopSettingsProvider.notifier).updatePricing(
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
    await _ref.read(shopSettingsProvider.notifier).updateDepositConfig(
      depositType: depositType,
      depositAmount: depositAmount,
    );
  }

  Future<void> resetToDefaults() async {
    await _ref.read(shopSettingsProvider.notifier).resetToDefaults();
  }
}
