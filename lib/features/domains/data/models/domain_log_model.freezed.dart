// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'domain_log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DomainLog _$DomainLogFromJson(Map<String, dynamic> json) {
  return _DomainLog.fromJson(json);
}

/// @nodoc
mixin _$DomainLog {
  String get id => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  String get domainId => throw _privateConstructorUsedError;
  int get duration => throw _privateConstructorUsedError;
  int get intensity => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get loggedAt => throw _privateConstructorUsedError;
  String? get metricLabel => throw _privateConstructorUsedError;
  double? get metricValue => throw _privateConstructorUsedError;
  bool get hasTodoList => throw _privateConstructorUsedError;
  int get completionThreshold => throw _privateConstructorUsedError;
  double get completionPct => throw _privateConstructorUsedError;

  /// Serializes this DomainLog to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DomainLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DomainLogCopyWith<DomainLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DomainLogCopyWith<$Res> {
  factory $DomainLogCopyWith(DomainLog value, $Res Function(DomainLog) then) =
      _$DomainLogCopyWithImpl<$Res, DomainLog>;
  @useResult
  $Res call({
    String id,
    String uid,
    String domainId,
    int duration,
    int intensity,
    String? notes,
    DateTime loggedAt,
    String? metricLabel,
    double? metricValue,
    bool hasTodoList,
    int completionThreshold,
    double completionPct,
  });
}

/// @nodoc
class _$DomainLogCopyWithImpl<$Res, $Val extends DomainLog>
    implements $DomainLogCopyWith<$Res> {
  _$DomainLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DomainLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? domainId = null,
    Object? duration = null,
    Object? intensity = null,
    Object? notes = freezed,
    Object? loggedAt = null,
    Object? metricLabel = freezed,
    Object? metricValue = freezed,
    Object? hasTodoList = null,
    Object? completionThreshold = null,
    Object? completionPct = null,
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
            domainId: null == domainId
                ? _value.domainId
                : domainId // ignore: cast_nullable_to_non_nullable
                      as String,
            duration: null == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as int,
            intensity: null == intensity
                ? _value.intensity
                : intensity // ignore: cast_nullable_to_non_nullable
                      as int,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            loggedAt: null == loggedAt
                ? _value.loggedAt
                : loggedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            metricLabel: freezed == metricLabel
                ? _value.metricLabel
                : metricLabel // ignore: cast_nullable_to_non_nullable
                      as String?,
            metricValue: freezed == metricValue
                ? _value.metricValue
                : metricValue // ignore: cast_nullable_to_non_nullable
                      as double?,
            hasTodoList: null == hasTodoList
                ? _value.hasTodoList
                : hasTodoList // ignore: cast_nullable_to_non_nullable
                      as bool,
            completionThreshold: null == completionThreshold
                ? _value.completionThreshold
                : completionThreshold // ignore: cast_nullable_to_non_nullable
                      as int,
            completionPct: null == completionPct
                ? _value.completionPct
                : completionPct // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DomainLogImplCopyWith<$Res>
    implements $DomainLogCopyWith<$Res> {
  factory _$$DomainLogImplCopyWith(
    _$DomainLogImpl value,
    $Res Function(_$DomainLogImpl) then,
  ) = __$$DomainLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String uid,
    String domainId,
    int duration,
    int intensity,
    String? notes,
    DateTime loggedAt,
    String? metricLabel,
    double? metricValue,
    bool hasTodoList,
    int completionThreshold,
    double completionPct,
  });
}

