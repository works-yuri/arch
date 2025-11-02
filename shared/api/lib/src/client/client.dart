import 'package:dio/dio.dart';
import '/src/common/common.dart';
import 'credentials.dart';
import 'interceptors/interceptors.dart';
import 'session.dart';

typedef ClientRequest<T> = HttpRequest<TokenState, SharedApiCredentials, T>;

class SharedApiClient implements HttpClient<TokenState, SharedApiCredentials> {
  final Dio _dio;
  @override
  final HttpSession<TokenState> session;

  @override
  final SharedApiCredentials credentials;

  SharedApiClient({
    Dio? dio,
    required this.session,
    required this.credentials,
    Duration? connectTimeout = const Duration(seconds: 30),
    Duration? sendTimeout = const Duration(seconds: 30),
    Duration? receiveTimeout = const Duration(seconds: 30),
  }) : _dio = dio ?? Dio() {
    _dio.options.baseUrl = credentials.url;
    _dio.options.connectTimeout = connectTimeout;
    _dio.options.sendTimeout = sendTimeout;
    _dio.options.receiveTimeout = receiveTimeout;
    _dio.interceptors.addAll([
      BearerTokenInterceptor(session: session),
      RefreshTokenInterceptor(dio: _dio, session: session, client: this),
    ]);
  }

  @override
  Future<T> execute<T>(ClientRequest<T> request) async {
    try {
      final HttpOptions options = request.onRequest(credentials);

      final requestOptions =
          Options(
            method: options.method.toString(),
            headers: options.headers,
          ).compose(
            _dio.options,
            options.path,
            queryParameters: options.queries,
            data: options.data?.when<Object?>(
              multipart: (data) => FormData.fromMap(data),
              other: (data) => data,
            ),
            onReceiveProgress: options.onReceive,
            onSendProgress: options.onSend,
          );

      final response = await _dio.fetch<Map<String, dynamic>>(requestOptions);

      final result = request.onResponse(
        HttpResponse(
          data: response.data ?? {},
          headers: response.headers.map,
          status: response.statusCode ?? 200,
        ),
      );

      final state = request.onSession(result);
      if (state != null) {
        session.update(state);
      }

      return result;
    } on DioException catch (error) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw request.onException(HttpException.timeout());
        case DioExceptionType.cancel:
          throw request.onException(HttpException.cancel());
        case DioExceptionType.badCertificate:
          throw request.onException(HttpException.certificate());
        case DioExceptionType.connectionError:
          throw request.onException(HttpException.connection());
        case DioExceptionType.unknown:
          throw request.onException(HttpException.unknown());
        case DioExceptionType.badResponse:
          final response = error.response;
          if (response == null) {
            throw request.onException(HttpException.unknown());
          }
          throw request.onException(
            HttpException.response(
              status: response.statusCode,
              message: error.message,
              data: response.data,
              headers: response.headers.map,
            ),
          );
      }
    } catch (e) {
      throw HttpException.unknown();
    }
  }
}
