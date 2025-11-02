import 'session.dart';
import 'request.dart';
import 'credentials.dart';

abstract class HttpClient<
  State extends HttpState,
  Credentials extends HttpCredentials
> {
  HttpSession<State> get session;
  Credentials get credentials;

  Future<T> execute<T>(HttpRequest<State, Credentials, T> options);
}
