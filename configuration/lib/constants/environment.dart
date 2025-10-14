class Environment {
  Environment._();

  static String get api {
    return const String.fromEnvironment('api', defaultValue: '');
  }
}
