// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;
import 'package:supabase_flutter/supabase_flutter.dart';

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
      await Supabase.instance.client.auth.signOut();
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
    await Supabase.instance.client.auth.signOut();
  } catch (_) {}
  html.window.localStorage.clear();
  html.window.location.reload();
}
