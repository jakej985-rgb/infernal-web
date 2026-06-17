import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/org_provider.dart';

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

  Stream<IntegrationConfig> watchConfig() {
    final client = sb.Supabase.instance.client;
    return client
        .from('integration_settings')
        .stream(primaryKey: ['org_id'])
        .eq('org_id', _orgId)
        .map((data) {
          if (data.isEmpty) {
            return IntegrationConfig.empty();
          }
          final row = data.first;
          return IntegrationConfig.fromJson({
            'type': row['type'],
            'google': {
              'connected': row['google_connected'],
              'email': row['google_email'],
              'scopes': row['google_scopes'] != null ? List<String>.from(row['google_scopes']) : [],
            },
            'smtp': {
              'connected': row['smtp_connected'],
              'host': row['smtp_host'],
              'port': row['smtp_port'],
              'user': row['smtp_user'],
            }
          });
        });
  }

  Future<void> saveSmtpConfig({
    required String host,
    required int port,
    required String user,
    required String password,
  }) async {
    try {
      final client = sb.Supabase.instance.client;
      await client.functions.invoke('save-smtp-config', body: {
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
      final client = sb.Supabase.instance.client;
      await client.functions.invoke('test-smtp-connection', body: {
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
      final client = sb.Supabase.instance.client;
      await client.functions.invoke('disconnect-integration', body: {
        'orgId': _orgId,
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<GoogleContact>> getGoogleContacts() async {
    try {
      final client = sb.Supabase.instance.client;
      final response = await client.functions.invoke('get-google-contacts', body: {
        'orgId': _orgId,
      });
      final dynamic responseData = response.data;
      final List data = responseData != null && responseData is Map ? (responseData['contacts'] ?? []) : [];
      return data
          .map((item) => GoogleContact.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> syncAllAppointments() async {
    try {
      final client = sb.Supabase.instance.client;
      final response = await client.functions.invoke('sync-all-appointments', body: {
        'orgId': _orgId,
      });
      final dynamic responseData = response.data;
      if (responseData is Map) {
        return Map<String, dynamic>.from(responseData);
      }
      return {};
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
