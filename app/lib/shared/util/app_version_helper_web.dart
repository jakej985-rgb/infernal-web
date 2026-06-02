yimport 'dart:html' as html;
import 'package:firebase_auth/firebase_auth.dart';

Future<void> checkAppVersion(String appVersion) async {
  final storedVersion = html.window.localStorage['app_version'];
  if (storedVersion != appVersion) {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (_) {}
    html.window.localStorage.clear();
    html.window.location.reload();
  }
  html.window.localStorage['app_version'] = appVersion;
}

Future<void> resetApp() async {
  try {
    await FirebaseAuth.instance.signOut();
  } catch (_) {}
  html.window.localStorage.clear();
  html.window.location.reload();
}
