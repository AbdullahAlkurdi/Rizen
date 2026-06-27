// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuranLogImpl _$$QuranLogImplFromJson(Map<String, dynamic> json) =>
    _$QuranLogImpl(
      id: json['id'] as String,
      uid: json['uid'] as String,
      pagesRead: (json['pagesRead'] as num).toInt(),
      loggedAt: DateTime.parse(json['loggedAt'] as String),
    );

Map<String, dynamic> _$$QuranLogImplToJson(_$QuranLogImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'pagesRead': instance.pagesRead,
      'loggedAt': instance.loggedAt.toIso8601String(),
    };
