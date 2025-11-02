import 'data.dart';
import 'method.dart';

class HttpOptions {
  final String path;
  final HttpMethod method;
  final Map<String, dynamic>? queries;
  final Map<String, dynamic>? headers;
  final HttpData? data;
  final void Function(int progress, int total)? onReceive;
  final void Function(int progress, int total)? onSend;

  HttpOptions({
    required this.path,
    required this.method,
    this.queries,
    this.headers,
    this.data,
    this.onReceive,
    this.onSend,
  });
}
