// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'routine_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TimeBlock _$TimeBlockFromJson(Map<String, dynamic> json) {
  return _TimeBlock.fromJson(json);
}

/// @nodoc
mixin _$TimeBlock {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get domainId => throw _privateConstructorUsedError;
  int get startTime => throw _privateConstructorUsedError;
  int get endTime => throw _privateConstructorUsedError;
  TimeBlockAnchor get anchor => throw _privateConstructorUsedError;
  int? get durationMinutes => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  List<String> get linkedHabitIds => throw _privateConstructorUsedError;
  bool get hasTodoList => throw _privateConstructorUsedError;
  int get completionThreshold => throw _privateConstructorUsedError;

  /// Serializes this TimeBlock to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TimeBlock
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimeBlockCopyWith<TimeBlock> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeBlockCopyWith<$Res> {
  factory $TimeBlockCopyWith(TimeBlock value, $Res Function(TimeBlock) then) =
      _$TimeBlockCopyWithImpl<$Res, TimeBlock>;
  @useResult
  $Res call({
    String id,
    String title,
    String domainId,
    int startTime,
    int endTime,
    TimeBlockAnchor anchor,
    int? durationMinutes,
    String? description,
    bool isCompleted,
    List<String> linkedHabitIds,
    bool hasTodoList,
    int completionThreshold,
  });
}

/// @nodoc
class _$TimeBlockCopyWithImpl<$Res, $Val extends TimeBlock>
    implements $TimeBlockCopyWith<$Res> {
  _$TimeBlockCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimeBlock
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? domainId = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? anchor = null,
    Object? durationMinutes = freezed,
    Object? description = freezed,
    Object? isCompleted = null,
    Object? linkedHabitIds = null,
    Object? hasTodoList = null,
    Object? completionThreshold = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            domainId: null == domainId
                ? _value.domainId
                : domainId // ignore: cast_nullable_to_non_nullable
                      as String,
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as int,
            endTime: null == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as int,
            anchor: null == anchor
                ? _value.anchor
                : anchor // ignore: cast_nullable_to_non_nullable
                      as TimeBlockAnchor,
            durationMinutes: freezed == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                      as int?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            isCompleted: null == isCompleted
                ? _value.isCompleted
                : isCompleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            linkedHabitIds: null == linkedHabitIds
                ? _value.linkedHabitIds
                : linkedHabitIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            hasTodoList: null == hasTodoList
                ? _value.hasTodoList
                : hasTodoList // ignore: cast_nullable_to_non_nullable
                      as bool,
            completionThreshold: null == completionThreshold
                ? _value.completionThreshold
                : completionThreshold // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TimeBlockImplCopyWith<$Res>
    implements $TimeBlockCopyWith<$Res> {
  factory _$$TimeBlockImplCopyWith(
    _$TimeBlockImpl value,
    $Res Function(_$TimeBlockImpl) then,
  ) = __$$TimeBlockImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String domainId,
    int startTime,
    int endTime,
    TimeBlockAnchor anchor,
    int? durationMinutes,
    String? description,
    bool isCompleted,
    List<String> linkedHabitIds,
    bool hasTodoList,
    int completionThreshold,
  });
}

