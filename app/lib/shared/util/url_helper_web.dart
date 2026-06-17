// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;

/// Web implementation of URL helper to handle hash routing redirects.
void handleHashRedirect() {
  final href = html.window.location.href;
  if (href.contains('/#/register/claim')) {
    final cleanHref = href.replaceAll('/#/register/claim', '/register/claim');
    html.window.location.replace(cleanHref);
  }
}
