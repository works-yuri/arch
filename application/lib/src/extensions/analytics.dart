import 'package:shared_analytics/shared_analytics.dart';

extension AnalyticsServiceExtensions on SharedAnalytics {
  Future<void> logLogin() async {
    await send('logLogin');
  }
}
