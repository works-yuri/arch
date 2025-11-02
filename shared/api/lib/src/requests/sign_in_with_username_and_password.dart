import '/src/client/session.dart';
import '/src/common/common.dart';
import '/src/responses/singIn.dart';
import '/src/client/credentials.dart';
import '/src/client/client.dart';

class SignInWithUsernameAndPassword extends ClientRequest<SingInResponse> {
  final String password;

  final String username;

  SignInWithUsernameAndPassword({
    required this.password,
    required this.username,
  });

  @override
  HttpOptions onRequest(SharedApiCredentials credentials) {
    return HttpOptions(
      path: '/o/token',
      method: HttpMethod.POST,
      data: HttpData.multipart({
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
