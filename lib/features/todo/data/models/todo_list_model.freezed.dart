// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TodoListModel _$TodoListModelFromJson(Map<String, dynamic> json) {
  return _TodoListModel.fromJson(json);
}

/// @nodoc
mixin _$TodoListModel {
  String get id => throw _privateConstructorUsedError;
  String get parentId => throw _privateConstructorUsedError;
  String get parentType => throw _privateConstructorUsedError;
  List<TodoItemModel> get items => throw _privateConstructorUsedError;
  int get completionThreshold => throw _privateConstructorUsedError;
  double get completionPct => throw _privateConstructorUsedError;

  /// Serializes this TodoListModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TodoListModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TodoListModelCopyWith<TodoListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoListModelCopyWith<$Res> {
  factory $TodoListModelCopyWith(
    TodoListModel value,
    $Res Function(TodoListModel) then,
  ) = _$TodoListModelCopyWithImpl<$Res, TodoListModel>;
  @useResult
  $Res call({
    String id,
    String parentId,
    String parentType,
    List<TodoItemModel> items,
    int completionThreshold,
    double completionPct,
  });
}

/// @nodoc
class _$TodoListModelCopyWithImpl<$Res, $Val extends TodoListModel>
    implements $TodoListModelCopyWith<$Res> {
  _$TodoListModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TodoListModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? parentId = null,
    Object? parentType = null,
    Object? items = null,
    Object? completionThreshold = null,
    Object? completionPct = null,
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
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<TodoItemModel>,
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
abstract class _$$TodoListModelImplCopyWith<$Res>
    implements $TodoListModelCopyWith<$Res> {
  factory _$$TodoListModelImplCopyWith(
    _$TodoListModelImpl value,
    $Res Function(_$TodoListModelImpl) then,
  ) = __$$TodoListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String parentId,
    String parentType,
    List<TodoItemModel> items,
    int completionThreshold,
    double completionPct,
  });
}

/// @nodoc
class __$$TodoListModelImplCopyWithImpl<$Res>
    extends _$TodoListModelCopyWithImpl<$Res, _$TodoListModelImpl>
    implements _$$TodoListModelImplCopyWith<$Res> {
  __$$TodoListModelImplCopyWithImpl(
    _$TodoListModelImpl _value,
    $Res Function(_$TodoListModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TodoListModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? parentId = null,
    Object? parentType = null,
    Object? items = null,
    Object? completionThreshold = null,
    Object? completionPct = null,
  }) {
    return _then(
      _$TodoListModelImpl(
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
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<TodoItemModel>,
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
class _$TodoListModelImpl extends _TodoListModel {
  const _$TodoListModelImpl({
    required this.id,
    required this.parentId,
    required this.parentType,
    required final List<TodoItemModel> items,
    this.completionThreshold = 70,
    this.completionPct = 0.0,
  }) : _items = items,
       super._();

  factory _$TodoListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TodoListModelImplFromJson(json);

  @override
  final String id;
  @override
  final String parentId;
  @override
  final String parentType;
  final List<TodoItemModel> _items;
  @override
  List<TodoItemModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final int completionThreshold;
  @override
  @JsonKey()
  final double completionPct;

  @override
  String toString() {
    return 'TodoListModel(id: $id, parentId: $parentId, parentType: $parentType, items: $items, completionThreshold: $completionThreshold, completionPct: $completionPct)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoListModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.parentType, parentType) ||
                other.parentType == parentType) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
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
    parentId,
    parentType,
    const DeepCollectionEquality().hash(_items),
    completionThreshold,
    completionPct,
  );

  /// Create a copy of TodoListModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoListModelImplCopyWith<_$TodoListModelImpl> get copyWith =>
      __$$TodoListModelImplCopyWithImpl<_$TodoListModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TodoListModelImplToJson(this);
  }
}

abstract class _TodoListModel extends TodoListModel {
  const factory _TodoListModel({
    required final String id,
    required final String parentId,
    required final String parentType,
    required final List<TodoItemModel> items,
    final int completionThreshold,
    final double completionPct,
  }) = _$TodoListModelImpl;
  const _TodoListModel._() : super._();

  factory _TodoListModel.fromJson(Map<String, dynamic> json) =
      _$TodoListModelImpl.fromJson;

  @override
  String get id;
  @override
  String get parentId;
  @override
  String get parentType;
  @override
  List<TodoItemModel> get items;
  @override
  int get completionThreshold;
  @override
  double get completionPct;

  /// Create a copy of TodoListModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TodoListModelImplCopyWith<_$TodoListModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
