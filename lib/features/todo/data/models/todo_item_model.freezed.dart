// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TodoItemModel _$TodoItemModelFromJson(Map<String, dynamic> json) {
  return _TodoItemModel.fromJson(json);
}

/// @nodoc
mixin _$TodoItemModel {
  String get id => throw _privateConstructorUsedError;
  String get parentId => throw _privateConstructorUsedError;
  String get parentType => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;
  bool get isRequired => throw _privateConstructorUsedError;
  double get weight => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  String? get date => throw _privateConstructorUsedError;

  /// Serializes this TodoItemModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TodoItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TodoItemModelCopyWith<TodoItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoItemModelCopyWith<$Res> {
  factory $TodoItemModelCopyWith(
    TodoItemModel value,
    $Res Function(TodoItemModel) then,
  ) = _$TodoItemModelCopyWithImpl<$Res, TodoItemModel>;
  @useResult
  $Res call({
    String id,
    String parentId,
    String parentType,
    String title,
    int order,
    bool isRequired,
    double weight,
    bool isCompleted,
    DateTime? completedAt,
    String? note,
    String? date,
  });
}

/// @nodoc
class _$TodoItemModelCopyWithImpl<$Res, $Val extends TodoItemModel>
    implements $TodoItemModelCopyWith<$Res> {
  _$TodoItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TodoItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? parentId = null,
    Object? parentType = null,
    Object? title = null,
    Object? order = null,
    Object? isRequired = null,
    Object? weight = null,
    Object? isCompleted = null,
    Object? completedAt = freezed,
    Object? note = freezed,
    Object? date = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            parentId: null == parentId
                ? _value.parentId
                : parentId // ignore: cast_nullable_to_non_nullable
                      as String,
            parentType: null == parentType
                ? _value.parentType
                : parentType // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            order: null == order
                ? _value.order
                : order // ignore: cast_nullable_to_non_nullable
                      as int,
            isRequired: null == isRequired
                ? _value.isRequired
                : isRequired // ignore: cast_nullable_to_non_nullable
                      as bool,
            weight: null == weight
                ? _value.weight
                : weight // ignore: cast_nullable_to_non_nullable
                      as double,
            isCompleted: null == isCompleted
                ? _value.isCompleted
                : isCompleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            note: freezed == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                      as String?,
            date: freezed == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TodoItemModelImplCopyWith<$Res>
    implements $TodoItemModelCopyWith<$Res> {
  factory _$$TodoItemModelImplCopyWith(
    _$TodoItemModelImpl value,
    $Res Function(_$TodoItemModelImpl) then,
  ) = __$$TodoItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String parentId,
    String parentType,
    String title,
    int order,
    bool isRequired,
    double weight,
    bool isCompleted,
    DateTime? completedAt,
    String? note,
    String? date,
  });
}

/// @nodoc
class __$$TodoItemModelImplCopyWithImpl<$Res>
    extends _$TodoItemModelCopyWithImpl<$Res, _$TodoItemModelImpl>
    implements _$$TodoItemModelImplCopyWith<$Res> {
  __$$TodoItemModelImplCopyWithImpl(
    _$TodoItemModelImpl _value,
    $Res Function(_$TodoItemModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TodoItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? parentId = null,
    Object? parentType = null,
    Object? title = null,
    Object? order = null,
    Object? isRequired = null,
    Object? weight = null,
    Object? isCompleted = null,
    Object? completedAt = freezed,
    Object? note = freezed,
    Object? date = freezed,
  }) {
    return _then(
      _$TodoItemModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        parentId: null == parentId
            ? _value.parentId
            : parentId // ignore: cast_nullable_to_non_nullable
                  as String,
        parentType: null == parentType
            ? _value.parentType
            : parentType // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        order: null == order
            ? _value.order
            : order // ignore: cast_nullable_to_non_nullable
                  as int,
        isRequired: null == isRequired
            ? _value.isRequired
            : isRequired // ignore: cast_nullable_to_non_nullable
                  as bool,
        weight: null == weight
            ? _value.weight
            : weight // ignore: cast_nullable_to_non_nullable
                  as double,
        isCompleted: null == isCompleted
            ? _value.isCompleted
            : isCompleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        note: freezed == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String?,
        date: freezed == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TodoItemModelImpl extends _TodoItemModel {
  const _$TodoItemModelImpl({
    required this.id,
    required this.parentId,
    required this.parentType,
    required this.title,
    required this.order,
    this.isRequired = true,
    this.weight = 1.0,
    this.isCompleted = false,
    this.completedAt,
    this.note,
    this.date,
  }) : super._();

  factory _$TodoItemModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TodoItemModelImplFromJson(json);

  @override
  final String id;
  @override
  final String parentId;
  @override
  final String parentType;
  @override
  final String title;
  @override
  final int order;
  @override
  @JsonKey()
  final bool isRequired;
  @override
  @JsonKey()
  final double weight;
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  final DateTime? completedAt;
  @override
  final String? note;
  @override
  final String? date;

  @override
  String toString() {
    return 'TodoItemModel(id: $id, parentId: $parentId, parentType: $parentType, title: $title, order: $order, isRequired: $isRequired, weight: $weight, isCompleted: $isCompleted, completedAt: $completedAt, note: $note, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoItemModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.parentType, parentType) ||
                other.parentType == parentType) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.isRequired, isRequired) ||
                other.isRequired == isRequired) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    parentId,
    parentType,
    title,
    order,
    isRequired,
    weight,
    isCompleted,
    completedAt,
    note,
    date,
  );

  /// Create a copy of TodoItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoItemModelImplCopyWith<_$TodoItemModelImpl> get copyWith =>
      __$$TodoItemModelImplCopyWithImpl<_$TodoItemModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TodoItemModelImplToJson(this);
  }
}

abstract class _TodoItemModel extends TodoItemModel {
  const factory _TodoItemModel({
    required final String id,
    required final String parentId,
    required final String parentType,
    required final String title,
    required final int order,
    final bool isRequired,
    final double weight,
    final bool isCompleted,
    final DateTime? completedAt,
    final String? note,
    final String? date,
  }) = _$TodoItemModelImpl;
  const _TodoItemModel._() : super._();

  factory _TodoItemModel.fromJson(Map<String, dynamic> json) =
      _$TodoItemModelImpl.fromJson;

  @override
  String get id;
  @override
  String get parentId;
  @override
  String get parentType;
  @override
  String get title;
  @override
  int get order;
  @override
  bool get isRequired;
  @override
  double get weight;
  @override
  bool get isCompleted;
  @override
  DateTime? get completedAt;
  @override
  String? get note;
  @override
  String? get date;

  /// Create a copy of TodoItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TodoItemModelImplCopyWith<_$TodoItemModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
