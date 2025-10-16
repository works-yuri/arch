// abstract interface class SignInService {}
abstract interface class SignInService {
  Future<void> send(String username, String password);
}

class SignInServiceImpl implements SignInService {
  @override
  Future<void> send(String username, String password) async {}
}
