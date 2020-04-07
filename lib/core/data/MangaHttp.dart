import 'dart:io';

class MangaHttpOverrides extends HttpOverrides {

  @override
  HttpClient createHttpClient(SecurityContext securityContext) {
    final HttpClient client = super.createHttpClient(securityContext);
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return client;
  }

}