/// @nodoc
class __$$TimeBlockImplCopyWithImpl<$Res>
    extends _$TimeBlockCopyWithImpl<$Res, _$TimeBlockImpl>
    implements _$$TimeBlockImplCopyWith<$Res> {
  __$$TimeBlockImplCopyWithImpl(
    _$TimeBlockImpl _value,
    $Res Function(_$TimeBlockImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TimeBlock
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? domainId = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? anchor = null,
    Object? durationMinutes = freezed,
    Object? description = freezed,
    Object? isCompleted = null,
    Object? linkedHabitIds = null,
    Object? hasTodoList = null,
    Object? completionThreshold = null,
  }) {
    return _then(
      _$TimeBlockImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        domainId: null == domainId
            ? _value.domainId
            : domainId // ignore: cast_nullable_to_non_nullable
                  as String,
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as int,
        endTime: null == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as int,
        anchor: null == anchor
            ? _value.anchor
            : anchor // ignore: cast_nullable_to_non_nullable
                  as TimeBlockAnchor,
        durationMinutes: freezed == durationMinutes
            ? _value.durationMinutes
            : durationMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        isCompleted: null == isCompleted
            ? _value.isCompleted
            : isCompleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        linkedHabitIds: null == linkedHabitIds
            ? _value._linkedHabitIds
            : linkedHabitIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        hasTodoList: null == hasTodoList
            ? _value.hasTodoList
            : hasTodoList // ignore: cast_nullable_to_non_nullable
                  as bool,
        completionThreshold: null == completionThreshold
            ? _value.completionThreshold
            : completionThreshold // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TimeBlockImpl implements _TimeBlock {
  const _$TimeBlockImpl({
    required this.id,
    required this.title,
    required this.domainId,
    required this.startTime,
    required this.endTime,
    required this.anchor,
    this.durationMinutes,
    this.description,
    this.isCompleted = false,
    final List<String> linkedHabitIds = const [],
    this.hasTodoList = false,
    this.completionThreshold = 70,
  }) : _linkedHabitIds = linkedHabitIds;

  factory _$TimeBlockImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeBlockImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String domainId;
  @override
  final int startTime;
  @override
  final int endTime;
  @override
  final TimeBlockAnchor anchor;
  @override
  final int? durationMinutes;
  @override
  final String? description;
  @override
  @JsonKey()
  final bool isCompleted;
  final List<String> _linkedHabitIds;
  @override
  @JsonKey()
  List<String> get linkedHabitIds {
    if (_linkedHabitIds is EqualUnmodifiableListView) return _linkedHabitIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_linkedHabitIds);
  }

  @override
  @JsonKey()
  final bool hasTodoList;
  @override
  @JsonKey()
  final int completionThreshold;

  @override
  String toString() {
    return 'TimeBlock(id: $id, title: $title, domainId: $domainId, startTime: $startTime, endTime: $endTime, anchor: $anchor, durationMinutes: $durationMinutes, description: $description, isCompleted: $isCompleted, linkedHabitIds: $linkedHabitIds, hasTodoList: $hasTodoList, completionThreshold: $completionThreshold)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeBlockImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.domainId, domainId) ||
                other.domainId == domainId) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.anchor, anchor) || other.anchor == anchor) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            const DeepCollectionEquality().equals(
              other._linkedHabitIds,
              _linkedHabitIds,
            ) &&
            (identical(other.hasTodoList, hasTodoList) ||
                other.hasTodoList == hasTodoList) &&
            (identical(other.completionThreshold, completionThreshold) ||
                other.completionThreshold == completionThreshold));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    domainId,
    startTime,
    endTime,
    anchor,
    durationMinutes,
    description,
    isCompleted,
    const DeepCollectionEquality().hash(_linkedHabitIds),
    hasTodoList,
    completionThreshold,
  );

  /// Create a copy of TimeBlock
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeBlockImplCopyWith<_$TimeBlockImpl> get copyWith =>
      __$$TimeBlockImplCopyWithImpl<_$TimeBlockImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeBlockImplToJson(this);
  }
}

abstract class _TimeBlock implements TimeBlock {
  const factory _TimeBlock({
    required final String id,
    required final String title,
    required final String domainId,
    required final int startTime,
    required final int endTime,
    required final TimeBlockAnchor anchor,
    final int? durationMinutes,
    final String? description,
    final bool isCompleted,
    final List<String> linkedHabitIds,
    final bool hasTodoList,
    final int completionThreshold,
  }) = _$TimeBlockImpl;

  factory _TimeBlock.fromJson(Map<String, dynamic> json) =
      _$TimeBlockImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get domainId;
  @override
  int get startTime;
  @override
  int get endTime;
  @override
  TimeBlockAnchor get anchor;
  @override
  int? get durationMinutes;
  @override
  String? get description;
  @override
  bool get isCompleted;
  @override
  List<String> get linkedHabitIds;
  @override
  bool get hasTodoList;
  @override
  int get completionThreshold;

