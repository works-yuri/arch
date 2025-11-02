class HttpResponse {
  final int status;
  final Map<String, List<String>> headers;
  final Map<String, dynamic> data;

  HttpResponse({
    required this.status,
    required this.headers,
    required this.data,
  });
}
