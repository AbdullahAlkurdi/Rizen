// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dua_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DuaItem _$DuaItemFromJson(Map<String, dynamic> json) {
  return _DuaItem.fromJson(json);
}

/// @nodoc
mixin _$DuaItem {
  String get id => throw _privateConstructorUsedError;
  String get arabicText => throw _privateConstructorUsedError;
  String get transliteration => throw _privateConstructorUsedError;
  String get translationAr => throw _privateConstructorUsedError;
  String get translationEn => throw _privateConstructorUsedError;
  List<String> get occasions => throw _privateConstructorUsedError;

  /// Serializes this DuaItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DuaItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DuaItemCopyWith<DuaItem> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DuaItemCopyWith<$Res> {
  factory $DuaItemCopyWith(DuaItem value, $Res Function(DuaItem) then) =
      _$DuaItemCopyWithImpl<$Res, DuaItem>;
  @useResult
  $Res call({
    String id,
    String arabicText,
    String transliteration,
    String translationAr,
    String translationEn,
    List<String> occasions,
  });
}

/// @nodoc
class _$DuaItemCopyWithImpl<$Res, $Val extends DuaItem>
    implements $DuaItemCopyWith<$Res> {
  _$DuaItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DuaItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? arabicText = null,
    Object? transliteration = null,
    Object? translationAr = null,
    Object? translationEn = null,
    Object? occasions = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            arabicText: null == arabicText
                ? _value.arabicText
                : arabicText // ignore: cast_nullable_to_non_nullable
                      as String,
            transliteration: null == transliteration
                ? _value.transliteration
                : transliteration // ignore: cast_nullable_to_non_nullable
                      as String,
            translationAr: null == translationAr
                ? _value.translationAr
                : translationAr // ignore: cast_nullable_to_non_nullable
                      as String,
            translationEn: null == translationEn
                ? _value.translationEn
                : translationEn // ignore: cast_nullable_to_non_nullable
                      as String,
            occasions: null == occasions
                ? _value.occasions
                : occasions // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DuaItemImplCopyWith<$Res> implements $DuaItemCopyWith<$Res> {
  factory _$$DuaItemImplCopyWith(
    _$DuaItemImpl value,
    $Res Function(_$DuaItemImpl) then,
  ) = __$$DuaItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String arabicText,
    String transliteration,
    String translationAr,
    String translationEn,
    List<String> occasions,
  });
}

/// @nodoc
class __$$DuaItemImplCopyWithImpl<$Res>
    extends _$DuaItemCopyWithImpl<$Res, _$DuaItemImpl>
    implements _$$DuaItemImplCopyWith<$Res> {
  __$$DuaItemImplCopyWithImpl(
    _$DuaItemImpl _value,
    $Res Function(_$DuaItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DuaItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? arabicText = null,
    Object? transliteration = null,
    Object? translationAr = null,
    Object? translationEn = null,
    Object? occasions = null,
  }) {
    return _then(
      _$DuaItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        arabicText: null == arabicText
            ? _value.arabicText
            : arabicText // ignore: cast_nullable_to_non_nullable
                  as String,
        transliteration: null == transliteration
            ? _value.transliteration
            : transliteration // ignore: cast_nullable_to_non_nullable
                  as String,
        translationAr: null == translationAr
            ? _value.translationAr
            : translationAr // ignore: cast_nullable_to_non_nullable
                  as String,
        translationEn: null == translationEn
            ? _value.translationEn
            : translationEn // ignore: cast_nullable_to_non_nullable
                  as String,
        occasions: null == occasions
            ? _value._occasions
            : occasions // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DuaItemImpl implements _DuaItem {
  const _$DuaItemImpl({
    required this.id,
    required this.arabicText,
    required this.transliteration,
    required this.translationAr,
    required this.translationEn,
    required final List<String> occasions,
  }) : _occasions = occasions;

  factory _$DuaItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$DuaItemImplFromJson(json);

  @override
  final String id;
  @override
  final String arabicText;
  @override
  final String transliteration;
  @override
  final String translationAr;
  @override
  final String translationEn;
  final List<String> _occasions;
  @override
  List<String> get occasions {
    if (_occasions is EqualUnmodifiableListView) return _occasions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_occasions);
  }

  @override
  String toString() {
    return 'DuaItem(id: $id, arabicText: $arabicText, transliteration: $transliteration, translationAr: $translationAr, translationEn: $translationEn, occasions: $occasions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DuaItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.arabicText, arabicText) ||
                other.arabicText == arabicText) &&
            (identical(other.transliteration, transliteration) ||
                other.transliteration == transliteration) &&
            (identical(other.translationAr, translationAr) ||
                other.translationAr == translationAr) &&
            (identical(other.translationEn, translationEn) ||
                other.translationEn == translationEn) &&
            const DeepCollectionEquality().equals(
              other._occasions,
              _occasions,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    arabicText,
    transliteration,
    translationAr,
    translationEn,
    const DeepCollectionEquality().hash(_occasions),
  );

  /// Create a copy of DuaItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DuaItemImplCopyWith<_$DuaItemImpl> get copyWith =>
      __$$DuaItemImplCopyWithImpl<_$DuaItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DuaItemImplToJson(this);
  }
}

abstract class _DuaItem implements DuaItem {
  const factory _DuaItem({
    required final String id,
    required final String arabicText,
    required final String transliteration,
    required final String translationAr,
    required final String translationEn,
    required final List<String> occasions,
  }) = _$DuaItemImpl;

  factory _DuaItem.fromJson(Map<String, dynamic> json) = _$DuaItemImpl.fromJson;

  @override
  String get id;
  @override
  String get arabicText;
  @override
  String get transliteration;
  @override
  String get translationAr;
  @override
  String get translationEn;
  @override
  List<String> get occasions;

  /// Create a copy of DuaItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DuaItemImplCopyWith<_$DuaItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
