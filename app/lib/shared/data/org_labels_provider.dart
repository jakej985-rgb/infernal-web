import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'org_provider.dart';

final orgLabelsProvider = StreamProvider<Map<String, String>>((ref) {
  final orgId = ref.watch(orgIdProvider);

  return FirebaseFirestore.instance
      .collection('organizations')
      .doc(orgId)
      .snapshots()
      .map((doc) {
        final data = doc.data();
        if (data == null || data['labels'] == null) return {};
        // Ensure it's typed properly
        final labelsDynamic = data['labels'] as Map<dynamic, dynamic>;
        return labelsDynamic.map(
          (key, value) => MapEntry(key.toString(), value.toString()),
        );
      });
});
