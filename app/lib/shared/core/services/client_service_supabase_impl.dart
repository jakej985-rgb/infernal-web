import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart' as uuid;

import '../../cache/id_mapper.dart';
import '../../domain/client.dart' as domain;
import '../../data/interfaces/client_service.dart';
import '../../data/org_provider.dart';

class ClientServiceSupabaseImpl implements ClientService {
  final Ref _ref;
  ClientServiceSupabaseImpl(this._ref);

  IdMapper get _idMapper => _ref.read(idMapperProvider);
  String get _orgId => _ref.read(orgIdProvider);

  @override
  Future<List<domain.Client>> getClients() async {
    try {
      final client = sb.Supabase.instance.client;
      final response = await client
          .from('clients')
          .select()
          .eq('org_id', _orgId)
          .eq('is_deleted', false);
      
      final clients = <domain.Client>[];
      for (final row in response) {
        clients.add(await _mapRowToDomain(row));
      }
      return clients;
    } catch (e) {
      throw Exception('Failed to get clients: $e');
    }
  }

  @override
  Future<domain.Client?> getClientById(int id) async {
    try {
      final uuidVal = _idMapper.getUuid('client', id);
      if (uuidVal == null) return null;

      final client = sb.Supabase.instance.client;
      final row = await client
          .from('clients')
          .select()
          .eq('id', uuidVal)
          .maybeSingle();
      if (row == null) return null;
      return await _mapRowToDomain(row);
    } catch (e) {
      throw Exception('Failed to get client: $e');
    }
  }

  @override
  Future<void> createClient(domain.Client client) async {
    try {
      final uuidVal = const uuid.Uuid().v4();
      final supabaseClient = sb.Supabase.instance.client;

      await supabaseClient.from('clients').insert({
        'id': uuidVal,
        'org_id': _orgId,
        'first_name': client.firstName,
        'middle_name': client.middleName,
        'last_name': client.lastName,
        'email': client.email,
        'phone': client.phone,
        'notes': client.notes,
        'photo_path': client.photoPath,
        'is_deleted': false,
        'created_at': DateTime.now().toUtc().toIso8601String(),
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      });

      await _idMapper.registerUuid('client', uuidVal);
    } catch (e) {
      throw Exception('Failed to create client: $e');
    }
  }

  @override
  Future<void> updateClient(domain.Client client) async {
    try {
      final uuidVal = _idMapper.getUuid('client', client.id);
      if (uuidVal == null) throw Exception('Cannot resolve ID for client.');

      final supabaseClient = sb.Supabase.instance.client;
      await supabaseClient.from('clients').update({
        'first_name': client.firstName,
        'middle_name': client.middleName,
        'last_name': client.lastName,
        'email': client.email,
        'phone': client.phone,
        'notes': client.notes,
        'photo_path': client.photoPath,
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      }).eq('id', uuidVal);
    } catch (e) {
      throw Exception('Failed to update client: $e');
    }
  }

  @override
  Future<void> deleteClient(int id) async {
    try {
      final uuidVal = _idMapper.getUuid('client', id);
      if (uuidVal == null) throw Exception('Cannot resolve ID for client.');

      final supabaseClient = sb.Supabase.instance.client;
      await supabaseClient.from('clients').update({
        'is_deleted': true,
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      }).eq('id', uuidVal);
    } catch (e) {
      throw Exception('Failed to delete client: $e');
    }
  }

  @override
  Stream<List<domain.Client>> watchClients() {
    final client = sb.Supabase.instance.client;
    return client
        .from('clients')
        .stream(primaryKey: ['id'])
        .eq('org_id', _orgId)
        .asyncMap((data) async {
          final clients = <domain.Client>[];
          for (final row in data) {
            if (row['is_deleted'] == true) continue;
            clients.add(await _mapRowToDomain(row));
          }
          return clients;
        });
  }

  @override
  Stream<domain.Client?> watchClientById(int id) {
    final uuidVal = _idMapper.getUuid('client', id);
    if (uuidVal == null) {
      return Stream.value(null);
    }
    final client = sb.Supabase.instance.client;
    return client
        .from('clients')
        .stream(primaryKey: ['id'])
        .eq('id', uuidVal)
        .asyncMap((data) async {
          if (data.isEmpty || data.first['is_deleted'] == true) return null;
          return await _mapRowToDomain(data.first);
        });
  }

  @override
  Future<String> saveAvatar(XFile file) async {
    return file.path;
  }

  Future<domain.Client> _mapRowToDomain(
    Map<String, dynamic> row,
  ) async {
    final uuidVal = row['id'] as String;
    final id = await _idMapper.registerUuid('client', uuidVal);

    final firstName = row['first_name'] as String? ?? '';
    final middleName = row['middle_name'] as String? ?? '';
    final lastName = row['last_name'] as String? ?? '';
    final email = row['email'] as String? ?? '';
    final phone = row['phone'] as String? ?? '';
    final notes = row['notes'] as String? ?? '';
    final photoPath = row['photo_path'] as String? ?? '';

    final createdAt = DateTime.parse(row['created_at'] as String);
    final updatedAt = DateTime.parse(row['updated_at'] as String);

    return domain.Client(
      id: id,
      syncId: uuidVal,
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      email: email,
      phone: phone,
      notes: notes,
      photoPath: photoPath,
      createdAt: createdAt.toUtc(),
      lastModifiedUtc: updatedAt.toUtc(),
    );
  }
}
