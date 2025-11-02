abstract class HttpState {}

abstract class HttpSession<State extends HttpState> {
  Future<State?> read();
  Future<void> update(State token);
  Future<void> clear();
}

class HttpOnSession<State extends HttpState> implements HttpSession<State> {
  final Future<void> Function(State state) onUpdate;
  final Future<void> Function() onClear;
  final Future<State?> Function() onRead;

  HttpOnSession({
    required this.onRead,
    required this.onUpdate,
    required this.onClear,
  }) {}

  @override
  Future<void> clear() {
    return onClear();
  }

  @override
  Future<State?> read() {
    return onRead();
  }

  @override
  Future<void> update(State state) {
    return onUpdate(state);
  }
}
