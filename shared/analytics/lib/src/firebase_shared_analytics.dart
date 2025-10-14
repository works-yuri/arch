import 'shared_analytics.dart';

class FirebaseSharedAnalytics implements SharedAnalytics {
  @override
  Future<void> send(String event, {Map<String, Object?>? parameters}) async {
    print('FirebaseAnalyticsImplemented $event');
  }
}
