import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'org_provider.dart';

final orgLabelsProvider = StreamProvider<Map<String, String>>((ref) {
  final orgId = ref.watch(orgIdProvider);
  final client = sb.Supabase.instance.client;

  return client
      .from('organizations')
      .stream(primaryKey: ['id'])
      .eq('id', orgId)
      .map((data) {
        if (data.isEmpty) return {};
        final row = data.first;
        final labelsObj = row['labels'];
        if (labelsObj == null || labelsObj is! Map) return {};
        return (labelsObj).map(
          (key, value) => MapEntry(key.toString(), value.toString()),
        );
      });
});
