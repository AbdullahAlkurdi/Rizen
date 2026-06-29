// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voice_parse_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

VoiceParseResult _$VoiceParseResultFromJson(Map<String, dynamic> json) {
  return _VoiceParseResult.fromJson(json);
}

/// @nodoc
mixin _$VoiceParseResult {
  List<DomainLogEntry> get domainLogs => throw _privateConstructorUsedError;
  List<String> get habitsCompleted => throw _privateConstructorUsedError;
  List<String> get habitsMissed => throw _privateConstructorUsedError;
  List<String> get todoChecked => throw _privateConstructorUsedError;
  List<String> get todoUnchecked => throw _privateConstructorUsedError;
  String? get reflection => throw _privateConstructorUsedError;
  String? get sleepNote => throw _privateConstructorUsedError;
  String get rawTranscript => throw _privateConstructorUsedError;
  bool get parseSuccess => throw _privateConstructorUsedError;
  String? get parseError => throw _privateConstructorUsedError;

  /// Serializes this VoiceParseResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VoiceParseResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VoiceParseResultCopyWith<VoiceParseResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoiceParseResultCopyWith<$Res> {
  factory $VoiceParseResultCopyWith(
    VoiceParseResult value,
    $Res Function(VoiceParseResult) then,
  ) = _$VoiceParseResultCopyWithImpl<$Res, VoiceParseResult>;
  @useResult
  $Res call({
    List<DomainLogEntry> domainLogs,
    List<String> habitsCompleted,
    List<String> habitsMissed,
    List<String> todoChecked,
    List<String> todoUnchecked,
    String? reflection,
    String? sleepNote,
    String rawTranscript,
    bool parseSuccess,
    String? parseError,
  });
}

