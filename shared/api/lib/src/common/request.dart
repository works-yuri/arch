import 'credentials.dart';
import 'options.dart';
import 'response.dart';
import 'session.dart';

abstract class HttpRequest<
  State extends HttpState,
  Credentials extends HttpCredentials,
  Response
> {
  HttpOptions onRequest(Credentials credentials);

  Response onResponse(HttpResponse response);

  State? onSession(Response response) => null;

  Exception onException(Exception exception) => exception;
}
