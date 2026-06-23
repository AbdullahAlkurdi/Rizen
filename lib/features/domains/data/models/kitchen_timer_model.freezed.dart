// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kitchen_timer_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$KitchenTimer {
  String get id => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  int get durationSeconds => throw _privateConstructorUsedError;
  int get remainingSeconds => throw _privateConstructorUsedError;
  bool get isRunning => throw _privateConstructorUsedError;
  DateTime? get startedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// Create a copy of KitchenTimer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KitchenTimerCopyWith<KitchenTimer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KitchenTimerCopyWith<$Res> {
  factory $KitchenTimerCopyWith(
    KitchenTimer value,
    $Res Function(KitchenTimer) then,
  ) = _$KitchenTimerCopyWithImpl<$Res, KitchenTimer>;
  @useResult
  $Res call({
    String id,
    String label,
    int durationSeconds,
    int remainingSeconds,
    bool isRunning,
    DateTime? startedAt,
    DateTime? completedAt,
  });
}

/// @nodoc
class _$KitchenTimerCopyWithImpl<$Res, $Val extends KitchenTimer>
    implements $KitchenTimerCopyWith<$Res> {
  _$KitchenTimerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KitchenTimer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? durationSeconds = null,
    Object? remainingSeconds = null,
    Object? isRunning = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
            durationSeconds: null == durationSeconds
                ? _value.durationSeconds
                : durationSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
            remainingSeconds: null == remainingSeconds
                ? _value.remainingSeconds
                : remainingSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
            isRunning: null == isRunning
                ? _value.isRunning
                : isRunning // ignore: cast_nullable_to_non_nullable
                      as bool,
            startedAt: freezed == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$KitchenTimerImplCopyWith<$Res>
    implements $KitchenTimerCopyWith<$Res> {
  factory _$$KitchenTimerImplCopyWith(
    _$KitchenTimerImpl value,
    $Res Function(_$KitchenTimerImpl) then,
  ) = __$$KitchenTimerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String label,
    int durationSeconds,
    int remainingSeconds,
    bool isRunning,
    DateTime? startedAt,
    DateTime? completedAt,
  });
}

/// @nodoc
class __$$KitchenTimerImplCopyWithImpl<$Res>
    extends _$KitchenTimerCopyWithImpl<$Res, _$KitchenTimerImpl>
    implements _$$KitchenTimerImplCopyWith<$Res> {
  __$$KitchenTimerImplCopyWithImpl(
    _$KitchenTimerImpl _value,
    $Res Function(_$KitchenTimerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of KitchenTimer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? durationSeconds = null,
    Object? remainingSeconds = null,
    Object? isRunning = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(
      _$KitchenTimerImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
        durationSeconds: null == durationSeconds
            ? _value.durationSeconds
            : durationSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        remainingSeconds: null == remainingSeconds
            ? _value.remainingSeconds
            : remainingSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        isRunning: null == isRunning
            ? _value.isRunning
            : isRunning // ignore: cast_nullable_to_non_nullable
                  as bool,
        startedAt: freezed == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$KitchenTimerImpl implements _KitchenTimer {
  const _$KitchenTimerImpl({
    required this.id,
    required this.label,
    required this.durationSeconds,
    required this.remainingSeconds,
    required this.isRunning,
    this.startedAt,
    this.completedAt,
  });

  @override
  final String id;
  @override
  final String label;
  @override
  final int durationSeconds;
  @override
  final int remainingSeconds;
  @override
  final bool isRunning;
  @override
  final DateTime? startedAt;
  @override
  final DateTime? completedAt;

  @override
  String toString() {
    return 'KitchenTimer(id: $id, label: $label, durationSeconds: $durationSeconds, remainingSeconds: $remainingSeconds, isRunning: $isRunning, startedAt: $startedAt, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KitchenTimerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.remainingSeconds, remainingSeconds) ||
                other.remainingSeconds == remainingSeconds) &&
            (identical(other.isRunning, isRunning) ||
                other.isRunning == isRunning) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    label,
    durationSeconds,
    remainingSeconds,
    isRunning,
    startedAt,
    completedAt,
  );

  /// Create a copy of KitchenTimer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KitchenTimerImplCopyWith<_$KitchenTimerImpl> get copyWith =>
      __$$KitchenTimerImplCopyWithImpl<_$KitchenTimerImpl>(this, _$identity);
}

abstract class _KitchenTimer implements KitchenTimer {
  const factory _KitchenTimer({
    required final String id,
    required final String label,
    required final int durationSeconds,
    required final int remainingSeconds,
    required final bool isRunning,
    final DateTime? startedAt,
    final DateTime? completedAt,
  }) = _$KitchenTimerImpl;

  @override
  String get id;
  @override
  String get label;
  @override
  int get durationSeconds;
  @override
  int get remainingSeconds;
  @override
  bool get isRunning;
  @override
  DateTime? get startedAt;
  @override
  DateTime? get completedAt;

  /// Create a copy of KitchenTimer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KitchenTimerImplCopyWith<_$KitchenTimerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
