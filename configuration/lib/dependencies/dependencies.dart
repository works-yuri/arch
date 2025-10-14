import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

abstract class LocatorProvider {
  Future<void> register(GetIt it);
}

class Dependencies {
  Future<void> wait() async {
    for (final provider in providers) {
      try {
        await provider.register(locator);
      } catch (err) {
        print(provider.runtimeType);
        print(err);
      }
    }

    await locator.allReady();
  }

  final List<LocatorProvider> providers = [];
}
