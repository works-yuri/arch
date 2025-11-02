enum HttpExceptionType {
  timeout,
  certificate,
  cancel,
  connection,
  response,
  unknown,
}

final class HttpException implements Exception {
  final HttpExceptionType type;

  HttpException({this.type = HttpExceptionType.unknown});

  factory HttpException.unknown() {
    return HttpException(type: HttpExceptionType.unknown);
  }

  factory HttpException.timeout() {
    return HttpException(type: HttpExceptionType.timeout);
  }

  factory HttpException.certificate() {
    return HttpException(type: HttpExceptionType.certificate);
  }

  factory HttpException.cancel() {
    return HttpException(type: HttpExceptionType.cancel);
  }

  factory HttpException.connection() {
    return HttpException(type: HttpExceptionType.connection);
  }

  factory HttpException.response({
    int? status = 500,
    String? message,
    dynamic data,
    required Map<String, List<String>> headers,
  }) {
    return HttpResponseException(
      status: status ?? 500,
      message: message ?? 'Server Error',
      headers: headers,
      data: data,
    );
  }

  W when<W>({
    W Function()? timeout,
    W Function()? certificate,
    W Function()? cancel,
    W Function()? connection,
    W Function()? response,
    required W Function() unknown,
  }) {
    final handler = switch (type) {
      HttpExceptionType.timeout => timeout,
      HttpExceptionType.certificate => certificate,
      HttpExceptionType.cancel => cancel,
      HttpExceptionType.connection => connection,
      HttpExceptionType.response => response,
      HttpExceptionType.unknown => unknown,
    };
    return (handler ?? unknown).call();
  }
}

final class HttpResponseException extends HttpException {
  final int status;
  final String message;

  final HttpExceptionType type = HttpExceptionType.response;

  Map<String, List<String>> headers;
  dynamic data;

  HttpResponseException({
    required this.status,
    required this.message,
    required this.headers,
    this.data,
  });
}
