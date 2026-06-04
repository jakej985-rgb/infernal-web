import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/org_provider.dart';
import 'firestore_helpers.dart';

part 'settings_service.g.dart';

@riverpod
SettingsService settingsService(Ref ref) {
  return SettingsService(ref);
}

class SettingsService {
  final Ref _ref;
  SettingsService(this._ref);

  String get _orgId => _ref.read(orgIdProvider);

  DocumentReference<Map<String, dynamic>> get _settingsDoc =>
      orgDoc(_orgId).collection('settings').doc('main');

  Stream<DocumentSnapshot<Map<String, dynamic>>> watchSettings() {
    return _settingsDoc.snapshots();
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

    await _settingsDoc.set(updates, SetOptions(merge: true));
  }

  Future<void> updatePricing({
    double? tattooPerHour,
    double? piercingSingle,
    double? piercingMulti,
    double? shopMinimumRate,
    double? taxRate,
  }) async {
    final updates = <String, dynamic>{};
    if (tattooPerHour != null) {
      updates['settings.tattooPerHour'] = tattooPerHour;
    }
    if (piercingSingle != null) {
      updates['settings.piercingSingle'] = piercingSingle;
    }
    if (piercingMulti != null) {
      updates['settings.piercingMulti'] = piercingMulti;
    }
    if (shopMinimumRate != null) {
      updates['settings.shopMinimumRate'] = shopMinimumRate;
    }
    if (taxRate != null) updates['settings.taxRate'] = taxRate;

    await _settingsDoc.set(updates, SetOptions(merge: true));
  }

  Future<void> updateDepositConfig({
    String? depositType,
    double? depositAmount,
  }) async {
    final updates = <String, dynamic>{};
    if (depositType != null) updates['settings.depositType'] = depositType;
    if (depositAmount != null) {
      updates['settings.depositAmount'] = depositAmount;
    }

    await _settingsDoc.set(updates, SetOptions(merge: true));
  }

  Future<void> resetToDefaults(Map<String, dynamic> defaultUpdates) async {
    await _settingsDoc.set(defaultUpdates, SetOptions(merge: true));
  }
}
