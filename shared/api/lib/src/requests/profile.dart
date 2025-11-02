import '/src/client/client.dart';
import '/src/client/credentials.dart';
import '/src/common/common.dart';
import '/src/responses/profile.dart';

class ReadProfile extends ClientRequest<ProfileResponse> {
  @override
  HttpOptions onRequest(SharedApiCredentials credential) {
    return HttpOptions(path: '/v2/profile', method: HttpMethod.GET);
  }

  ProfileResponse onResponse(HttpResponse response) {
    return ProfileResponse.fromMap(response.data);
  }
}
