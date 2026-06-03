import 'dart:html' as html;
import 'package:firebase_auth/firebase_auth.dart';

Future<void> checkAppVersion(String appVersion) async {
  final storedVersion = html.window.localStorage['app_version'];
  
  if (storedVersion == null) {
    html.window.localStorage['app_version'] = appVersion;
    return;
  }

  if (storedVersion != appVersion) {
    // Set version first before reload to prevent infinite startup loops
    html.window.localStorage['app_version'] = appVersion;

    try {
      await FirebaseAuth.instance.signOut();
    } catch (_) {}

    // Safely remove the version flag from storage before clearing, then write it back
    // We clear to ensure old cached data is purged, but we preserve the new app version
    html.window.localStorage.clear();
    html.window.localStorage['app_version'] = appVersion;

    html.window.location.reload();
  }
}

Future<void> resetApp() async {
  try {
    await FirebaseAuth.instance.signOut();
  } catch (_) {}
  html.window.localStorage.clear();
  html.window.location.reload();
}
