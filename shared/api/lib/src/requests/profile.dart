import '/src/client/client.dart';
import '/src/client/credentials.dart';
import '/src/common/common.dart';
import '/src/responses/profile.dart';

class ReadProfile extends ClientRequest<ProfileResponse> {
  @override
  HttpOptions onRequest(SharedApiCredentials credential) {
    return HttpOptions.get('/v2/profile');
  }

  ProfileResponse onResponse(HttpResponse response) {
    return ProfileResponse.fromMap(response.data);
  }
}
