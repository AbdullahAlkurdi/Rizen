import 'package:freezed_annotation/freezed_annotation.dart';

part 'shadow_habit_model.freezed.dart';
part 'shadow_habit_model.g.dart';

enum ShadowFrequency { daily, weekly }

@freezed
class ShadowHabit with _$ShadowHabit {
  const factory ShadowHabit({
    required String id,
    required String name,
    required String category,
    @Default(0) int timeWasted,
    required ShadowFrequency frequency,
    required DateTime loggedAt,
  }) = _ShadowHabit;

  factory ShadowHabit.fromJson(Map<String, dynamic> json) =>
      _$ShadowHabitFromJson(json);
}
