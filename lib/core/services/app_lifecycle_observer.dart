import 'package:flutter/widgets.dart';

import '../../features/home/data/services/sleep_tracking_service.dart';

/// App lifecycle observer that detects the first app resume after midnight
/// as a proxy for "first unlock" event to record wake timestamp.
///
/// NOTE: This is a v1 proxy implementation. True OS-level "first unlock" detection
/// requires native platform code (Android UsageStatsManager / iOS Screen Time API)
/// which is restricted on iOS and requires special entitlements. Future work:
/// implement native platform channel for accurate unlock detection.
class AppLifecycleObserver extends WidgetsBindingObserver {
  AppLifecycleObserver({required this.sleepTrackingService});

  final SleepTrackingService sleepTrackingService;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      sleepTrackingService.recordWakeIfNeeded();
    }
  }
}