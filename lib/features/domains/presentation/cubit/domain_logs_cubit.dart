import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/domain_log_model.dart';
import '../../data/repositories/domain_logs_repository.dart';

sealed class DomainLogsState {}

final class DomainLogsInitial extends DomainLogsState {}

final class DomainLogsLoading extends DomainLogsState {}

final class DomainLogsLoaded extends DomainLogsState {
  final List<DomainLog> logs;
  final ({double weeklyHours, int streak, double progress}) summary;
  DomainLogsLoaded({required this.logs, required this.summary});
}

final class DomainLogsError extends DomainLogsState {
  final String message;
  DomainLogsError(this.message);
}

class DomainLogsCubit extends Cubit<DomainLogsState> {
  final DomainLogsRepository _repository;

  DomainLogsCubit({DomainLogsRepository? repository})
    : _repository = repository ?? DomainLogsRepository(),
      super(DomainLogsInitial());

  Future<void> loadLogs(String domainId) async {
    emit(DomainLogsLoading());
    try {
      final logs = await _repository.getLogsByDomain(domainId);
      final summary = _computeSummary(logs);
      emit(DomainLogsLoaded(logs: logs, summary: summary));
    } catch (e) {
      emit(DomainLogsError(e.toString()));
    }
  }

  Future<void> addLog({
    required String domainId,
    required int duration,
    String? notes,
    String? metricLabel,
    double? metricValue,
  }) async {
    emit(DomainLogsLoading());
    try {
      await _repository.addLog(
        domainId: domainId,
        duration: duration,
        notes: notes,
        metricLabel: metricLabel,
        metricValue: metricValue,
      );
      await loadLogs(domainId);
    } catch (e) {
      emit(DomainLogsError(e.toString()));
    }
  }

  Future<void> updateLog(DomainLog log) async {
    emit(DomainLogsLoading());
    try {
      await _repository.updateLog(log);
      await loadLogs(log.domainId);
    } catch (e) {
      emit(DomainLogsError(e.toString()));
    }
  }

  Future<void> deleteLog(String logId, String domainId) async {
    emit(DomainLogsLoading());
    try {
      await _repository.deleteLog(logId);
      await loadLogs(domainId);
    } catch (e) {
      emit(DomainLogsError(e.toString()));
    }
  }

  ({double weeklyHours, int streak, double progress}) _computeSummary(
    List<DomainLog> logs,
  ) {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday));

    final weekLogs = logs
        .where((log) => log.loggedAt.isAfter(weekStart))
        .toList();
    final weeklyHours = weekLogs.fold<double>(
      0,
      (sum, log) => sum + log.duration / 60,
    );

    int streak = 0;
    var checkDate = DateTime(now.year, now.month, now.day);
    while (true) {
      final hasLog = logs.any(
        (log) =>
            log.loggedAt.year == checkDate.year &&
            log.loggedAt.month == checkDate.month &&
            log.loggedAt.day == checkDate.day,
      );
      if (!hasLog) break;
      streak++;
      checkDate = checkDate.subtract(const Duration(days: 1));
    }

    final progress = weeklyHours >= 10 ? 1.0 : weeklyHours / 10;

    return (weeklyHours: weeklyHours, streak: streak, progress: progress);
  }
}