  /// Create a copy of TimeBlock
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimeBlockImplCopyWith<_$TimeBlockImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Routine _$RoutineFromJson(Map<String, dynamic> json) {
  return _Routine.fromJson(json);
}

/// @nodoc
mixin _$Routine {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  bool get isEnabled => throw _privateConstructorUsedError;
  List<String> get timeBlockIds => throw _privateConstructorUsedError;
  String get frequency => throw _privateConstructorUsedError;
  String? get scheduleAnchorId => throw _privateConstructorUsedError;
  DateTime? get nextScheduledAt => throw _privateConstructorUsedError;
  int get streak => throw _privateConstructorUsedError;
  DateTime? get lastCompletedAt => throw _privateConstructorUsedError;
  bool get hasTodoList => throw _privateConstructorUsedError;
  int get completionThreshold => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Routine to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Routine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoutineCopyWith<Routine> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoutineCopyWith<$Res> {
  factory $RoutineCopyWith(Routine value, $Res Function(Routine) then) =
      _$RoutineCopyWithImpl<$Res, Routine>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    bool isEnabled,
    List<String> timeBlockIds,
    String frequency,
    String? scheduleAnchorId,
    DateTime? nextScheduledAt,
    int streak,
    DateTime? lastCompletedAt,
    bool hasTodoList,
    int completionThreshold,
    DateTime createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$RoutineCopyWithImpl<$Res, $Val extends Routine>
    implements $RoutineCopyWith<$Res> {
  _$RoutineCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Routine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? isEnabled = null,
    Object? timeBlockIds = null,
    Object? frequency = null,
    Object? scheduleAnchorId = freezed,
    Object? nextScheduledAt = freezed,
    Object? streak = null,
    Object? lastCompletedAt = freezed,
    Object? hasTodoList = null,
    Object? completionThreshold = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            isEnabled: null == isEnabled
                ? _value.isEnabled
                : isEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            timeBlockIds: null == timeBlockIds
                ? _value.timeBlockIds
                : timeBlockIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            frequency: null == frequency
                ? _value.frequency
                : frequency // ignore: cast_nullable_to_non_nullable
                      as String,
            scheduleAnchorId: freezed == scheduleAnchorId
                ? _value.scheduleAnchorId
                : scheduleAnchorId // ignore: cast_nullable_to_non_nullable
                      as String?,
            nextScheduledAt: freezed == nextScheduledAt
                ? _value.nextScheduledAt
                : nextScheduledAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            streak: null == streak
                ? _value.streak
                : streak // ignore: cast_nullable_to_non_nullable
                      as int,
            lastCompletedAt: freezed == lastCompletedAt
                ? _value.lastCompletedAt
                : lastCompletedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            hasTodoList: null == hasTodoList
                ? _value.hasTodoList
                : hasTodoList // ignore: cast_nullable_to_non_nullable
                      as bool,
            completionThreshold: null == completionThreshold
                ? _value.completionThreshold
                : completionThreshold // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RoutineImplCopyWith<$Res> implements $RoutineCopyWith<$Res> {
  factory _$$RoutineImplCopyWith(
    _$RoutineImpl value,
    $Res Function(_$RoutineImpl) then,
  ) = __$$RoutineImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    bool isEnabled,
    List<String> timeBlockIds,
    String frequency,
    String? scheduleAnchorId,
    DateTime? nextScheduledAt,
    int streak,
    DateTime? lastCompletedAt,
    bool hasTodoList,
    int completionThreshold,
    DateTime createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$RoutineImplCopyWithImpl<$Res>
    extends _$RoutineCopyWithImpl<$Res, _$RoutineImpl>
    implements _$$RoutineImplCopyWith<$Res> {
  __$$RoutineImplCopyWithImpl(
    _$RoutineImpl _value,
    $Res Function(_$RoutineImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Routine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? isEnabled = null,
    Object? timeBlockIds = null,
    Object? frequency = null,
    Object? scheduleAnchorId = freezed,
    Object? nextScheduledAt = freezed,
    Object? streak = null,
    Object? lastCompletedAt = freezed,
    Object? hasTodoList = null,
    Object? completionThreshold = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$RoutineImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        isEnabled: null == isEnabled
            ? _value.isEnabled
            : isEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        timeBlockIds: null == timeBlockIds
            ? _value._timeBlockIds
            : timeBlockIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        frequency: null == frequency
            ? _value.frequency
            : frequency // ignore: cast_nullable_to_non_nullable
                  as String,
        scheduleAnchorId: freezed == scheduleAnchorId
            ? _value.scheduleAnchorId
            : scheduleAnchorId // ignore: cast_nullable_to_non_nullable
                  as String?,
        nextScheduledAt: freezed == nextScheduledAt
            ? _value.nextScheduledAt
            : nextScheduledAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        streak: null == streak
            ? _value.streak
            : streak // ignore: cast_nullable_to_non_nullable
                  as int,
        lastCompletedAt: freezed == lastCompletedAt
            ? _value.lastCompletedAt
            : lastCompletedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        hasTodoList: null == hasTodoList
            ? _value.hasTodoList
            : hasTodoList // ignore: cast_nullable_to_non_nullable
                  as bool,
        completionThreshold: null == completionThreshold
            ? _value.completionThreshold
            : completionThreshold // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RoutineImpl implements _Routine {
  const _$RoutineImpl({
    required this.id,
    required this.title,
    required this.description,
    required this.isEnabled,
    required final List<String> timeBlockIds,
    this.frequency = 'daily',
    this.scheduleAnchorId,
    this.nextScheduledAt,
    this.streak = 0,
    this.lastCompletedAt,
    this.hasTodoList = false,
    this.completionThreshold = 70,
    required this.createdAt,
    this.updatedAt,
  }) : _timeBlockIds = timeBlockIds;

  factory _$RoutineImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoutineImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final bool isEnabled;
  final List<String> _timeBlockIds;
  @override
  List<String> get timeBlockIds {
    if (_timeBlockIds is EqualUnmodifiableListView) return _timeBlockIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timeBlockIds);
  }

  @override
  @JsonKey()
  final String frequency;
  @override
  final String? scheduleAnchorId;
  @override
  final DateTime? nextScheduledAt;
  @override
  @JsonKey()
  final int streak;
  @override
  final DateTime? lastCompletedAt;
  @override
  @JsonKey()
  final bool hasTodoList;
  @override
  @JsonKey()
  final int completionThreshold;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Routine(id: $id, title: $title, description: $description, isEnabled: $isEnabled, timeBlockIds: $timeBlockIds, frequency: $frequency, scheduleAnchorId: $scheduleAnchorId, nextScheduledAt: $nextScheduledAt, streak: $streak, lastCompletedAt: $lastCompletedAt, hasTodoList: $hasTodoList, completionThreshold: $completionThreshold, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoutineImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled) &&
            const DeepCollectionEquality().equals(
              other._timeBlockIds,
              _timeBlockIds,
            ) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.scheduleAnchorId, scheduleAnchorId) ||
                other.scheduleAnchorId == scheduleAnchorId) &&
            (identical(other.nextScheduledAt, nextScheduledAt) ||
                other.nextScheduledAt == nextScheduledAt) &&
            (identical(other.streak, streak) || other.streak == streak) &&
            (identical(other.lastCompletedAt, lastCompletedAt) ||
                other.lastCompletedAt == lastCompletedAt) &&
            (identical(other.hasTodoList, hasTodoList) ||
                other.hasTodoList == hasTodoList) &&
            (identical(other.completionThreshold, completionThreshold) ||
                other.completionThreshold == completionThreshold) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    isEnabled,
    const DeepCollectionEquality().hash(_timeBlockIds),
    frequency,
    scheduleAnchorId,
    nextScheduledAt,
    streak,
    lastCompletedAt,
    hasTodoList,
    completionThreshold,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Routine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoutineImplCopyWith<_$RoutineImpl> get copyWith =>
      __$$RoutineImplCopyWithImpl<_$RoutineImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoutineImplToJson(this);
  }
}

abstract class _Routine implements Routine {
  const factory _Routine({
    required final String id,
    required final String title,
    required final String description,
    required final bool isEnabled,
    required final List<String> timeBlockIds,
    final String frequency,
    final String? scheduleAnchorId,
    final DateTime? nextScheduledAt,
    final int streak,
    final DateTime? lastCompletedAt,
    final bool hasTodoList,
    final int completionThreshold,
    required final DateTime createdAt,
    final DateTime? updatedAt,
  }) = _$RoutineImpl;

  factory _Routine.fromJson(Map<String, dynamic> json) = _$RoutineImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  bool get isEnabled;
  @override
  List<String> get timeBlockIds;
  @override
  String get frequency;
  @override
  String? get scheduleAnchorId;
  @override
  DateTime? get nextScheduledAt;
  @override
  int get streak;
  @override
  DateTime? get lastCompletedAt;
  @override
  bool get hasTodoList;
  @override
  int get completionThreshold;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Routine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoutineImplCopyWith<_$RoutineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ScheduleAnchor _$ScheduleAnchorFromJson(Map<String, dynamic> json) {
  return _ScheduleAnchor.fromJson(json);
}

/// @nodoc
mixin _$ScheduleAnchor {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String? get wakeTime => throw _privateConstructorUsedError;
  bool get prayerTimesEnabled => throw _privateConstructorUsedError;
  String? get calculationMethod => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;

  /// Serializes this ScheduleAnchor to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ScheduleAnchor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScheduleAnchorCopyWith<ScheduleAnchor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleAnchorCopyWith<$Res> {
  factory $ScheduleAnchorCopyWith(
    ScheduleAnchor value,
    $Res Function(ScheduleAnchor) then,
  ) = _$ScheduleAnchorCopyWithImpl<$Res, ScheduleAnchor>;
  @useResult
  $Res call({
    String id,
    String type,
    String? wakeTime,
    bool prayerTimesEnabled,
    String? calculationMethod,
    double? latitude,
    double? longitude,
  });
}

/// @nodoc
class _$ScheduleAnchorCopyWithImpl<$Res, $Val extends ScheduleAnchor>
    implements $ScheduleAnchorCopyWith<$Res> {
  _$ScheduleAnchorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScheduleAnchor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? wakeTime = freezed,
    Object? prayerTimesEnabled = null,
    Object? calculationMethod = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            wakeTime: freezed == wakeTime
                ? _value.wakeTime
                : wakeTime // ignore: cast_nullable_to_non_nullable
                      as String?,
            prayerTimesEnabled: null == prayerTimesEnabled
                ? _value.prayerTimesEnabled
                : prayerTimesEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            calculationMethod: freezed == calculationMethod
                ? _value.calculationMethod
                : calculationMethod // ignore: cast_nullable_to_non_nullable
                      as String?,
            latitude: freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            longitude: freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ScheduleAnchorImplCopyWith<$Res>
    implements $ScheduleAnchorCopyWith<$Res> {
  factory _$$ScheduleAnchorImplCopyWith(
    _$ScheduleAnchorImpl value,
    $Res Function(_$ScheduleAnchorImpl) then,
  ) = __$$ScheduleAnchorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String type,
    String? wakeTime,
    bool prayerTimesEnabled,
    String? calculationMethod,
    double? latitude,
    double? longitude,
  });
}

/// @nodoc
class __$$ScheduleAnchorImplCopyWithImpl<$Res>
    extends _$ScheduleAnchorCopyWithImpl<$Res, _$ScheduleAnchorImpl>
    implements _$$ScheduleAnchorImplCopyWith<$Res> {
  __$$ScheduleAnchorImplCopyWithImpl(
    _$ScheduleAnchorImpl _value,
    $Res Function(_$ScheduleAnchorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScheduleAnchor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? wakeTime = freezed,
    Object? prayerTimesEnabled = null,
    Object? calculationMethod = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(
      _$ScheduleAnchorImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        wakeTime: freezed == wakeTime
            ? _value.wakeTime
            : wakeTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        prayerTimesEnabled: null == prayerTimesEnabled
            ? _value.prayerTimesEnabled
            : prayerTimesEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        calculationMethod: freezed == calculationMethod
            ? _value.calculationMethod
            : calculationMethod // ignore: cast_nullable_to_non_nullable
                  as String?,
        latitude: freezed == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        longitude: freezed == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ScheduleAnchorImpl implements _ScheduleAnchor {
  const _$ScheduleAnchorImpl({
    required this.id,
    required this.type,
    this.wakeTime,
    this.prayerTimesEnabled = true,
    this.calculationMethod,
    this.latitude,
    this.longitude,
  });

  factory _$ScheduleAnchorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScheduleAnchorImplFromJson(json);

  @override
  final String id;
  @override
  final String type;
  @override
  final String? wakeTime;
  @override
  @JsonKey()
  final bool prayerTimesEnabled;
  @override
  final String? calculationMethod;
  @override
  final double? latitude;
  @override
  final double? longitude;

  @override
  String toString() {
    return 'ScheduleAnchor(id: $id, type: $type, wakeTime: $wakeTime, prayerTimesEnabled: $prayerTimesEnabled, calculationMethod: $calculationMethod, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduleAnchorImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.wakeTime, wakeTime) ||
                other.wakeTime == wakeTime) &&
            (identical(other.prayerTimesEnabled, prayerTimesEnabled) ||
                other.prayerTimesEnabled == prayerTimesEnabled) &&
            (identical(other.calculationMethod, calculationMethod) ||
                other.calculationMethod == calculationMethod) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    wakeTime,
    prayerTimesEnabled,
    calculationMethod,
    latitude,
    longitude,
  );

  /// Create a copy of ScheduleAnchor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduleAnchorImplCopyWith<_$ScheduleAnchorImpl> get copyWith =>
      __$$ScheduleAnchorImplCopyWithImpl<_$ScheduleAnchorImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ScheduleAnchorImplToJson(this);
  }
}

abstract class _ScheduleAnchor implements ScheduleAnchor {
  const factory _ScheduleAnchor({
    required final String id,
    required final String type,
    final String? wakeTime,
    final bool prayerTimesEnabled,
    final String? calculationMethod,
    final double? latitude,
    final double? longitude,
  }) = _$ScheduleAnchorImpl;

  factory _ScheduleAnchor.fromJson(Map<String, dynamic> json) =
      _$ScheduleAnchorImpl.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  String? get wakeTime;
  @override
  bool get prayerTimesEnabled;
  @override
  String? get calculationMethod;
  @override
  double? get latitude;
  @override
  double? get longitude;

  /// Create a copy of ScheduleAnchor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScheduleAnchorImplCopyWith<_$ScheduleAnchorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