/// @nodoc
class _$VoiceParseResultCopyWithImpl<$Res, $Val extends VoiceParseResult>
    implements $VoiceParseResultCopyWith<$Res> {
  _$VoiceParseResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VoiceParseResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? domainLogs = null,
    Object? habitsCompleted = null,
    Object? habitsMissed = null,
    Object? todoChecked = null,
    Object? todoUnchecked = null,
    Object? reflection = freezed,
    Object? sleepNote = freezed,
    Object? rawTranscript = null,
    Object? parseSuccess = null,
    Object? parseError = freezed,
  }) {
    return _then(
      _value.copyWith(
            domainLogs: null == domainLogs
                ? _value.domainLogs
                : domainLogs // ignore: cast_nullable_to_non_nullable
                      as List<DomainLogEntry>,
            habitsCompleted: null == habitsCompleted
                ? _value.habitsCompleted
                : habitsCompleted // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            habitsMissed: null == habitsMissed
                ? _value.habitsMissed
                : habitsMissed // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            todoChecked: null == todoChecked
                ? _value.todoChecked
                : todoChecked // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            todoUnchecked: null == todoUnchecked
                ? _value.todoUnchecked
                : todoUnchecked // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            reflection: freezed == reflection
                ? _value.reflection
                : reflection // ignore: cast_nullable_to_non_nullable
                      as String?,
            sleepNote: freezed == sleepNote
                ? _value.sleepNote
                : sleepNote // ignore: cast_nullable_to_non_nullable
                      as String?,
            rawTranscript: null == rawTranscript
                ? _value.rawTranscript
                : rawTranscript // ignore: cast_nullable_to_non_nullable
                      as String,
            parseSuccess: null == parseSuccess
                ? _value.parseSuccess
                : parseSuccess // ignore: cast_nullable_to_non_nullable
                      as bool,
            parseError: freezed == parseError
                ? _value.parseError
                : parseError // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VoiceParseResultImplCopyWith<$Res>
    implements $VoiceParseResultCopyWith<$Res> {
  factory _$$VoiceParseResultImplCopyWith(
    _$VoiceParseResultImpl value,
    $Res Function(_$VoiceParseResultImpl) then,
  ) = __$$VoiceParseResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<DomainLogEntry> domainLogs,
    List<String> habitsCompleted,
    List<String> habitsMissed,
    List<String> todoChecked,
    List<String> todoUnchecked,
    String? reflection,
    String? sleepNote,
    String rawTranscript,
    bool parseSuccess,
    String? parseError,
  });
}

/// @nodoc
class __$$VoiceParseResultImplCopyWithImpl<$Res>
    extends _$VoiceParseResultCopyWithImpl<$Res, _$VoiceParseResultImpl>
    implements _$$VoiceParseResultImplCopyWith<$Res> {
  __$$VoiceParseResultImplCopyWithImpl(
    _$VoiceParseResultImpl _value,
    $Res Function(_$VoiceParseResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VoiceParseResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? domainLogs = null,
    Object? habitsCompleted = null,
    Object? habitsMissed = null,
    Object? todoChecked = null,
    Object? todoUnchecked = null,
    Object? reflection = freezed,
    Object? sleepNote = freezed,
    Object? rawTranscript = null,
    Object? parseSuccess = null,
    Object? parseError = freezed,
  }) {
    return _then(
      _$VoiceParseResultImpl(
        domainLogs: null == domainLogs
            ? _value._domainLogs
            : domainLogs // ignore: cast_nullable_to_non_nullable
                  as List<DomainLogEntry>,
        habitsCompleted: null == habitsCompleted
            ? _value._habitsCompleted
            : habitsCompleted // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        habitsMissed: null == habitsMissed
            ? _value._habitsMissed
            : habitsMissed // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        todoChecked: null == todoChecked
            ? _value._todoChecked
            : todoChecked // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        todoUnchecked: null == todoUnchecked
            ? _value._todoUnchecked
            : todoUnchecked // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        reflection: freezed == reflection
            ? _value.reflection
            : reflection // ignore: cast_nullable_to_non_nullable
                  as String?,
        sleepNote: freezed == sleepNote
            ? _value.sleepNote
            : sleepNote // ignore: cast_nullable_to_non_nullable
                  as String?,
        rawTranscript: null == rawTranscript
            ? _value.rawTranscript
            : rawTranscript // ignore: cast_nullable_to_non_nullable
                  as String,
        parseSuccess: null == parseSuccess
            ? _value.parseSuccess
            : parseSuccess // ignore: cast_nullable_to_non_nullable
                  as bool,
        parseError: freezed == parseError
            ? _value.parseError
            : parseError // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VoiceParseResultImpl implements _VoiceParseResult {
  const _$VoiceParseResultImpl({
    required final List<DomainLogEntry> domainLogs,
    required final List<String> habitsCompleted,
    required final List<String> habitsMissed,
    required final List<String> todoChecked,
    required final List<String> todoUnchecked,
    required this.reflection,
    required this.sleepNote,
    required this.rawTranscript,
    required this.parseSuccess,
    this.parseError,
  }) : _domainLogs = domainLogs,
       _habitsCompleted = habitsCompleted,
       _habitsMissed = habitsMissed,
       _todoChecked = todoChecked,
       _todoUnchecked = todoUnchecked;

  factory _$VoiceParseResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoiceParseResultImplFromJson(json);

  final List<DomainLogEntry> _domainLogs;
  @override
  List<DomainLogEntry> get domainLogs {
    if (_domainLogs is EqualUnmodifiableListView) return _domainLogs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_domainLogs);
  }

  final List<String> _habitsCompleted;
  @override
  List<String> get habitsCompleted {
    if (_habitsCompleted is EqualUnmodifiableListView) return _habitsCompleted;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_habitsCompleted);
  }

  final List<String> _habitsMissed;
  @override
  List<String> get habitsMissed {
    if (_habitsMissed is EqualUnmodifiableListView) return _habitsMissed;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_habitsMissed);
  }

  final List<String> _todoChecked;
  @override
  List<String> get todoChecked {
    if (_todoChecked is EqualUnmodifiableListView) return _todoChecked;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todoChecked);
  }

  final List<String> _todoUnchecked;
  @override
  List<String> get todoUnchecked {
    if (_todoUnchecked is EqualUnmodifiableListView) return _todoUnchecked;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todoUnchecked);
  }

  @override
  final String? reflection;
  @override
  final String? sleepNote;
  @override
  final String rawTranscript;
  @override
  final bool parseSuccess;
  @override
  final String? parseError;

  @override
  String toString() {
    return 'VoiceParseResult(domainLogs: $domainLogs, habitsCompleted: $habitsCompleted, habitsMissed: $habitsMissed, todoChecked: $todoChecked, todoUnchecked: $todoUnchecked, reflection: $reflection, sleepNote: $sleepNote, rawTranscript: $rawTranscript, parseSuccess: $parseSuccess, parseError: $parseError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoiceParseResultImpl &&
            const DeepCollectionEquality().equals(
              other._domainLogs,
              _domainLogs,
            ) &&
            const DeepCollectionEquality().equals(
              other._habitsCompleted,
              _habitsCompleted,
            ) &&
            const DeepCollectionEquality().equals(
              other._habitsMissed,
              _habitsMissed,
            ) &&
            const DeepCollectionEquality().equals(
              other._todoChecked,
              _todoChecked,
            ) &&
            const DeepCollectionEquality().equals(
              other._todoUnchecked,
              _todoUnchecked,
            ) &&
            (identical(other.reflection, reflection) ||
                other.reflection == reflection) &&
            (identical(other.sleepNote, sleepNote) ||
                other.sleepNote == sleepNote) &&
            (identical(other.rawTranscript, rawTranscript) ||
                other.rawTranscript == rawTranscript) &&
            (identical(other.parseSuccess, parseSuccess) ||
                other.parseSuccess == parseSuccess) &&
            (identical(other.parseError, parseError) ||
                other.parseError == parseError));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_domainLogs),
    const DeepCollectionEquality().hash(_habitsCompleted),
    const DeepCollectionEquality().hash(_habitsMissed),
    const DeepCollectionEquality().hash(_todoChecked),
    const DeepCollectionEquality().hash(_todoUnchecked),
    reflection,
    sleepNote,
    rawTranscript,
    parseSuccess,
    parseError,
  );

  /// Create a copy of VoiceParseResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VoiceParseResultImplCopyWith<_$VoiceParseResultImpl> get copyWith =>
      __$$VoiceParseResultImplCopyWithImpl<_$VoiceParseResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$VoiceParseResultImplToJson(this);
  }
}

