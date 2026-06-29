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

final class SleepLogged extends SleepState {
  const SleepLogged(this.log);
  final SleepLog log;
}

final class SleepDetected extends SleepState {
  const SleepDetected(this.message);
  final String message;
}

final class SleepError extends SleepState {
  const SleepError(this.message);
  final String message;
}
