// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quran_log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

QuranLog _$QuranLogFromJson(Map<String, dynamic> json) {
  return _QuranLog.fromJson(json);
}

/// @nodoc
mixin _$QuranLog {
  String get id => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  int get pagesRead => throw _privateConstructorUsedError;
  DateTime get loggedAt => throw _privateConstructorUsedError;

  /// Serializes this QuranLog to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuranLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuranLogCopyWith<QuranLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuranLogCopyWith<$Res> {
  factory $QuranLogCopyWith(QuranLog value, $Res Function(QuranLog) then) =
      _$QuranLogCopyWithImpl<$Res, QuranLog>;
  @useResult
  $Res call({String id, String uid, int pagesRead, DateTime loggedAt});
}

/// @nodoc
class _$QuranLogCopyWithImpl<$Res, $Val extends QuranLog>
    implements $QuranLogCopyWith<$Res> {
  _$QuranLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuranLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? pagesRead = null,
    Object? loggedAt = null,
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
            pagesRead: null == pagesRead
                ? _value.pagesRead
                : pagesRead // ignore: cast_nullable_to_non_nullable
                      as int,
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
abstract class _$$QuranLogImplCopyWith<$Res>
    implements $QuranLogCopyWith<$Res> {
  factory _$$QuranLogImplCopyWith(
    _$QuranLogImpl value,
    $Res Function(_$QuranLogImpl) then,
  ) = __$$QuranLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String uid, int pagesRead, DateTime loggedAt});
}

/// @nodoc
class __$$QuranLogImplCopyWithImpl<$Res>
    extends _$QuranLogCopyWithImpl<$Res, _$QuranLogImpl>
    implements _$$QuranLogImplCopyWith<$Res> {
  __$$QuranLogImplCopyWithImpl(
    _$QuranLogImpl _value,
    $Res Function(_$QuranLogImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuranLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? pagesRead = null,
    Object? loggedAt = null,
  }) {
    return _then(
      _$QuranLogImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        uid: null == uid
            ? _value.uid
            : uid // ignore: cast_nullable_to_non_nullable
                  as String,
        pagesRead: null == pagesRead
            ? _value.pagesRead
            : pagesRead // ignore: cast_nullable_to_non_nullable
                  as int,
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
class _$QuranLogImpl implements _QuranLog {
  const _$QuranLogImpl({
    required this.id,
    required this.uid,
    required this.pagesRead,
    required this.loggedAt,
  });

  factory _$QuranLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuranLogImplFromJson(json);

  @override
  final String id;
  @override
  final String uid;
  @override
  final int pagesRead;
  @override
  final DateTime loggedAt;

  @override
  String toString() {
    return 'QuranLog(id: $id, uid: $uid, pagesRead: $pagesRead, loggedAt: $loggedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuranLogImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.pagesRead, pagesRead) ||
                other.pagesRead == pagesRead) &&
            (identical(other.loggedAt, loggedAt) ||
                other.loggedAt == loggedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, uid, pagesRead, loggedAt);

  /// Create a copy of QuranLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuranLogImplCopyWith<_$QuranLogImpl> get copyWith =>
      __$$QuranLogImplCopyWithImpl<_$QuranLogImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuranLogImplToJson(this);
  }
}

abstract class _QuranLog implements QuranLog {
  const factory _QuranLog({
    required final String id,
    required final String uid,
    required final int pagesRead,
    required final DateTime loggedAt,
  }) = _$QuranLogImpl;

  factory _QuranLog.fromJson(Map<String, dynamic> json) =
      _$QuranLogImpl.fromJson;

  @override
  String get id;
  @override
  String get uid;
  @override
  int get pagesRead;
  @override
  DateTime get loggedAt;

  /// Create a copy of QuranLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuranLogImplCopyWith<_$QuranLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
