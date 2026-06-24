import 'package:freezed_annotation/freezed_annotation.dart';

part 'kitchen_timer_model.freezed.dart';

@freezed
class KitchenTimer with _$KitchenTimer {
  const factory KitchenTimer({
    required String id,
    required String label,
    required int durationSeconds,
    required int remainingSeconds,
    required bool isRunning,
    DateTime? startedAt,
    DateTime? completedAt,
  }) = _KitchenTimer;
}
