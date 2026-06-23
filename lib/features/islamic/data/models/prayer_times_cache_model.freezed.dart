// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prayer_times_cache_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

HijriDate _$HijriDateFromJson(Map<String, dynamic> json) {
  return _HijriDate.fromJson(json);
}

/// @nodoc
mixin _$HijriDate {
  int get day => throw _privateConstructorUsedError;
  int get month => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  String get monthNameAr => throw _privateConstructorUsedError;
  String get monthNameEn => throw _privateConstructorUsedError;

  /// Serializes this HijriDate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HijriDate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HijriDateCopyWith<HijriDate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HijriDateCopyWith<$Res> {
  factory $HijriDateCopyWith(HijriDate value, $Res Function(HijriDate) then) =
      _$HijriDateCopyWithImpl<$Res, HijriDate>;
  @useResult
  $Res call({
    int day,
    int month,
    int year,
    String monthNameAr,
    String monthNameEn,
  });
}

/// @nodoc
class _$HijriDateCopyWithImpl<$Res, $Val extends HijriDate>
    implements $HijriDateCopyWith<$Res> {
  _$HijriDateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HijriDate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? month = null,
    Object? year = null,
    Object? monthNameAr = null,
    Object? monthNameEn = null,
  }) {
    return _then(
      _value.copyWith(
            day: null == day
                ? _value.day
                : day // ignore: cast_nullable_to_non_nullable
                      as int,
            month: null == month
                ? _value.month
                : month // ignore: cast_nullable_to_non_nullable
                      as int,
            year: null == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int,
            monthNameAr: null == monthNameAr
                ? _value.monthNameAr
                : monthNameAr // ignore: cast_nullable_to_non_nullable
                      as String,
            monthNameEn: null == monthNameEn
                ? _value.monthNameEn
                : monthNameEn // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HijriDateImplCopyWith<$Res>
    implements $HijriDateCopyWith<$Res> {
  factory _$$HijriDateImplCopyWith(
    _$HijriDateImpl value,
    $Res Function(_$HijriDateImpl) then,
  ) = __$$HijriDateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int day,
    int month,
    int year,
    String monthNameAr,
    String monthNameEn,
  });
}

/// @nodoc
class __$$HijriDateImplCopyWithImpl<$Res>
    extends _$HijriDateCopyWithImpl<$Res, _$HijriDateImpl>
    implements _$$HijriDateImplCopyWith<$Res> {
  __$$HijriDateImplCopyWithImpl(
    _$HijriDateImpl _value,
    $Res Function(_$HijriDateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HijriDate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? month = null,
    Object? year = null,
    Object? monthNameAr = null,
    Object? monthNameEn = null,
  }) {
    return _then(
      _$HijriDateImpl(
        day: null == day
            ? _value.day
            : day // ignore: cast_nullable_to_non_nullable
                  as int,
        month: null == month
            ? _value.month
            : month // ignore: cast_nullable_to_non_nullable
                  as int,
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int,
        monthNameAr: null == monthNameAr
            ? _value.monthNameAr
            : monthNameAr // ignore: cast_nullable_to_non_nullable
                  as String,
        monthNameEn: null == monthNameEn
            ? _value.monthNameEn
            : monthNameEn // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HijriDateImpl implements _HijriDate {
  const _$HijriDateImpl({
    required this.day,
    required this.month,
    required this.year,
    required this.monthNameAr,
    required this.monthNameEn,
  });

  factory _$HijriDateImpl.fromJson(Map<String, dynamic> json) =>
      _$$HijriDateImplFromJson(json);

  @override
  final int day;
  @override
  final int month;
  @override
  final int year;
  @override
  final String monthNameAr;
  @override
  final String monthNameEn;

  @override
  String toString() {
    return 'HijriDate(day: $day, month: $month, year: $year, monthNameAr: $monthNameAr, monthNameEn: $monthNameEn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HijriDateImpl &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.monthNameAr, monthNameAr) ||
                other.monthNameAr == monthNameAr) &&
            (identical(other.monthNameEn, monthNameEn) ||
                other.monthNameEn == monthNameEn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, day, month, year, monthNameAr, monthNameEn);

  /// Create a copy of HijriDate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HijriDateImplCopyWith<_$HijriDateImpl> get copyWith =>
      __$$HijriDateImplCopyWithImpl<_$HijriDateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HijriDateImplToJson(this);
  }
}

abstract class _HijriDate implements HijriDate {
  const factory _HijriDate({
    required final int day,
    required final int month,
    required final int year,
    required final String monthNameAr,
    required final String monthNameEn,
  }) = _$HijriDateImpl;

  factory _HijriDate.fromJson(Map<String, dynamic> json) =
      _$HijriDateImpl.fromJson;

  @override
  int get day;
  @override
  int get month;
  @override
  int get year;
  @override
  String get monthNameAr;
  @override
  String get monthNameEn;

  /// Create a copy of HijriDate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HijriDateImplCopyWith<_$HijriDateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Timings _$TimingsFromJson(Map<String, dynamic> json) {
  return _Timings.fromJson(json);
}

/// @nodoc
mixin _$Timings {
  String get Fajr => throw _privateConstructorUsedError;
  String get Sunrise => throw _privateConstructorUsedError;
  String get Dhuhr => throw _privateConstructorUsedError;
  String get Asr => throw _privateConstructorUsedError;
  String get Maghrib => throw _privateConstructorUsedError;
  String get Isha => throw _privateConstructorUsedError;

  /// Serializes this Timings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Timings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimingsCopyWith<Timings> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimingsCopyWith<$Res> {
  factory $TimingsCopyWith(Timings value, $Res Function(Timings) then) =
      _$TimingsCopyWithImpl<$Res, Timings>;
  @useResult
  $Res call({
    String Fajr,
    String Sunrise,
    String Dhuhr,
    String Asr,
    String Maghrib,
    String Isha,
  });
}

/// @nodoc
class _$TimingsCopyWithImpl<$Res, $Val extends Timings>
    implements $TimingsCopyWith<$Res> {
  _$TimingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Timings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? Fajr = null,
    Object? Sunrise = null,
    Object? Dhuhr = null,
    Object? Asr = null,
    Object? Maghrib = null,
    Object? Isha = null,
  }) {
    return _then(
      _value.copyWith(
            Fajr: null == Fajr
                ? _value.Fajr
                : Fajr // ignore: cast_nullable_to_non_nullable
                      as String,
            Sunrise: null == Sunrise
                ? _value.Sunrise
                : Sunrise // ignore: cast_nullable_to_non_nullable
                      as String,
            Dhuhr: null == Dhuhr
                ? _value.Dhuhr
                : Dhuhr // ignore: cast_nullable_to_non_nullable
                      as String,
            Asr: null == Asr
                ? _value.Asr
                : Asr // ignore: cast_nullable_to_non_nullable
                      as String,
            Maghrib: null == Maghrib
                ? _value.Maghrib
                : Maghrib // ignore: cast_nullable_to_non_nullable
                      as String,
            Isha: null == Isha
                ? _value.Isha
                : Isha // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TimingsImplCopyWith<$Res> implements $TimingsCopyWith<$Res> {
  factory _$$TimingsImplCopyWith(
    _$TimingsImpl value,
    $Res Function(_$TimingsImpl) then,
  ) = __$$TimingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String Fajr,
    String Sunrise,
    String Dhuhr,
    String Asr,
    String Maghrib,
    String Isha,
  });
}

/// @nodoc
class __$$TimingsImplCopyWithImpl<$Res>
    extends _$TimingsCopyWithImpl<$Res, _$TimingsImpl>
    implements _$$TimingsImplCopyWith<$Res> {
  __$$TimingsImplCopyWithImpl(
    _$TimingsImpl _value,
    $Res Function(_$TimingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Timings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? Fajr = null,
    Object? Sunrise = null,
    Object? Dhuhr = null,
    Object? Asr = null,
    Object? Maghrib = null,
    Object? Isha = null,
  }) {
    return _then(
      _$TimingsImpl(
        Fajr: null == Fajr
            ? _value.Fajr
            : Fajr // ignore: cast_nullable_to_non_nullable
                  as String,
        Sunrise: null == Sunrise
            ? _value.Sunrise
            : Sunrise // ignore: cast_nullable_to_non_nullable
                  as String,
        Dhuhr: null == Dhuhr
            ? _value.Dhuhr
            : Dhuhr // ignore: cast_nullable_to_non_nullable
                  as String,
        Asr: null == Asr
            ? _value.Asr
            : Asr // ignore: cast_nullable_to_non_nullable
                  as String,
        Maghrib: null == Maghrib
            ? _value.Maghrib
            : Maghrib // ignore: cast_nullable_to_non_nullable
                  as String,
        Isha: null == Isha
            ? _value.Isha
            : Isha // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TimingsImpl implements _Timings {
  const _$TimingsImpl({
    required this.Fajr,
    required this.Sunrise,
    required this.Dhuhr,
    required this.Asr,
    required this.Maghrib,
    required this.Isha,
  });

  factory _$TimingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimingsImplFromJson(json);

  @override
  final String Fajr;
  @override
  final String Sunrise;
  @override
  final String Dhuhr;
  @override
  final String Asr;
  @override
  final String Maghrib;
  @override
  final String Isha;

  @override
  String toString() {
    return 'Timings(Fajr: $Fajr, Sunrise: $Sunrise, Dhuhr: $Dhuhr, Asr: $Asr, Maghrib: $Maghrib, Isha: $Isha)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimingsImpl &&
            (identical(other.Fajr, Fajr) || other.Fajr == Fajr) &&
            (identical(other.Sunrise, Sunrise) || other.Sunrise == Sunrise) &&
            (identical(other.Dhuhr, Dhuhr) || other.Dhuhr == Dhuhr) &&
            (identical(other.Asr, Asr) || other.Asr == Asr) &&
            (identical(other.Maghrib, Maghrib) || other.Maghrib == Maghrib) &&
            (identical(other.Isha, Isha) || other.Isha == Isha));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, Fajr, Sunrise, Dhuhr, Asr, Maghrib, Isha);

  /// Create a copy of Timings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimingsImplCopyWith<_$TimingsImpl> get copyWith =>
      __$$TimingsImplCopyWithImpl<_$TimingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimingsImplToJson(this);
  }
}

abstract class _Timings implements Timings {
  const factory _Timings({
    required final String Fajr,
    required final String Sunrise,
    required final String Dhuhr,
    required final String Asr,
    required final String Maghrib,
    required final String Isha,
  }) = _$TimingsImpl;

  factory _Timings.fromJson(Map<String, dynamic> json) = _$TimingsImpl.fromJson;

  @override
  String get Fajr;
  @override
  String get Sunrise;
  @override
  String get Dhuhr;
  @override
  String get Asr;
  @override
  String get Maghrib;
  @override
  String get Isha;

  /// Create a copy of Timings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimingsImplCopyWith<_$TimingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PrayerTimesCache _$PrayerTimesCacheFromJson(Map<String, dynamic> json) {
  return _PrayerTimesCache.fromJson(json);
}

/// @nodoc
mixin _$PrayerTimesCache {
  String get uid => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String get calculationMethod => throw _privateConstructorUsedError;
  Timings get timings => throw _privateConstructorUsedError;
  HijriDate get hijriDate => throw _privateConstructorUsedError;
  DateTime get fetchedAt => throw _privateConstructorUsedError;
  String get validForDate => throw _privateConstructorUsedError;

  /// Serializes this PrayerTimesCache to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PrayerTimesCache
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PrayerTimesCacheCopyWith<PrayerTimesCache> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrayerTimesCacheCopyWith<$Res> {
  factory $PrayerTimesCacheCopyWith(
    PrayerTimesCache value,
    $Res Function(PrayerTimesCache) then,
  ) = _$PrayerTimesCacheCopyWithImpl<$Res, PrayerTimesCache>;
  @useResult
  $Res call({
    String uid,
    double latitude,
    double longitude,
    String calculationMethod,
    Timings timings,
    HijriDate hijriDate,
    DateTime fetchedAt,
    String validForDate,
  });

  $TimingsCopyWith<$Res> get timings;
  $HijriDateCopyWith<$Res> get hijriDate;
}

/// @nodoc
class _$PrayerTimesCacheCopyWithImpl<$Res, $Val extends PrayerTimesCache>
    implements $PrayerTimesCacheCopyWith<$Res> {
  _$PrayerTimesCacheCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PrayerTimesCache
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? calculationMethod = null,
    Object? timings = null,
    Object? hijriDate = null,
    Object? fetchedAt = null,
    Object? validForDate = null,
  }) {
    return _then(
      _value.copyWith(
            uid: null == uid
                ? _value.uid
                : uid // ignore: cast_nullable_to_non_nullable
                      as String,
            latitude: null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double,
            longitude: null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double,
            calculationMethod: null == calculationMethod
                ? _value.calculationMethod
                : calculationMethod // ignore: cast_nullable_to_non_nullable
                      as String,
            timings: null == timings
                ? _value.timings
                : timings // ignore: cast_nullable_to_non_nullable
                      as Timings,
            hijriDate: null == hijriDate
                ? _value.hijriDate
                : hijriDate // ignore: cast_nullable_to_non_nullable
                      as HijriDate,
            fetchedAt: null == fetchedAt
                ? _value.fetchedAt
                : fetchedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            validForDate: null == validForDate
                ? _value.validForDate
                : validForDate // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }

  /// Create a copy of PrayerTimesCache
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TimingsCopyWith<$Res> get timings {
    return $TimingsCopyWith<$Res>(_value.timings, (value) {
      return _then(_value.copyWith(timings: value) as $Val);
    });
  }

  /// Create a copy of PrayerTimesCache
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HijriDateCopyWith<$Res> get hijriDate {
    return $HijriDateCopyWith<$Res>(_value.hijriDate, (value) {
      return _then(_value.copyWith(hijriDate: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PrayerTimesCacheImplCopyWith<$Res>
    implements $PrayerTimesCacheCopyWith<$Res> {
  factory _$$PrayerTimesCacheImplCopyWith(
    _$PrayerTimesCacheImpl value,
    $Res Function(_$PrayerTimesCacheImpl) then,
  ) = __$$PrayerTimesCacheImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String uid,
    double latitude,
    double longitude,
    String calculationMethod,
    Timings timings,
    HijriDate hijriDate,
    DateTime fetchedAt,
    String validForDate,
  });

  @override
  $TimingsCopyWith<$Res> get timings;
  @override
  $HijriDateCopyWith<$Res> get hijriDate;
}

/// @nodoc
class __$$PrayerTimesCacheImplCopyWithImpl<$Res>
    extends _$PrayerTimesCacheCopyWithImpl<$Res, _$PrayerTimesCacheImpl>
    implements _$$PrayerTimesCacheImplCopyWith<$Res> {
  __$$PrayerTimesCacheImplCopyWithImpl(
    _$PrayerTimesCacheImpl _value,
    $Res Function(_$PrayerTimesCacheImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PrayerTimesCache
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? calculationMethod = null,
    Object? timings = null,
    Object? hijriDate = null,
    Object? fetchedAt = null,
    Object? validForDate = null,
  }) {
    return _then(
      _$PrayerTimesCacheImpl(
        uid: null == uid
            ? _value.uid
            : uid // ignore: cast_nullable_to_non_nullable
                  as String,
        latitude: null == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
        calculationMethod: null == calculationMethod
            ? _value.calculationMethod
            : calculationMethod // ignore: cast_nullable_to_non_nullable
                  as String,
        timings: null == timings
            ? _value.timings
            : timings // ignore: cast_nullable_to_non_nullable
                  as Timings,
        hijriDate: null == hijriDate
            ? _value.hijriDate
            : hijriDate // ignore: cast_nullable_to_non_nullable
                  as HijriDate,
        fetchedAt: null == fetchedAt
            ? _value.fetchedAt
            : fetchedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        validForDate: null == validForDate
            ? _value.validForDate
            : validForDate // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PrayerTimesCacheImpl implements _PrayerTimesCache {
  const _$PrayerTimesCacheImpl({
    required this.uid,
    required this.latitude,
    required this.longitude,
    required this.calculationMethod,
    required this.timings,
    required this.hijriDate,
    required this.fetchedAt,
    required this.validForDate,
  });

  factory _$PrayerTimesCacheImpl.fromJson(Map<String, dynamic> json) =>
      _$$PrayerTimesCacheImplFromJson(json);

  @override
  final String uid;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final String calculationMethod;
  @override
  final Timings timings;
  @override
  final HijriDate hijriDate;
  @override
  final DateTime fetchedAt;
  @override
  final String validForDate;

  @override
  String toString() {
    return 'PrayerTimesCache(uid: $uid, latitude: $latitude, longitude: $longitude, calculationMethod: $calculationMethod, timings: $timings, hijriDate: $hijriDate, fetchedAt: $fetchedAt, validForDate: $validForDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrayerTimesCacheImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.calculationMethod, calculationMethod) ||
                other.calculationMethod == calculationMethod) &&
            (identical(other.timings, timings) || other.timings == timings) &&
            (identical(other.hijriDate, hijriDate) ||
                other.hijriDate == hijriDate) &&
            (identical(other.fetchedAt, fetchedAt) ||
                other.fetchedAt == fetchedAt) &&
            (identical(other.validForDate, validForDate) ||
                other.validForDate == validForDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    uid,
    latitude,
    longitude,
    calculationMethod,
    timings,
    hijriDate,
    fetchedAt,
    validForDate,
  );

  /// Create a copy of PrayerTimesCache
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PrayerTimesCacheImplCopyWith<_$PrayerTimesCacheImpl> get copyWith =>
      __$$PrayerTimesCacheImplCopyWithImpl<_$PrayerTimesCacheImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PrayerTimesCacheImplToJson(this);
  }
}

abstract class _PrayerTimesCache implements PrayerTimesCache {
  const factory _PrayerTimesCache({
    required final String uid,
    required final double latitude,
    required final double longitude,
    required final String calculationMethod,
    required final Timings timings,
    required final HijriDate hijriDate,
    required final DateTime fetchedAt,
    required final String validForDate,
  }) = _$PrayerTimesCacheImpl;

  factory _PrayerTimesCache.fromJson(Map<String, dynamic> json) =
      _$PrayerTimesCacheImpl.fromJson;

  @override
  String get uid;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  String get calculationMethod;
  @override
  Timings get timings;
  @override
  HijriDate get hijriDate;
  @override
  DateTime get fetchedAt;
  @override
  String get validForDate;

  /// Create a copy of PrayerTimesCache
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PrayerTimesCacheImplCopyWith<_$PrayerTimesCacheImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
