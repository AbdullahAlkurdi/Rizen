// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sleep_log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SleepLog _$SleepLogFromJson(Map<String, dynamic> json) {
  return _SleepLog.fromJson(json);
}

/// @nodoc
mixin _$SleepLog {
  String get id => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  DateTime get sleepStart => throw _privateConstructorUsedError;
  DateTime get sleepEnd => throw _privateConstructorUsedError;
  DateTime? get wakeTimeTarget => throw _privateConstructorUsedError;
  bool? get confirmed => throw _privateConstructorUsedError;
  DateTime? get confirmedAt => throw _privateConstructorUsedError;
  double? get bedResistanceMetric => throw _privateConstructorUsedError;
  LogSource get source => throw _privateConstructorUsedError;
  bool get isAnalysisReady => throw _privateConstructorUsedError;
  String? get analysisNotes => throw _privateConstructorUsedError;

  /// Serializes this SleepLog to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SleepLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SleepLogCopyWith<SleepLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SleepLogCopyWith<$Res> {
  factory $SleepLogCopyWith(SleepLog value, $Res Function(SleepLog) then) =
      _$SleepLogCopyWithImpl<$Res, SleepLog>;
  @useResult
  $Res call({
    String id,
    String uid,
    DateTime sleepStart,
    DateTime sleepEnd,
    DateTime? wakeTimeTarget,
    bool? confirmed,
    DateTime? confirmedAt,
    double? bedResistanceMetric,
    LogSource source,
    bool isAnalysisReady,
    String? analysisNotes,
  });
}

/// @nodoc
class _$SleepLogCopyWithImpl<$Res, $Val extends SleepLog>
    implements $SleepLogCopyWith<$Res> {
  _$SleepLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SleepLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? sleepStart = null,
    Object? sleepEnd = null,
    Object? wakeTimeTarget = freezed,
    Object? confirmed = freezed,
    Object? confirmedAt = freezed,
    Object? bedResistanceMetric = freezed,
    Object? source = null,
    Object? isAnalysisReady = null,
    Object? analysisNotes = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            uid: null == uid
                ? _value.uid
                : uid // ignore: cast_nullable_to_non_nullable
                      as String,
            sleepStart: null == sleepStart
                ? _value.sleepStart
                : sleepStart // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            sleepEnd: null == sleepEnd
                ? _value.sleepEnd
                : sleepEnd // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            wakeTimeTarget: freezed == wakeTimeTarget
                ? _value.wakeTimeTarget
                : wakeTimeTarget // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            confirmed: freezed == confirmed
                ? _value.confirmed
                : confirmed // ignore: cast_nullable_to_non_nullable
                      as bool?,
            confirmedAt: freezed == confirmedAt
                ? _value.confirmedAt
                : confirmedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            bedResistanceMetric: freezed == bedResistanceMetric
                ? _value.bedResistanceMetric
                : bedResistanceMetric // ignore: cast_nullable_to_non_nullable
                      as double?,
            source: null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as LogSource,
            isAnalysisReady: null == isAnalysisReady
                ? _value.isAnalysisReady
                : isAnalysisReady // ignore: cast_nullable_to_non_nullable
                      as bool,
            analysisNotes: freezed == analysisNotes
                ? _value.analysisNotes
                : analysisNotes // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SleepLogImplCopyWith<$Res>
    implements $SleepLogCopyWith<$Res> {
  factory _$$SleepLogImplCopyWith(
    _$SleepLogImpl value,
    $Res Function(_$SleepLogImpl) then,
  ) = __$$SleepLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String uid,
    DateTime sleepStart,
    DateTime sleepEnd,
    DateTime? wakeTimeTarget,
    bool? confirmed,
    DateTime? confirmedAt,
    double? bedResistanceMetric,
    LogSource source,
    bool isAnalysisReady,
    String? analysisNotes,
  });
}

