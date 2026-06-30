import 'package:flutter/widgets.dart';
import '../../data/models/sleep_log_model.dart';

sealed class SleepState {
  const SleepState();
}

final class SleepInitial extends SleepState {
  const SleepInitial();
}

final class SleepLoading extends SleepState {
  const SleepLoading();
}

final class SleepLoaded extends SleepState {
  const SleepLoaded({
    required this.todayLog,
    required this.history,
    required this.averageBedResistance,
  });
  final SleepLog? todayLog;
  final List<SleepLog> history;
  final double averageBedResistance;
}

final class SleepLogged extends SleepState {
  const SleepLogged(this.log);
  final SleepLog log;
}

final class SleepError extends SleepState {
  const SleepError(this.message, this.onRetry);
  final String message;
  final VoidCallback onRetry;
}
