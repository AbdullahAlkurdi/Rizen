import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/sleep_log_repository.dart';
import '../../data/services/sleep_detector_service.dart';
import 'sleep_state.dart';

class SleepCubit extends Cubit<SleepState> {
  SleepCubit({
    required this.repository,
    required this.sleepDetectorService,
  }) : super(const SleepInitial());

  final SleepLogRepository repository;
  final SleepDetectorService sleepDetectorService;

  Future<void> startSleepTracking() async {
    final granted = await sleepDetectorService.requestPermissions();
    if (!granted) {
      emit(const SleepError('Sensor permission denied'));
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
      emit(const SleepDetected('Bedtime logged'));
    } catch (e) {
      emit(SleepError(e.toString()));
    }
  }

  Future<void> logManualWakeTime(DateTime time) async {
    emit(const SleepLoading());
    try {
      await repository.logWakeTime(time);
      final log = await repository.getLastSleepLog();
      if (log != null) {
        final hours = log.sleepEnd.difference(log.sleepStart).inMinutes / 60.0;
        emit(SleepLogged(log));
        emit(SleepDetected('Good morning! You slept ${hours.toStringAsFixed(1)} hours'));
      }
    } catch (e) {
      emit(SleepError(e.toString()));
    }
  }

  Future<void> getLastSleep() async {
    emit(const SleepLoading());
    try {
      final log = await repository.getLastSleepLog();
      if (log != null) {
        emit(SleepLogged(log));
      }
    } catch (e) {
      emit(SleepError(e.toString()));
    }
  }

  @override
  Future<void> close() async {
    await sleepDetectorService.stopTracking();
    return super.close();
  }
}
