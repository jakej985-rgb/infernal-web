import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/org_provider.dart';

part 'settings_service.g.dart';

class SettingsSnapshot {
  final Map<String, dynamic>? dataMap;
  final bool exists;
  SettingsSnapshot({required this.exists, this.dataMap});

  Map<String, dynamic>? data() => dataMap;
}

@riverpod
SettingsService settingsService(Ref ref) {
  return SettingsService(ref);
}

class SettingsService {
  final Ref _ref;
  SettingsService(this._ref);

  String get _orgId => _ref.read(orgIdProvider);

  Stream<SettingsSnapshot> watchSettings() {
    final client = sb.Supabase.instance.client;
    return client
        .from('settings')
        .stream(primaryKey: ['org_id'])
        .eq('org_id', _orgId)
        .map((data) {
          if (data.isEmpty) {
            return SettingsSnapshot(exists: false);
          }
          final row = data.first;
          final settingsMap = {
            'shopName': row['shop_name'],
            'logoPath': row['logo_path'],
            'accentColor': row['accent_color'],
            'depositType': row['deposit_type'],
            'depositAmount': (row['deposit_amount'] as num?)?.toDouble(),
            'tattooPerHour': (row['tattoo_per_hour'] as num?)?.toDouble(),
            'piercingSingle': (row['piercing_single'] as num?)?.toDouble(),
            'piercingMulti': (row['piercing_multi'] as num?)?.toDouble(),
            'shopMinimumRate': (row['shop_minimum_rate'] as num?)?.toDouble(),
            'taxRate': (row['tax_rate'] as num?)?.toDouble(),
          };
          return SettingsSnapshot(
            exists: true,
            dataMap: {'settings': settingsMap},
          );
        });
  }

  Future<void> updateShopProfile({
    String? shopName,
    String? logoPath,
    String? accentColor,
  }) async {
    final client = sb.Supabase.instance.client;
    final updates = <String, dynamic>{};
    if (shopName != null) updates['shop_name'] = shopName;
    if (logoPath != null) updates['logo_path'] = logoPath;
    if (accentColor != null) updates['accent_color'] = accentColor;

    await client
        .from('settings')
        .upsert({'org_id': _orgId, ...updates});
  }

  Future<void> updatePricing({
    double? tattooPerHour,
    double? piercingSingle,
    double? piercingMulti,
    double? shopMinimumRate,
    double? taxRate,
  }) async {
    final client = sb.Supabase.instance.client;
    final updates = <String, dynamic>{};
    if (tattooPerHour != null) updates['tattoo_per_hour'] = tattooPerHour;
    if (piercingSingle != null) updates['piercing_single'] = piercingSingle;
    if (piercingMulti != null) updates['piercing_multi'] = piercingMulti;
    if (shopMinimumRate != null) updates['shop_minimum_rate'] = shopMinimumRate;
    if (taxRate != null) updates['tax_rate'] = taxRate;

    await client
        .from('settings')
        .upsert({'org_id': _orgId, ...updates});
  }

  Future<void> updateDepositConfig({
    String? depositType,
    double? depositAmount,
  }) async {
    final client = sb.Supabase.instance.client;
    final updates = <String, dynamic>{};
    if (depositType != null) updates['deposit_type'] = depositType;
    if (depositAmount != null) updates['deposit_amount'] = depositAmount;

    await client
        .from('settings')
        .upsert({'org_id': _orgId, ...updates});
  }

  Future<void> resetToDefaults(Map<String, dynamic> defaultUpdates) async {
    final client = sb.Supabase.instance.client;
    final mappedUpdates = <String, dynamic>{};
    defaultUpdates.forEach((key, value) {
      final subKey = key.replaceFirst('settings.', '');
      final colName = _toSnakeCase(subKey);
      mappedUpdates[colName] = value;
    });

    await client
        .from('settings')
        .upsert({'org_id': _orgId, ...mappedUpdates});
  }

  String _toSnakeCase(String str) {
    return str.replaceAllMapped(RegExp(r'([A-Z])'), (Match m) => '_${m[1]!.toLowerCase()}');
  }
}
