// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reward_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RewardItem _$RewardItemFromJson(Map<String, dynamic> json) {
  return _RewardItem.fromJson(json);
}

/// @nodoc
mixin _$RewardItem {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get cost => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;
  bool get unlocked => throw _privateConstructorUsedError;

  /// Serializes this RewardItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RewardItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RewardItemCopyWith<RewardItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RewardItemCopyWith<$Res> {
  factory $RewardItemCopyWith(
    RewardItem value,
    $Res Function(RewardItem) then,
  ) = _$RewardItemCopyWithImpl<$Res, RewardItem>;
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    int cost,
    String icon,
    bool unlocked,
  });
}

/// @nodoc
class _$RewardItemCopyWithImpl<$Res, $Val extends RewardItem>
    implements $RewardItemCopyWith<$Res> {
  _$RewardItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RewardItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? cost = null,
    Object? icon = null,
    Object? unlocked = null,
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
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            cost: null == cost
                ? _value.cost
                : cost // ignore: cast_nullable_to_non_nullable
                      as int,
            icon: null == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as String,
            unlocked: null == unlocked
                ? _value.unlocked
                : unlocked // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RewardItemImplCopyWith<$Res>
    implements $RewardItemCopyWith<$Res> {
  factory _$$RewardItemImplCopyWith(
    _$RewardItemImpl value,
    $Res Function(_$RewardItemImpl) then,
  ) = __$$RewardItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    int cost,
    String icon,
    bool unlocked,
  });
}

/// @nodoc
class __$$RewardItemImplCopyWithImpl<$Res>
    extends _$RewardItemCopyWithImpl<$Res, _$RewardItemImpl>
    implements _$$RewardItemImplCopyWith<$Res> {
  __$$RewardItemImplCopyWithImpl(
    _$RewardItemImpl _value,
    $Res Function(_$RewardItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RewardItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? cost = null,
    Object? icon = null,
    Object? unlocked = null,
  }) {
    return _then(
      _$RewardItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        cost: null == cost
            ? _value.cost
            : cost // ignore: cast_nullable_to_non_nullable
                  as int,
        icon: null == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as String,
        unlocked: null == unlocked
            ? _value.unlocked
            : unlocked // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RewardItemImpl implements _RewardItem {
  const _$RewardItemImpl({
    required this.id,
    required this.name,
    required this.description,
    required this.cost,
    required this.icon,
    this.unlocked = false,
  });

  factory _$RewardItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$RewardItemImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final int cost;
  @override
  final String icon;
  @override
  @JsonKey()
  final bool unlocked;

  @override
  String toString() {
    return 'RewardItem(id: $id, name: $name, description: $description, cost: $cost, icon: $icon, unlocked: $unlocked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RewardItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.cost, cost) || other.cost == cost) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.unlocked, unlocked) ||
                other.unlocked == unlocked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, description, cost, icon, unlocked);

  /// Create a copy of RewardItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RewardItemImplCopyWith<_$RewardItemImpl> get copyWith =>
      __$$RewardItemImplCopyWithImpl<_$RewardItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RewardItemImplToJson(this);
  }
}

abstract class _RewardItem implements RewardItem {
  const factory _RewardItem({
    required final String id,
    required final String name,
    required final String description,
    required final int cost,
    required final String icon,
    final bool unlocked,
  }) = _$RewardItemImpl;

  factory _RewardItem.fromJson(Map<String, dynamic> json) =
      _$RewardItemImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  int get cost;
  @override
  String get icon;
  @override
  bool get unlocked;

  /// Create a copy of RewardItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RewardItemImplCopyWith<_$RewardItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
