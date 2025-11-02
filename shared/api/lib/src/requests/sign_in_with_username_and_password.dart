import '/src/client/session.dart';
import '/src/common/common.dart';
import '/src/responses/singIn.dart';
import '/src/client/credentials.dart';
import '/src/client/client.dart';

class SignInWithUsernameAndPassword extends ClientRequest<SingInResponse> {
  final String password;

  final String username;

  final String country;

  SignInWithUsernameAndPassword({
    required this.password,
    required this.username,
    required this.country,
  });

  @override
  HttpOptions onRequest(SharedApiCredentials credentials) {
    return HttpOptions.post(
      '/o/token',
      HttpData.multipart({
        'client_id': credentials.clientID,
        'device_id': 0,
        'grant_type': 'password',
        'username': username,
        'password': password,
      }),
    );
  }

  SingInResponse onResponse(HttpResponse response) {
    return SingInResponse.fromMap(response.data);
  }

  TokenState onSession(SingInResponse response) {
    return TokenState(
      access: response.accessToken,
      refresh: response.refreshToken,
      expiresIn: response.expiresIn,
    );
  }
}
