abstract interface class SharedAnalytics {
  Future<void> send(String event, {Map<String, Object?>? parameters});
}
