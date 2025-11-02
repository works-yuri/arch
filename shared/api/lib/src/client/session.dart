import '/src/common/common.dart';

class TokenState extends HttpState {
  final String access;
  final String refresh;
  final int expiresIn;

  TokenState({
    required this.access,
    required this.refresh,
    required this.expiresIn,
  });
}
