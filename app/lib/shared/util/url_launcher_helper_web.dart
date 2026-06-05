import 'dart:html' as html;

void openUrl(String url) {
  html.window.location.href = url;
}

String getCurrentUrl() {
  // Strip code/state query params if present to prevent redirect loops
  final uri = Uri.parse(html.window.location.href);
  final cleanedUri = uri.replace(queryParameters: {});
  return cleanedUri.toString();
}
