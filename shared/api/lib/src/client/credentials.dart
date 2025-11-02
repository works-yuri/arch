import '/src/common/common.dart';

class SharedApiCredentials extends HttpCredentials {
  final String clientID;
  final String clientSecret;

  SharedApiCredentials({
    super.path,
    super.port,
    super.scheme,
    required super.host,
    required this.clientID,
    required this.clientSecret,
  });
}
