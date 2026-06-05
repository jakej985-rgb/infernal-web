import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/org_provider.dart';
import 'firestore_helpers.dart';

part 'integration_service.g.dart';

class GoogleIntegrationStatus {
  final bool connected;
  final String email;
  final List<String> scopes;

  GoogleIntegrationStatus({
    this.connected = false,
    this.email = '',
    this.scopes = const [],
  });

  factory GoogleIntegrationStatus.fromJson(Map<String, dynamic> json) {
    return GoogleIntegrationStatus(
      connected: json['connected'] as bool? ?? false,
      email: json['email'] as String? ?? '',
      scopes: List<String>.from(json['scopes'] ?? const []),
    );
  }
}

class SmtpIntegrationStatus {
  final bool connected;
  final String host;
  final int port;
  final String user;

  SmtpIntegrationStatus({
    this.connected = false,
    this.host = '',
    this.port = 587,
    this.user = '',
  });

  factory SmtpIntegrationStatus.fromJson(Map<String, dynamic> json) {
    return SmtpIntegrationStatus(
      connected: json['connected'] as bool? ?? false,
      host: json['host'] as String? ?? '',
      port: json['port'] as int? ?? 587,
      user: json['user'] as String? ?? '',
    );
  }
}

class IntegrationConfig {
  final String? type; // 'google' | 'smtp' | null
  final GoogleIntegrationStatus google;
  final SmtpIntegrationStatus smtp;

  IntegrationConfig({
    this.type,
    required this.google,
    required this.smtp,
  });

  factory IntegrationConfig.empty() {
    return IntegrationConfig(
      google: GoogleIntegrationStatus(),
      smtp: SmtpIntegrationStatus(),
    );
  }

  factory IntegrationConfig.fromJson(Map<String, dynamic> json) {
    return IntegrationConfig(
      type: json['type'] as String?,
      google: json['google'] != null
          ? GoogleIntegrationStatus.fromJson(Map<String, dynamic>.from(json['google']))
          : GoogleIntegrationStatus(),
      smtp: json['smtp'] != null
          ? SmtpIntegrationStatus.fromJson(Map<String, dynamic>.from(json['smtp']))
          : SmtpIntegrationStatus(),
    );
  }
}

class GoogleContact {
  final String name;
  final String email;
  final String phone;

  GoogleContact({required this.name, required this.email, required this.phone});

  factory GoogleContact.fromJson(Map<String, dynamic> json) {
    return GoogleContact(
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
    );
  }
}

@riverpod
IntegrationService integrationService(Ref ref) {
  return IntegrationService(ref);
}

@riverpod
Stream<IntegrationConfig> watchIntegrationConfig(Ref ref) {
  final service = ref.watch(integrationServiceProvider);
  return service.watchConfig();
}

class IntegrationService {
  final Ref _ref;
  IntegrationService(this._ref);

  String get _orgId => _ref.read(orgIdProvider);
  FirebaseFunctions get _functions => FirebaseFunctions.instance;

  DocumentReference<Map<String, dynamic>> get _integrationSettingsDoc =>
      orgDoc(_orgId).collection('settings').doc('integration');

  Stream<IntegrationConfig> watchConfig() {
    return _integrationSettingsDoc.snapshots().map((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) {
        return IntegrationConfig.empty();
      }
      return IntegrationConfig.fromJson(snapshot.data()!);
    });
  }

  Future<void> saveSmtpConfig({
    required String host,
    required int port,
    required String user,
    required String password,
  }) async {
    try {
      await _functions.httpsCallable('saveSmtpConfig').call({
        'orgId': _orgId,
        'host': host,
        'port': port,
        'user': user,
        'password': password,
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> testSmtpConnection({
    required String host,
    required int port,
    required String user,
    required String password,
  }) async {
    try {
      await _functions.httpsCallable('testSmtpConnection').call({
        'host': host,
        'port': port,
        'user': user,
        'password': password,
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> disconnectIntegration() async {
    try {
      await _functions.httpsCallable('disconnectIntegration').call({
        'orgId': _orgId,
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<GoogleContact>> getGoogleContacts() async {
    try {
      final response = await _functions.httpsCallable('getGoogleContacts').call({
        'orgId': _orgId,
      });
      final List data = response.data['contacts'] ?? [];
      return data
          .map((item) => GoogleContact.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
