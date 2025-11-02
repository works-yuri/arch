import '/src/client/session.dart';
import '/src/common/common.dart';
import '/src/responses/singIn.dart';
import '/src/client/credentials.dart';
import '/src/client/client.dart';

class RefreshToken extends ClientRequest<SingInResponse> {
  final String token;

  RefreshToken({required this.token});

  @override
  HttpOptions onRequest(SharedApiCredentials credentials) {
    return HttpOptions(
      path: '/o/token',
      method: HttpMethod.POST,
      data: HttpData.multipart({
        'client_id': credentials.clientID,
        'grant_type': 'refresh_token',
        'refresh_token': token,
      }),
    );
  }

  SingInResponse onResponse(HttpResponse response) {
    return SingInResponse.fromMap(response.data);
  }

  TokenState onSession(response) {
    return TokenState(
      access: response.accessToken,
      refresh: response.refreshToken,
      expiresIn: response.expiresIn,
    );
  }
}
