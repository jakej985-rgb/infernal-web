import 'package:firebase_auth/firebase_auth.dart';

Future<void> checkAppVersion(String appVersion) async {
  // No-op on mobile/stub
}

Future<void> resetApp() async {
  try {
    await FirebaseAuth.instance.signOut();
  } catch (_) {}
}
