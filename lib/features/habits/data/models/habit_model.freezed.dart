// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'habit_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Habit _$HabitFromJson(Map<String, dynamic> json) {
  return _Habit.fromJson(json);
}

/// @nodoc
mixin _$Habit {
  String get id => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  HabitType get type => throw _privateConstructorUsedError;
  HabitFrequency get frequency => throw _privateConstructorUsedError;
  int get targetCount => throw _privateConstructorUsedError;
  int get currentStreak => throw _privateConstructorUsedError;
  int get longestStreak => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  bool get hasTodoList => throw _privateConstructorUsedError;
  int get completionThreshold => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Habit to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Habit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HabitCopyWith<Habit> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HabitCopyWith<$Res> {
  factory $HabitCopyWith(Habit value, $Res Function(Habit) then) =
      _$HabitCopyWithImpl<$Res, Habit>;
  @useResult
  $Res call({
    String id,
    String uid,
    String name,
    HabitType type,
    HabitFrequency frequency,
    int targetCount,
    int currentStreak,
    int longestStreak,
    bool isActive,
    bool hasTodoList,
    int completionThreshold,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    DateTime createdAt,
  });
}

/// @nodoc
class _$HabitCopyWithImpl<$Res, $Val extends Habit>
    implements $HabitCopyWith<$Res> {
  _$HabitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Habit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? name = null,
    Object? type = null,
    Object? frequency = null,
    Object? targetCount = null,
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? isActive = null,
    Object? hasTodoList = null,
    Object? completionThreshold = null,
    Object? createdAt = null,
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
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as HabitType,
            frequency: null == frequency
                ? _value.frequency
                : frequency // ignore: cast_nullable_to_non_nullable
                      as HabitFrequency,
            targetCount: null == targetCount
                ? _value.targetCount
                : targetCount // ignore: cast_nullable_to_non_nullable
                      as int,
            currentStreak: null == currentStreak
                ? _value.currentStreak
                : currentStreak // ignore: cast_nullable_to_non_nullable
                      as int,
            longestStreak: null == longestStreak
                ? _value.longestStreak
                : longestStreak // ignore: cast_nullable_to_non_nullable
                      as int,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HabitImplCopyWith<$Res> implements $HabitCopyWith<$Res> {
  factory _$$HabitImplCopyWith(
    _$HabitImpl value,
    $Res Function(_$HabitImpl) then,
  ) = __$$HabitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String uid,
    String name,
    HabitType type,
    HabitFrequency frequency,
    int targetCount,
    int currentStreak,
    int longestStreak,
    bool isActive,
    bool hasTodoList,
    int completionThreshold,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    DateTime createdAt,
  });
}

/// @nodoc
class __$$HabitImplCopyWithImpl<$Res>
    extends _$HabitCopyWithImpl<$Res, _$HabitImpl>
    implements _$$HabitImplCopyWith<$Res> {
  __$$HabitImplCopyWithImpl(
    _$HabitImpl _value,
    $Res Function(_$HabitImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Habit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? name = null,
    Object? type = null,
    Object? frequency = null,
    Object? targetCount = null,
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? isActive = null,
    Object? hasTodoList = null,
    Object? completionThreshold = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$HabitImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        uid: null == uid
            ? _value.uid
            : uid // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as HabitType,
        frequency: null == frequency
            ? _value.frequency
            : frequency // ignore: cast_nullable_to_non_nullable
                  as HabitFrequency,
        targetCount: null == targetCount
            ? _value.targetCount
            : targetCount // ignore: cast_nullable_to_non_nullable
                  as int,
        currentStreak: null == currentStreak
            ? _value.currentStreak
            : currentStreak // ignore: cast_nullable_to_non_nullable
                  as int,
        longestStreak: null == longestStreak
            ? _value.longestStreak
            : longestStreak // ignore: cast_nullable_to_non_nullable
                  as int,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HabitImpl extends _Habit {
  const _$HabitImpl({
    required this.id,
    required this.uid,
    required this.name,
    required this.type,
    required this.frequency,
    required this.targetCount,
    required this.currentStreak,
    required this.longestStreak,
    required this.isActive,
    this.hasTodoList = false,
    this.completionThreshold = 70,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    required this.createdAt,
  }) : super._();

  factory _$HabitImpl.fromJson(Map<String, dynamic> json) =>
      _$$HabitImplFromJson(json);

  @override
  final String id;
  @override
  final String uid;
  @override
  final String name;
  @override
  final HabitType type;
  @override
  final HabitFrequency frequency;
  @override
  final int targetCount;
  @override
  final int currentStreak;
  @override
  final int longestStreak;
  @override
  final bool isActive;
  @override
  @JsonKey()
  final bool hasTodoList;
  @override
  @JsonKey()
  final int completionThreshold;
  @override
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime createdAt;

  @override
  String toString() {
    return 'Habit(id: $id, uid: $uid, name: $name, type: $type, frequency: $frequency, targetCount: $targetCount, currentStreak: $currentStreak, longestStreak: $longestStreak, isActive: $isActive, hasTodoList: $hasTodoList, completionThreshold: $completionThreshold, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HabitImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.targetCount, targetCount) ||
                other.targetCount == targetCount) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.longestStreak, longestStreak) ||
                other.longestStreak == longestStreak) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.hasTodoList, hasTodoList) ||
                other.hasTodoList == hasTodoList) &&
            (identical(other.completionThreshold, completionThreshold) ||
                other.completionThreshold == completionThreshold) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    uid,
    name,
    type,
    frequency,
    targetCount,
    currentStreak,
    longestStreak,
    isActive,
    hasTodoList,
    completionThreshold,
    createdAt,
  );

  /// Create a copy of Habit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HabitImplCopyWith<_$HabitImpl> get copyWith =>
      __$$HabitImplCopyWithImpl<_$HabitImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HabitImplToJson(this);
  }
}

abstract class _Habit extends Habit {
  const factory _Habit({
    required final String id,
    required final String uid,
    required final String name,
    required final HabitType type,
    required final HabitFrequency frequency,
    required final int targetCount,
    required final int currentStreak,
    required final int longestStreak,
    required final bool isActive,
    final bool hasTodoList,
    final int completionThreshold,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    required final DateTime createdAt,
  }) = _$HabitImpl;
  const _Habit._() : super._();

  factory _Habit.fromJson(Map<String, dynamic> json) = _$HabitImpl.fromJson;

  @override
  String get id;
  @override
  String get uid;
  @override
  String get name;
  @override
  HabitType get type;
  @override
  HabitFrequency get frequency;
  @override
  int get targetCount;
  @override
  int get currentStreak;
  @override
  int get longestStreak;
  @override
  bool get isActive;
  @override
  bool get hasTodoList;
  @override
  int get completionThreshold;
  @override
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime get createdAt;

  /// Create a copy of Habit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HabitImplCopyWith<_$HabitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
