// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coach_message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CoachMessage _$CoachMessageFromJson(Map<String, dynamic> json) {
  return _CoachMessage.fromJson(json);
}

/// @nodoc
mixin _$CoachMessage {
  String get id => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  CoachRole get role => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime get timestamp => throw _privateConstructorUsedError;
  String get sessionId => throw _privateConstructorUsedError;

  /// Serializes this CoachMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CoachMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CoachMessageCopyWith<CoachMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoachMessageCopyWith<$Res> {
  factory $CoachMessageCopyWith(
    CoachMessage value,
    $Res Function(CoachMessage) then,
  ) = _$CoachMessageCopyWithImpl<$Res, CoachMessage>;
  @useResult
  $Res call({
    String id,
    String uid,
    String content,
    CoachRole role,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    DateTime timestamp,
    String sessionId,
  });
}

/// @nodoc
class _$CoachMessageCopyWithImpl<$Res, $Val extends CoachMessage>
    implements $CoachMessageCopyWith<$Res> {
  _$CoachMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CoachMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? content = null,
    Object? role = null,
    Object? timestamp = null,
    Object? sessionId = null,
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
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as CoachRole,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            sessionId: null == sessionId
                ? _value.sessionId
                : sessionId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CoachMessageImplCopyWith<$Res>
    implements $CoachMessageCopyWith<$Res> {
  factory _$$CoachMessageImplCopyWith(
    _$CoachMessageImpl value,
    $Res Function(_$CoachMessageImpl) then,
  ) = __$$CoachMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String uid,
    String content,
    CoachRole role,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    DateTime timestamp,
    String sessionId,
  });
}

/// @nodoc
class __$$CoachMessageImplCopyWithImpl<$Res>
    extends _$CoachMessageCopyWithImpl<$Res, _$CoachMessageImpl>
    implements _$$CoachMessageImplCopyWith<$Res> {
  __$$CoachMessageImplCopyWithImpl(
    _$CoachMessageImpl _value,
    $Res Function(_$CoachMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CoachMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? content = null,
    Object? role = null,
    Object? timestamp = null,
    Object? sessionId = null,
  }) {
    return _then(
      _$CoachMessageImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        uid: null == uid
            ? _value.uid
            : uid // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as CoachRole,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        sessionId: null == sessionId
            ? _value.sessionId
            : sessionId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CoachMessageImpl extends _CoachMessage {
  const _$CoachMessageImpl({
    required this.id,
    required this.uid,
    required this.content,
    required this.role,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    required this.timestamp,
    required this.sessionId,
  }) : super._();

  factory _$CoachMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$CoachMessageImplFromJson(json);

  @override
  final String id;
  @override
  final String uid;
  @override
  final String content;
  @override
  final CoachRole role;
  @override
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime timestamp;
  @override
  final String sessionId;

  @override
  String toString() {
    return 'CoachMessage(id: $id, uid: $uid, content: $content, role: $role, timestamp: $timestamp, sessionId: $sessionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoachMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, uid, content, role, timestamp, sessionId);

  /// Create a copy of CoachMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CoachMessageImplCopyWith<_$CoachMessageImpl> get copyWith =>
      __$$CoachMessageImplCopyWithImpl<_$CoachMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CoachMessageImplToJson(this);
  }
}

abstract class _CoachMessage extends CoachMessage {
  const factory _CoachMessage({
    required final String id,
    required final String uid,
    required final String content,
    required final CoachRole role,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    required final DateTime timestamp,
    required final String sessionId,
  }) = _$CoachMessageImpl;
  const _CoachMessage._() : super._();

  factory _CoachMessage.fromJson(Map<String, dynamic> json) =
      _$CoachMessageImpl.fromJson;

  @override
  String get id;
  @override
  String get uid;
  @override
  String get content;
  @override
  CoachRole get role;
  @override
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime get timestamp;
  @override
  String get sessionId;

  /// Create a copy of CoachMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CoachMessageImplCopyWith<_$CoachMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
