import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _subscription;

  @override
  ShopSettings build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    
    // Initial fallback from local cache (SharedPreferences) to ensure instant synchronous load
    final cachedSettings = ShopSettings(
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

    // Listen to Firestore document updates to stay real-time
    _subscription = FirebaseFirestore.instance
        .collection('organizations')
        .doc('default-org')
        .snapshots()
        .listen((doc) {
      if (doc.exists) {
        final data = doc.data()?['settings'] as Map<String, dynamic>?;
        if (data != null) {
          final updated = _mapMapToSettings(data);
          state = updated;
          _saveToCache(updated);
        }
      }
    });

    ref.onDispose(() {
      _subscription?.cancel();
    });

    return cachedSettings;
  }

  ShopSettings _mapMapToSettings(Map<String, dynamic> data) {
    return ShopSettings(
      shopName: data['shopName'] as String? ?? 'Infernal Ink & Steel',
      logoPath: data['logoPath'] as String? ?? '',
      accentColor: data['accentColor'] as String? ?? '#FF0000',
      depositType: data['depositType'] as String? ?? 'percentage',
      depositAmount: (data['depositAmount'] as num?)?.toDouble() ?? 20.0,
      tattooPerHour: (data['tattooPerHour'] as num?)?.toDouble() ?? 150.0,
      piercingSingle: (data['piercingSingle'] as num?)?.toDouble() ?? 50.0,
      piercingMulti: (data['piercingMulti'] as num?)?.toDouble() ?? 80.0,
      shopMinimumRate: (data['shopMinimumRate'] as num?)?.toDouble() ?? 80.0,
      taxRate: (data['taxRate'] as num?)?.toDouble() ?? 0.08,
    );
  }

  Future<void> _saveToCache(ShopSettings settings) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString('settings_shop_name', settings.shopName);
    await prefs.setString('settings_logo_path', settings.logoPath);
    await prefs.setString('settings_accent_color', settings.accentColor);
    await prefs.setString('settings_deposit_type', settings.depositType);
    await prefs.setDouble('settings_deposit_amount', settings.depositAmount);
    await prefs.setDouble('settings_tattoo_per_hour', settings.tattooPerHour);
    await prefs.setDouble('settings_piercing_single', settings.piercingSingle);
    await prefs.setDouble('settings_piercing_multi', settings.piercingMulti);
    await prefs.setDouble('settings_shop_minimum_rate', settings.shopMinimumRate);
    await prefs.setDouble('settings_tax_rate', settings.taxRate);
  }

  Future<void> updateShopProfile({
    String? shopName,
    String? logoPath,
    String? accentColor,
  }) async {
    final updates = <String, dynamic>{};
    if (shopName != null) updates['settings.shopName'] = shopName;
    if (logoPath != null) updates['settings.logoPath'] = logoPath;
    if (accentColor != null) updates['settings.accentColor'] = accentColor;

    await FirebaseFirestore.instance
        .collection('organizations')
        .doc('default-org')
        .set(updates, SetOptions(merge: true));
  }

  Future<void> updatePricing({
    double? tattooPerHour,
    double? piercingSingle,
    double? piercingMulti,
    double? shopMinimumRate,
    double? taxRate,
  }) async {
    final updates = <String, dynamic>{};
    if (tattooPerHour != null) updates['settings.tattooPerHour'] = tattooPerHour;
    if (piercingSingle != null) updates['settings.piercingSingle'] = piercingSingle;
    if (piercingMulti != null) updates['settings.piercingMulti'] = piercingMulti;
    if (shopMinimumRate != null) updates['settings.shopMinimumRate'] = shopMinimumRate;
    if (taxRate != null) updates['settings.taxRate'] = taxRate;

    await FirebaseFirestore.instance
        .collection('organizations')
        .doc('default-org')
        .set(updates, SetOptions(merge: true));
  }

  Future<void> updateDepositConfig({
    String? depositType,
    double? depositAmount,
  }) async {
    final updates = <String, dynamic>{};
    if (depositType != null) updates['settings.depositType'] = depositType;
    if (depositAmount != null) updates['settings.depositAmount'] = depositAmount;

    await FirebaseFirestore.instance
        .collection('organizations')
        .doc('default-org')
        .set(updates, SetOptions(merge: true));
  }

  Future<void> resetToDefaults() async {
    const defaultSettings = ShopSettings();
    
    final updates = <String, dynamic>{
      'settings.shopName': defaultSettings.shopName,
      'settings.logoPath': defaultSettings.logoPath,
      'settings.accentColor': defaultSettings.accentColor,
      'settings.depositType': defaultSettings.depositType,
      'settings.depositAmount': defaultSettings.depositAmount,
      'settings.tattooPerHour': defaultSettings.tattooPerHour,
      'settings.piercingSingle': defaultSettings.piercingSingle,
      'settings.piercingMulti': defaultSettings.piercingMulti,
      'settings.shopMinimumRate': defaultSettings.shopMinimumRate,
      'settings.taxRate': defaultSettings.taxRate,
    };

    await FirebaseFirestore.instance
        .collection('organizations')
        .doc('default-org')
        .set(updates, SetOptions(merge: true));
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
