import 'dart:async';
import 'dart:math';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import '../repositories/sleep_log_repository.dart';

class SleepDetectorService {
  SleepDetectorService(this.repository);

  final SleepLogRepository repository;
  StreamSubscription<AccelerometerEvent>? _accelerometerSub;
  bool _isTracking = false;
  DateTime? _lastMoveTime;
  bool _hasTriggeredToday = false;

  Future<bool> requestPermissions() async {
    final status = await Permission.sensors.request();
    return status.isGranted;
  }

  void startTracking() {
    if (_isTracking) return;
    _isTracking = true;

    _accelerometerSub = accelerometerEventStream().listen((AccelerometerEvent event) {
      final magnitude = sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
      if (magnitude > 1.5) {
        _lastMoveTime = DateTime.now();
      }
    });
  }

  void onAppResumed() {
    final now = DateTime.now();
    if (_hasTriggeredToday) return;

    if (_lastMoveTime != null && now.difference(_lastMoveTime!).inMinutes < 5) {
      _triggerWakeEvent();
      _hasTriggeredToday = true;
    }
  }

  Future<void> _triggerWakeEvent() async {
    try {
      await repository.logWakeTime(DateTime.now());
    } catch (_) {}
  }

  Future<void> stopTracking() async {
    _isTracking = false;
    await _accelerometerSub?.cancel();
    _accelerometerSub = null;
  }
}
