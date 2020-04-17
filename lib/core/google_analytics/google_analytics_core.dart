import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class GoogleAnalytics {
  static FirebaseAnalytics analytics = FirebaseAnalytics();

  /**
   * dùng để track route link
   */
  static trackRoute() {
    return FirebaseAnalyticsObserver(analytics: analytics);
  }

  /**
   * dùng để track sreen theo tên tự đặt
   */
  static void trackScreen(name) async {
    analytics.setCurrentScreen(
        screenName: name, screenClassOverride: 'eduzaa');
  }
}
