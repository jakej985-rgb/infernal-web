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

void openMailto({required String to, required String subject, required String body}) {
  final uri = Uri(
    scheme: 'mailto',
    path: to,
    queryParameters: {
      'subject': subject,
      'body': body,
    },
  );
  html.window.open(uri.toString(), '_self');
}