/// @nodoc
class __$$SleepLogImplCopyWithImpl<$Res>
    extends _$SleepLogCopyWithImpl<$Res, _$SleepLogImpl>
    implements _$$SleepLogImplCopyWith<$Res> {
  __$$SleepLogImplCopyWithImpl(
    _$SleepLogImpl _value,
    $Res Function(_$SleepLogImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SleepLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? sleepStart = null,
    Object? sleepEnd = null,
    Object? wakeTimeTarget = freezed,
    Object? confirmed = freezed,
    Object? confirmedAt = freezed,
    Object? bedResistanceMetric = freezed,
    Object? source = null,
    Object? isAnalysisReady = null,
    Object? analysisNotes = freezed,
  }) {
    return _then(
      _$SleepLogImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        uid: null == uid
            ? _value.uid
            : uid // ignore: cast_nullable_to_non_nullable
                  as String,
        sleepStart: null == sleepStart
            ? _value.sleepStart
            : sleepStart // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        sleepEnd: null == sleepEnd
            ? _value.sleepEnd
            : sleepEnd // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        wakeTimeTarget: freezed == wakeTimeTarget
            ? _value.wakeTimeTarget
            : wakeTimeTarget // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        confirmed: freezed == confirmed
            ? _value.confirmed
            : confirmed // ignore: cast_nullable_to_non_nullable
                  as bool?,
        confirmedAt: freezed == confirmedAt
            ? _value.confirmedAt
            : confirmedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        bedResistanceMetric: freezed == bedResistanceMetric
            ? _value.bedResistanceMetric
            : bedResistanceMetric // ignore: cast_nullable_to_non_nullable
                  as double?,
        source: null == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as LogSource,
        isAnalysisReady: null == isAnalysisReady
            ? _value.isAnalysisReady
            : isAnalysisReady // ignore: cast_nullable_to_non_nullable
                  as bool,
        analysisNotes: freezed == analysisNotes
            ? _value.analysisNotes
            : analysisNotes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SleepLogImpl implements _SleepLog {
  const _$SleepLogImpl({
    required this.id,
    required this.uid,
    required this.sleepStart,
    required this.sleepEnd,
    this.wakeTimeTarget,
    this.confirmed,
    this.confirmedAt,
    this.bedResistanceMetric,
    this.source = LogSource.detected,
    this.isAnalysisReady = false,
    this.analysisNotes,
  });

  factory _$SleepLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$SleepLogImplFromJson(json);

  @override
  final String id;
  @override
  final String uid;
  @override
  final DateTime sleepStart;
  @override
  final DateTime sleepEnd;
  @override
  final DateTime? wakeTimeTarget;
  @override
  final bool? confirmed;
  @override
  final DateTime? confirmedAt;
  @override
  final double? bedResistanceMetric;
  @override
  @JsonKey()
  final LogSource source;
  @override
  @JsonKey()
  final bool isAnalysisReady;
  @override
  final String? analysisNotes;

  @override
  String toString() {
    return 'SleepLog(id: $id, uid: $uid, sleepStart: $sleepStart, sleepEnd: $sleepEnd, wakeTimeTarget: $wakeTimeTarget, confirmed: $confirmed, confirmedAt: $confirmedAt, bedResistanceMetric: $bedResistanceMetric, source: $source, isAnalysisReady: $isAnalysisReady, analysisNotes: $analysisNotes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SleepLogImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.sleepStart, sleepStart) ||
                other.sleepStart == sleepStart) &&
            (identical(other.sleepEnd, sleepEnd) ||
                other.sleepEnd == sleepEnd) &&
            (identical(other.wakeTimeTarget, wakeTimeTarget) ||
                other.wakeTimeTarget == wakeTimeTarget) &&
            (identical(other.confirmed, confirmed) ||
                other.confirmed == confirmed) &&
            (identical(other.confirmedAt, confirmedAt) ||
                other.confirmedAt == confirmedAt) &&
            (identical(other.bedResistanceMetric, bedResistanceMetric) ||
                other.bedResistanceMetric == bedResistanceMetric) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.isAnalysisReady, isAnalysisReady) ||
                other.isAnalysisReady == isAnalysisReady) &&
            (identical(other.analysisNotes, analysisNotes) ||
                other.analysisNotes == analysisNotes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    uid,
    sleepStart,
    sleepEnd,
    wakeTimeTarget,
    confirmed,
    confirmedAt,
    bedResistanceMetric,
    source,
    isAnalysisReady,
    analysisNotes,
  );

  /// Create a copy of SleepLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SleepLogImplCopyWith<_$SleepLogImpl> get copyWith =>
      __$$SleepLogImplCopyWithImpl<_$SleepLogImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SleepLogImplToJson(this);
  }
}

abstract class _SleepLog implements SleepLog {
  const factory _SleepLog({
    required final String id,
    required final String uid,
    required final DateTime sleepStart,
    required final DateTime sleepEnd,
    final DateTime? wakeTimeTarget,
    final bool? confirmed,
    final DateTime? confirmedAt,
    final double? bedResistanceMetric,
    final LogSource source,
    final bool isAnalysisReady,
    final String? analysisNotes,
  }) = _$SleepLogImpl;

  factory _SleepLog.fromJson(Map<String, dynamic> json) =
      _$SleepLogImpl.fromJson;

  @override
  String get id;
  @override
  String get uid;
  @override
  DateTime get sleepStart;
  @override
  DateTime get sleepEnd;
  @override
  DateTime? get wakeTimeTarget;
  @override
  bool? get confirmed;
  @override
  DateTime? get confirmedAt;
  @override
  double? get bedResistanceMetric;
  @override
  LogSource get source;
  @override
  bool get isAnalysisReady;
  @override
  String? get analysisNotes;

  /// Create a copy of SleepLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SleepLogImplCopyWith<_$SleepLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
