// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'financial_commitment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FinancialCommitment _$FinancialCommitmentFromJson(Map<String, dynamic> json) {
  return _FinancialCommitment.fromJson(json);
}

/// @nodoc
mixin _$FinancialCommitment {
  String get id => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  CommitmentFrequency get frequency => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime get nextDueDate => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this FinancialCommitment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FinancialCommitment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FinancialCommitmentCopyWith<FinancialCommitment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FinancialCommitmentCopyWith<$Res> {
  factory $FinancialCommitmentCopyWith(
    FinancialCommitment value,
    $Res Function(FinancialCommitment) then,
  ) = _$FinancialCommitmentCopyWithImpl<$Res, FinancialCommitment>;
  @useResult
  $Res call({
    String id,
    String uid,
    String name,
    double amount,
    CommitmentFrequency frequency,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    DateTime nextDueDate,
    bool active,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    DateTime createdAt,
  });
}

/// @nodoc
class _$FinancialCommitmentCopyWithImpl<$Res, $Val extends FinancialCommitment>
    implements $FinancialCommitmentCopyWith<$Res> {
  _$FinancialCommitmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FinancialCommitment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? name = null,
    Object? amount = null,
    Object? frequency = null,
    Object? nextDueDate = null,
    Object? active = null,
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
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            frequency: null == frequency
                ? _value.frequency
                : frequency // ignore: cast_nullable_to_non_nullable
                      as CommitmentFrequency,
            nextDueDate: null == nextDueDate
                ? _value.nextDueDate
                : nextDueDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            active: null == active
                ? _value.active
                : active // ignore: cast_nullable_to_non_nullable
                      as bool,
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
abstract class _$$FinancialCommitmentImplCopyWith<$Res>
    implements $FinancialCommitmentCopyWith<$Res> {
  factory _$$FinancialCommitmentImplCopyWith(
    _$FinancialCommitmentImpl value,
    $Res Function(_$FinancialCommitmentImpl) then,
  ) = __$$FinancialCommitmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String uid,
    String name,
    double amount,
    CommitmentFrequency frequency,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    DateTime nextDueDate,
    bool active,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    DateTime createdAt,
  });
}

/// @nodoc
class __$$FinancialCommitmentImplCopyWithImpl<$Res>
    extends _$FinancialCommitmentCopyWithImpl<$Res, _$FinancialCommitmentImpl>
    implements _$$FinancialCommitmentImplCopyWith<$Res> {
  __$$FinancialCommitmentImplCopyWithImpl(
    _$FinancialCommitmentImpl _value,
    $Res Function(_$FinancialCommitmentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FinancialCommitment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? name = null,
    Object? amount = null,
    Object? frequency = null,
    Object? nextDueDate = null,
    Object? active = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$FinancialCommitmentImpl(
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
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        frequency: null == frequency
            ? _value.frequency
            : frequency // ignore: cast_nullable_to_non_nullable
                  as CommitmentFrequency,
        nextDueDate: null == nextDueDate
            ? _value.nextDueDate
            : nextDueDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        active: null == active
            ? _value.active
            : active // ignore: cast_nullable_to_non_nullable
                  as bool,
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
class _$FinancialCommitmentImpl extends _FinancialCommitment {
  const _$FinancialCommitmentImpl({
    required this.id,
    required this.uid,
    required this.name,
    required this.amount,
    required this.frequency,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    required this.nextDueDate,
    required this.active,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    required this.createdAt,
  }) : super._();

  factory _$FinancialCommitmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$FinancialCommitmentImplFromJson(json);

  @override
  final String id;
  @override
  final String uid;
  @override
  final String name;
  @override
  final double amount;
  @override
  final CommitmentFrequency frequency;
  @override
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime nextDueDate;
  @override
  final bool active;
  @override
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime createdAt;

  @override
  String toString() {
    return 'FinancialCommitment(id: $id, uid: $uid, name: $name, amount: $amount, frequency: $frequency, nextDueDate: $nextDueDate, active: $active, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FinancialCommitmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.nextDueDate, nextDueDate) ||
                other.nextDueDate == nextDueDate) &&
            (identical(other.active, active) || other.active == active) &&
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
    amount,
    frequency,
    nextDueDate,
    active,
    createdAt,
  );

  /// Create a copy of FinancialCommitment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FinancialCommitmentImplCopyWith<_$FinancialCommitmentImpl> get copyWith =>
      __$$FinancialCommitmentImplCopyWithImpl<_$FinancialCommitmentImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FinancialCommitmentImplToJson(this);
  }
}

abstract class _FinancialCommitment extends FinancialCommitment {
  const factory _FinancialCommitment({
    required final String id,
    required final String uid,
    required final String name,
    required final double amount,
    required final CommitmentFrequency frequency,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    required final DateTime nextDueDate,
    required final bool active,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    required final DateTime createdAt,
  }) = _$FinancialCommitmentImpl;
  const _FinancialCommitment._() : super._();

  factory _FinancialCommitment.fromJson(Map<String, dynamic> json) =
      _$FinancialCommitmentImpl.fromJson;

  @override
  String get id;
  @override
  String get uid;
  @override
  String get name;
  @override
  double get amount;
  @override
  CommitmentFrequency get frequency;
  @override
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime get nextDueDate;
  @override
  bool get active;
  @override
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime get createdAt;

  /// Create a copy of FinancialCommitment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FinancialCommitmentImplCopyWith<_$FinancialCommitmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