/// @nodoc
class __$$DomainLogImplCopyWithImpl<$Res>
    extends _$DomainLogCopyWithImpl<$Res, _$DomainLogImpl>
    implements _$$DomainLogImplCopyWith<$Res> {
  __$$DomainLogImplCopyWithImpl(
    _$DomainLogImpl _value,
    $Res Function(_$DomainLogImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DomainLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? domainId = null,
    Object? duration = null,
    Object? intensity = null,
    Object? notes = freezed,
    Object? loggedAt = null,
    Object? metricLabel = freezed,
    Object? metricValue = freezed,
    Object? hasTodoList = null,
    Object? completionThreshold = null,
    Object? completionPct = null,
  }) {
    return _then(
      _$DomainLogImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        uid: null == uid
            ? _value.uid
            : uid // ignore: cast_nullable_to_non_nullable
                  as String,
        domainId: null == domainId
            ? _value.domainId
            : domainId // ignore: cast_nullable_to_non_nullable
                  as String,
        duration: null == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as int,
        intensity: null == intensity
            ? _value.intensity
            : intensity // ignore: cast_nullable_to_non_nullable
                  as int,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        loggedAt: null == loggedAt
            ? _value.loggedAt
            : loggedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        metricLabel: freezed == metricLabel
            ? _value.metricLabel
            : metricLabel // ignore: cast_nullable_to_non_nullable
                  as String?,
        metricValue: freezed == metricValue
            ? _value.metricValue
            : metricValue // ignore: cast_nullable_to_non_nullable
                  as double?,
        hasTodoList: null == hasTodoList
            ? _value.hasTodoList
            : hasTodoList // ignore: cast_nullable_to_non_nullable
                  as bool,
        completionThreshold: null == completionThreshold
            ? _value.completionThreshold
            : completionThreshold // ignore: cast_nullable_to_non_nullable
                  as int,
        completionPct: null == completionPct
            ? _value.completionPct
            : completionPct // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DomainLogImpl implements _DomainLog {
  const _$DomainLogImpl({
    required this.id,
    required this.uid,
    required this.domainId,
    required this.duration,
    this.intensity = 5,
    this.notes,
    required this.loggedAt,
    this.metricLabel,
    this.metricValue,
    this.hasTodoList = false,
    this.completionThreshold = 70,
    this.completionPct = 100.0,
  });

  factory _$DomainLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$DomainLogImplFromJson(json);

  @override
  final String id;
  @override
  final String uid;
  @override
  final String domainId;
  @override
  final int duration;
  @override
  @JsonKey()
  final int intensity;
  @override
  final String? notes;
  @override
  final DateTime loggedAt;
  @override
  final String? metricLabel;
  @override
  final double? metricValue;
  @override
  @JsonKey()
  final bool hasTodoList;
  @override
  @JsonKey()
  final int completionThreshold;
  @override
  @JsonKey()
  final double completionPct;

  @override
  String toString() {
    return 'DomainLog(id: $id, uid: $uid, domainId: $domainId, duration: $duration, intensity: $intensity, notes: $notes, loggedAt: $loggedAt, metricLabel: $metricLabel, metricValue: $metricValue, hasTodoList: $hasTodoList, completionThreshold: $completionThreshold, completionPct: $completionPct)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DomainLogImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.domainId, domainId) ||
                other.domainId == domainId) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.intensity, intensity) ||
                other.intensity == intensity) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.loggedAt, loggedAt) ||
                other.loggedAt == loggedAt) &&
            (identical(other.metricLabel, metricLabel) ||
                other.metricLabel == metricLabel) &&
            (identical(other.metricValue, metricValue) ||
                other.metricValue == metricValue) &&
            (identical(other.hasTodoList, hasTodoList) ||
                other.hasTodoList == hasTodoList) &&
            (identical(other.completionThreshold, completionThreshold) ||
                other.completionThreshold == completionThreshold) &&
            (identical(other.completionPct, completionPct) ||
                other.completionPct == completionPct));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    uid,
    domainId,
    duration,
    intensity,
    notes,
    loggedAt,
    metricLabel,
    metricValue,
    hasTodoList,
    completionThreshold,
    completionPct,
  );

  /// Create a copy of DomainLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DomainLogImplCopyWith<_$DomainLogImpl> get copyWith =>
      __$$DomainLogImplCopyWithImpl<_$DomainLogImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DomainLogImplToJson(this);
  }
}

abstract class _DomainLog implements DomainLog {
  const factory _DomainLog({
    required final String id,
    required final String uid,
    required final String domainId,
    required final int duration,
    final int intensity,
    final String? notes,
    required final DateTime loggedAt,
    final String? metricLabel,
    final double? metricValue,
    final bool hasTodoList,
    final int completionThreshold,
    final double completionPct,
  }) = _$DomainLogImpl;

  factory _DomainLog.fromJson(Map<String, dynamic> json) =
      _$DomainLogImpl.fromJson;

  @override
  String get id;
  @override
  String get uid;
  @override
  String get domainId;
  @override
  int get duration;
  @override
  int get intensity;
  @override
  String? get notes;
  @override
  DateTime get loggedAt;
  @override
  String? get metricLabel;
  @override
  double? get metricValue;
  @override
  bool get hasTodoList;
  @override
  int get completionThreshold;
  @override
  double get completionPct;

  /// Create a copy of DomainLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DomainLogImplCopyWith<_$DomainLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
