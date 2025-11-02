import 'package:dio/dio.dart';
import 'dart:io' show HttpHeaders, HttpStatus;
import '/src/client/session.dart';
import '/src/common/common.dart';
import '/src/requests/requests.dart';
import '/src/responses/responses.dart';

class InvalidRefreshTokenException extends DioException {
  InvalidRefreshTokenException({required super.requestOptions});
}

class RefreshTokenInterceptor extends InterceptorsWrapper {
  final Dio dio;

  final HttpSession<TokenState> session;

  final HttpClient client;

  RefreshTokenInterceptor({
    required this.dio,
    required this.session,
    required this.client,
  });

  @override
  Future<void> onError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    if (!(_isUnauthorizedError(error) &&
        _isRequestSecured(error.requestOptions))) {
      return handler.next(error);
    }
    try {
      final token = await session.read();

      if (token == null) {
        return handler.next(error);
      }

      final request = RefreshToken(token: token.refresh);

      await client.execute<SingInResponse>(request);

      Response<dynamic> result = await retry(error.requestOptions);

      return handler.resolve(result);
    } catch (ignore) {
      return handler.next(
        InvalidRefreshTokenException(requestOptions: error.requestOptions),
      );
    }
  }

  bool _isUnauthorizedError(DioException error) =>
      error.response?.statusCode == HttpStatus.unauthorized ||
      error.response?.statusCode == HttpStatus.forbidden;

  bool _isRequestSecured(RequestOptions options) =>
      options.headers.containsKey(HttpHeaders.authorizationHeader);

  Future<Response<dynamic>> retry(RequestOptions options) async {
    final request = Options(method: options.method, headers: options.headers)
        .compose(
          dio.options,
          options.path,
          data: options.data,
          queryParameters: options.queryParameters,
          cancelToken: options.cancelToken,
          onReceiveProgress: options.onReceiveProgress,
          onSendProgress: options.onSendProgress,
        );
    return dio.fetch<dynamic>(request);
  }
}