abstract class _VoiceParseResult implements VoiceParseResult {
  const factory _VoiceParseResult({
    required final List<DomainLogEntry> domainLogs,
    required final List<String> habitsCompleted,
    required final List<String> habitsMissed,
    required final List<String> todoChecked,
    required final List<String> todoUnchecked,
    required final String? reflection,
    required final String? sleepNote,
    required final String rawTranscript,
    required final bool parseSuccess,
    final String? parseError,
  }) = _$VoiceParseResultImpl;

  factory _VoiceParseResult.fromJson(Map<String, dynamic> json) =
      _$VoiceParseResultImpl.fromJson;

  @override
  List<DomainLogEntry> get domainLogs;
  @override
  List<String> get habitsCompleted;
  @override
  List<String> get habitsMissed;
  @override
  List<String> get todoChecked;
  @override
  List<String> get todoUnchecked;
  @override
  String? get reflection;
  @override
  String? get sleepNote;
  @override
  String get rawTranscript;
  @override
  bool get parseSuccess;
  @override
  String? get parseError;

  /// Create a copy of VoiceParseResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VoiceParseResultImplCopyWith<_$VoiceParseResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DomainLogEntry _$DomainLogEntryFromJson(Map<String, dynamic> json) {
  return _DomainLogEntry.fromJson(json);
}

/// @nodoc
mixin _$DomainLogEntry {
  String get domain => throw _privateConstructorUsedError;
  int? get durationMinutes => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this DomainLogEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DomainLogEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DomainLogEntryCopyWith<DomainLogEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DomainLogEntryCopyWith<$Res> {
  factory $DomainLogEntryCopyWith(
    DomainLogEntry value,
    $Res Function(DomainLogEntry) then,
  ) = _$DomainLogEntryCopyWithImpl<$Res, DomainLogEntry>;
  @useResult
  $Res call({String domain, int? durationMinutes, String? notes});
}

/// @nodoc
class _$DomainLogEntryCopyWithImpl<$Res, $Val extends DomainLogEntry>
    implements $DomainLogEntryCopyWith<$Res> {
  _$DomainLogEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DomainLogEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? domain = null,
    Object? durationMinutes = freezed,
    Object? notes = freezed,
  }) {
    return _then(
      _value.copyWith(
            domain: null == domain
                ? _value.domain
                : domain // ignore: cast_nullable_to_non_nullable
                      as String,
            durationMinutes: freezed == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                      as int?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DomainLogEntryImplCopyWith<$Res>
    implements $DomainLogEntryCopyWith<$Res> {
  factory _$$DomainLogEntryImplCopyWith(
    _$DomainLogEntryImpl value,
    $Res Function(_$DomainLogEntryImpl) then,
  ) = __$$DomainLogEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String domain, int? durationMinutes, String? notes});
}

/// @nodoc
class __$$DomainLogEntryImplCopyWithImpl<$Res>
    extends _$DomainLogEntryCopyWithImpl<$Res, _$DomainLogEntryImpl>
    implements _$$DomainLogEntryImplCopyWith<$Res> {
  __$$DomainLogEntryImplCopyWithImpl(
    _$DomainLogEntryImpl _value,
    $Res Function(_$DomainLogEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DomainLogEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? domain = null,
    Object? durationMinutes = freezed,
    Object? notes = freezed,
  }) {
    return _then(
      _$DomainLogEntryImpl(
        domain: null == domain
            ? _value.domain
            : domain // ignore: cast_nullable_to_non_nullable
                  as String,
        durationMinutes: freezed == durationMinutes
            ? _value.durationMinutes
            : durationMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DomainLogEntryImpl implements _DomainLogEntry {
  const _$DomainLogEntryImpl({
    required this.domain,
    this.durationMinutes,
    this.notes,
  });

  factory _$DomainLogEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$DomainLogEntryImplFromJson(json);

  @override
  final String domain;
  @override
  final int? durationMinutes;
  @override
  final String? notes;

  @override
  String toString() {
    return 'DomainLogEntry(domain: $domain, durationMinutes: $durationMinutes, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DomainLogEntryImpl &&
            (identical(other.domain, domain) || other.domain == domain) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, domain, durationMinutes, notes);

  /// Create a copy of DomainLogEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DomainLogEntryImplCopyWith<_$DomainLogEntryImpl> get copyWith =>
      __$$DomainLogEntryImplCopyWithImpl<_$DomainLogEntryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DomainLogEntryImplToJson(this);
  }
}

abstract class _DomainLogEntry implements DomainLogEntry {
  const factory _DomainLogEntry({
    required final String domain,
    final int? durationMinutes,
    final String? notes,
  }) = _$DomainLogEntryImpl;

  factory _DomainLogEntry.fromJson(Map<String, dynamic> json) =
      _$DomainLogEntryImpl.fromJson;

  @override
  String get domain;
  @override
  int? get durationMinutes;
  @override
  String? get notes;

  /// Create a copy of DomainLogEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DomainLogEntryImplCopyWith<_$DomainLogEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
