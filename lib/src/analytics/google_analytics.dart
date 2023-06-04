import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final googleAnalyticsProvider = Provider<GoogleAnalytics>((ref) {
  return GoogleAnalytics();
});

class GoogleAnalytics {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  /// This function is to send events to firebase
  void sendEvent(String eventName, {Map<String, dynamic>? params}) async {
    await analytics.logEvent(name: eventName, parameters: params);
  }
}
