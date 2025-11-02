import 'dart:io' show HttpHeaders;
import 'package:dio/dio.dart';
import '/src/client/session.dart';
import '/src/common/common.dart';

class BearerTokenInterceptor extends InterceptorsWrapper {
  final String prefix;

  final HttpSession<TokenState> session;

  BearerTokenInterceptor({required this.session, this.prefix = 'Bearer'});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await session.read();

    if (token != null) {
      options.headers[HttpHeaders.authorizationHeader] =
          '$prefix ${token.access}';
    }

    handler.next(options);
  }
}
