// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'budget_cycle_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BudgetCycle _$BudgetCycleFromJson(Map<String, dynamic> json) {
  return _BudgetCycle.fromJson(json);
}

/// @nodoc
mixin _$BudgetCycle {
  String get id => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  double get monthlyIncome => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime get cycleStart => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime get cycleEnd => throw _privateConstructorUsedError;
  double get totalSpent => throw _privateConstructorUsedError;
  double get totalCommitted => throw _privateConstructorUsedError;
  BudgetCycleStatus get status => throw _privateConstructorUsedError;

  /// Serializes this BudgetCycle to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BudgetCycle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BudgetCycleCopyWith<BudgetCycle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BudgetCycleCopyWith<$Res> {
  factory $BudgetCycleCopyWith(
    BudgetCycle value,
    $Res Function(BudgetCycle) then,
  ) = _$BudgetCycleCopyWithImpl<$Res, BudgetCycle>;
  @useResult
  $Res call({
    String id,
    String uid,
    double monthlyIncome,
    String currency,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    DateTime cycleStart,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    DateTime cycleEnd,
    double totalSpent,
    double totalCommitted,
    BudgetCycleStatus status,
  });
}

/// @nodoc
class _$BudgetCycleCopyWithImpl<$Res, $Val extends BudgetCycle>
    implements $BudgetCycleCopyWith<$Res> {
  _$BudgetCycleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BudgetCycle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? monthlyIncome = null,
    Object? currency = null,
    Object? cycleStart = null,
    Object? cycleEnd = null,
    Object? totalSpent = null,
    Object? totalCommitted = null,
    Object? status = null,
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
            monthlyIncome: null == monthlyIncome
                ? _value.monthlyIncome
                : monthlyIncome // ignore: cast_nullable_to_non_nullable
                      as double,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String,
            cycleStart: null == cycleStart
                ? _value.cycleStart
                : cycleStart // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            cycleEnd: null == cycleEnd
                ? _value.cycleEnd
                : cycleEnd // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            totalSpent: null == totalSpent
                ? _value.totalSpent
                : totalSpent // ignore: cast_nullable_to_non_nullable
                      as double,
            totalCommitted: null == totalCommitted
                ? _value.totalCommitted
                : totalCommitted // ignore: cast_nullable_to_non_nullable
                      as double,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as BudgetCycleStatus,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BudgetCycleImplCopyWith<$Res>
    implements $BudgetCycleCopyWith<$Res> {
  factory _$$BudgetCycleImplCopyWith(
    _$BudgetCycleImpl value,
    $Res Function(_$BudgetCycleImpl) then,
  ) = __$$BudgetCycleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String uid,
    double monthlyIncome,
    String currency,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    DateTime cycleStart,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    DateTime cycleEnd,
    double totalSpent,
    double totalCommitted,
    BudgetCycleStatus status,
  });
}

/// @nodoc
class __$$BudgetCycleImplCopyWithImpl<$Res>
    extends _$BudgetCycleCopyWithImpl<$Res, _$BudgetCycleImpl>
    implements _$$BudgetCycleImplCopyWith<$Res> {
  __$$BudgetCycleImplCopyWithImpl(
    _$BudgetCycleImpl _value,
    $Res Function(_$BudgetCycleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BudgetCycle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? monthlyIncome = null,
    Object? currency = null,
    Object? cycleStart = null,
    Object? cycleEnd = null,
    Object? totalSpent = null,
    Object? totalCommitted = null,
    Object? status = null,
  }) {
    return _then(
      _$BudgetCycleImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        uid: null == uid
            ? _value.uid
            : uid // ignore: cast_nullable_to_non_nullable
                  as String,
        monthlyIncome: null == monthlyIncome
            ? _value.monthlyIncome
            : monthlyIncome // ignore: cast_nullable_to_non_nullable
                  as double,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String,
        cycleStart: null == cycleStart
            ? _value.cycleStart
            : cycleStart // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        cycleEnd: null == cycleEnd
            ? _value.cycleEnd
            : cycleEnd // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        totalSpent: null == totalSpent
            ? _value.totalSpent
            : totalSpent // ignore: cast_nullable_to_non_nullable
                  as double,
        totalCommitted: null == totalCommitted
            ? _value.totalCommitted
            : totalCommitted // ignore: cast_nullable_to_non_nullable
                  as double,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as BudgetCycleStatus,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BudgetCycleImpl extends _BudgetCycle {
  const _$BudgetCycleImpl({
    required this.id,
    required this.uid,
    required this.monthlyIncome,
    this.currency = 'SAR',
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    required this.cycleStart,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    required this.cycleEnd,
    required this.totalSpent,
    required this.totalCommitted,
    required this.status,
  }) : super._();

  factory _$BudgetCycleImpl.fromJson(Map<String, dynamic> json) =>
      _$$BudgetCycleImplFromJson(json);

  @override
  final String id;
  @override
  final String uid;
  @override
  final double monthlyIncome;
  @override
  @JsonKey()
  final String currency;
  @override
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime cycleStart;
  @override
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime cycleEnd;
  @override
  final double totalSpent;
  @override
  final double totalCommitted;
  @override
  final BudgetCycleStatus status;

  @override
  String toString() {
    return 'BudgetCycle(id: $id, uid: $uid, monthlyIncome: $monthlyIncome, currency: $currency, cycleStart: $cycleStart, cycleEnd: $cycleEnd, totalSpent: $totalSpent, totalCommitted: $totalCommitted, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetCycleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.monthlyIncome, monthlyIncome) ||
                other.monthlyIncome == monthlyIncome) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.cycleStart, cycleStart) ||
                other.cycleStart == cycleStart) &&
            (identical(other.cycleEnd, cycleEnd) ||
                other.cycleEnd == cycleEnd) &&
            (identical(other.totalSpent, totalSpent) ||
                other.totalSpent == totalSpent) &&
            (identical(other.totalCommitted, totalCommitted) ||
                other.totalCommitted == totalCommitted) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    uid,
    monthlyIncome,
    currency,
    cycleStart,
    cycleEnd,
    totalSpent,
    totalCommitted,
    status,
  );

  /// Create a copy of BudgetCycle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetCycleImplCopyWith<_$BudgetCycleImpl> get copyWith =>
      __$$BudgetCycleImplCopyWithImpl<_$BudgetCycleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BudgetCycleImplToJson(this);
  }
}

abstract class _BudgetCycle extends BudgetCycle {
  const factory _BudgetCycle({
    required final String id,
    required final String uid,
    required final double monthlyIncome,
    final String currency,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    required final DateTime cycleStart,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    required final DateTime cycleEnd,
    required final double totalSpent,
    required final double totalCommitted,
    required final BudgetCycleStatus status,
  }) = _$BudgetCycleImpl;
  const _BudgetCycle._() : super._();

  factory _BudgetCycle.fromJson(Map<String, dynamic> json) =
      _$BudgetCycleImpl.fromJson;

  @override
  String get id;
  @override
  String get uid;
  @override
  double get monthlyIncome;
  @override
  String get currency;
  @override
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime get cycleStart;
  @override
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime get cycleEnd;
  @override
  double get totalSpent;
  @override
  double get totalCommitted;
  @override
  BudgetCycleStatus get status;

  /// Create a copy of BudgetCycle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BudgetCycleImplCopyWith<_$BudgetCycleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
