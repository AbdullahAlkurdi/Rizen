// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shadow_habit_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ShadowHabit _$ShadowHabitFromJson(Map<String, dynamic> json) {
  return _ShadowHabit.fromJson(json);
}

/// @nodoc
mixin _$ShadowHabit {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  int get timeWasted => throw _privateConstructorUsedError;
  ShadowFrequency get frequency => throw _privateConstructorUsedError;
  DateTime get loggedAt => throw _privateConstructorUsedError;

  /// Serializes this ShadowHabit to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShadowHabit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShadowHabitCopyWith<ShadowHabit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShadowHabitCopyWith<$Res> {
  factory $ShadowHabitCopyWith(
    ShadowHabit value,
    $Res Function(ShadowHabit) then,
  ) = _$ShadowHabitCopyWithImpl<$Res, ShadowHabit>;
  @useResult
  $Res call({
    String id,
    String name,
    String category,
    int timeWasted,
    ShadowFrequency frequency,
    DateTime loggedAt,
  });
}

/// @nodoc
class _$ShadowHabitCopyWithImpl<$Res, $Val extends ShadowHabit>
    implements $ShadowHabitCopyWith<$Res> {
  _$ShadowHabitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShadowHabit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? timeWasted = null,
    Object? frequency = null,
    Object? loggedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            timeWasted: null == timeWasted
                ? _value.timeWasted
                : timeWasted // ignore: cast_nullable_to_non_nullable
                      as int,
            frequency: null == frequency
                ? _value.frequency
                : frequency // ignore: cast_nullable_to_non_nullable
                      as ShadowFrequency,
            loggedAt: null == loggedAt
                ? _value.loggedAt
                : loggedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ShadowHabitImplCopyWith<$Res>
    implements $ShadowHabitCopyWith<$Res> {
  factory _$$ShadowHabitImplCopyWith(
    _$ShadowHabitImpl value,
    $Res Function(_$ShadowHabitImpl) then,
  ) = __$$ShadowHabitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String category,
    int timeWasted,
    ShadowFrequency frequency,
    DateTime loggedAt,
  });
}

/// @nodoc
class __$$ShadowHabitImplCopyWithImpl<$Res>
    extends _$ShadowHabitCopyWithImpl<$Res, _$ShadowHabitImpl>
    implements _$$ShadowHabitImplCopyWith<$Res> {
  __$$ShadowHabitImplCopyWithImpl(
    _$ShadowHabitImpl _value,
    $Res Function(_$ShadowHabitImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShadowHabit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? timeWasted = null,
    Object? frequency = null,
    Object? loggedAt = null,
  }) {
    return _then(
      _$ShadowHabitImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        timeWasted: null == timeWasted
            ? _value.timeWasted
            : timeWasted // ignore: cast_nullable_to_non_nullable
                  as int,
        frequency: null == frequency
            ? _value.frequency
            : frequency // ignore: cast_nullable_to_non_nullable
                  as ShadowFrequency,
        loggedAt: null == loggedAt
            ? _value.loggedAt
            : loggedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ShadowHabitImpl implements _ShadowHabit {
  const _$ShadowHabitImpl({
    required this.id,
    required this.name,
    required this.category,
    this.timeWasted = 0,
    required this.frequency,
    required this.loggedAt,
  });

  factory _$ShadowHabitImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShadowHabitImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String category;
  @override
  @JsonKey()
  final int timeWasted;
  @override
  final ShadowFrequency frequency;
  @override
  final DateTime loggedAt;

  @override
  String toString() {
    return 'ShadowHabit(id: $id, name: $name, category: $category, timeWasted: $timeWasted, frequency: $frequency, loggedAt: $loggedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShadowHabitImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.timeWasted, timeWasted) ||
                other.timeWasted == timeWasted) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.loggedAt, loggedAt) ||
                other.loggedAt == loggedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    category,
    timeWasted,
    frequency,
    loggedAt,
  );

  /// Create a copy of ShadowHabit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShadowHabitImplCopyWith<_$ShadowHabitImpl> get copyWith =>
      __$$ShadowHabitImplCopyWithImpl<_$ShadowHabitImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShadowHabitImplToJson(this);
  }
}

abstract class _ShadowHabit implements ShadowHabit {
  const factory _ShadowHabit({
    required final String id,
    required final String name,
    required final String category,
    final int timeWasted,
    required final ShadowFrequency frequency,
    required final DateTime loggedAt,
  }) = _$ShadowHabitImpl;

  factory _ShadowHabit.fromJson(Map<String, dynamic> json) =
      _$ShadowHabitImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get category;
  @override
  int get timeWasted;
  @override
  ShadowFrequency get frequency;
  @override
  DateTime get loggedAt;

  /// Create a copy of ShadowHabit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShadowHabitImplCopyWith<_$ShadowHabitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
