class HttpCredentials {
  final String host;
  final String path;
  final String scheme;
  final int port;

  String get url {
    return '${scheme}://${host}:${port}${path.startsWith('/') ? path.substring(1) : path}';
  }

  bool get isSecure {
    return scheme == 'https';
  }

  HttpCredentials({
    this.path = '',
    this.port = 443,
    required this.host,
    this.scheme = 'https',
  });
}
