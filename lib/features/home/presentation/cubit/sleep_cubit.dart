import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/sleep_log_repository.dart';
import '../../data/services/sleep_detector_service.dart';
import '../../data/services/sleep_tracking_service.dart';
import 'sleep_state.dart';

class SleepCubit extends Cubit<SleepState> {
  SleepCubit({
    required this.repository,
    required this.sleepDetectorService,
    required this.sleepTrackingService,
  }) : super(const SleepInitial());

  final SleepLogRepository repository;
  final SleepDetectorService sleepDetectorService;
  final SleepTrackingService sleepTrackingService;

  Future<void> loadTodaySleepData({VoidCallback? onRetry}) async {
    emit(const SleepLoading());
    try {
      final todayLog = await repository.getTodaySleepLog();
      final targetWakeTime = await sleepTrackingService.getTargetWakeTime();

      if (todayLog != null && targetWakeTime != null) {
        final computed = await sleepTrackingService.computeBedResistance(
          wakeTimestamp: todayLog.sleepEnd,
          targetWakeTime: targetWakeTime,
        );
        if (computed != null) {
          emit(SleepLoaded(
            todayLog: computed,
            history: await sleepTrackingService.getSleepHistory(7),
            averageBedResistance: await sleepTrackingService.getAverageBedResistance(7),
          ));
          return;
        }
      }

      final history = await sleepTrackingService.getSleepHistory(7);
      final average = await sleepTrackingService.getAverageBedResistance(7);

      emit(SleepLoaded(
        todayLog: todayLog,
        history: history,
        averageBedResistance: average,
      ));
    } catch (e) {
      emit(SleepError(e.toString(), onRetry ?? () {}));
    }
  }

  Future<void> refresh() async {
    await loadTodaySleepData(onRetry: () => refresh());
  }

  Future<void> startSleepTracking() async {
    final granted = await sleepDetectorService.requestPermissions();
    if (!granted) {
      emit(SleepError('Sensor permission denied', () {}));
      return;
    }
    sleepDetectorService.startTracking();
  }

  Future<void> stopSleepTracking() async {
    await sleepDetectorService.stopTracking();
  }

  Future<void> logManualBedtime(DateTime time) async {
    emit(const SleepLoading());
    try {
      await repository.logBedtime(time);
      final log = await repository.getLastSleepLog();
      if (log != null) {
        emit(SleepLogged(log));
      }
    } catch (e) {
      emit(SleepError(e.toString(), () => logManualBedtime(time)));
    }
  }

  Future<void> logManualWakeTime(DateTime time) async {
    emit(const SleepLoading());
    try {
      await repository.logWakeTime(time);
      final log = await repository.getLastSleepLog();
      if (log != null) {
        emit(SleepLogged(log));
      }
    } catch (e) {
      emit(SleepError(e.toString(), () => logManualWakeTime(time)));
    }
  }

  @override
  Future<void> close() async {
    await sleepDetectorService.stopTracking();
    return super.close();
  }
}
