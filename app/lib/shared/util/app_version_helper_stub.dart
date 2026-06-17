import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> checkAppVersion(String appVersion) async {
  // No-op on mobile/stub
}

Future<void> resetApp() async {
  try {
    await Supabase.instance.client.auth.signOut();
  } catch (_) {}
}
