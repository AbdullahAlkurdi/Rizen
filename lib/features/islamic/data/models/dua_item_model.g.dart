// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dua_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DuaItemImpl _$$DuaItemImplFromJson(Map<String, dynamic> json) =>
    _$DuaItemImpl(
      id: json['id'] as String,
      arabicText: json['arabicText'] as String,
      transliteration: json['transliteration'] as String,
      translationAr: json['translationAr'] as String,
      translationEn: json['translationEn'] as String,
      occasions: (json['occasions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$DuaItemImplToJson(_$DuaItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'arabicText': instance.arabicText,
      'transliteration': instance.transliteration,
      'translationAr': instance.translationAr,
      'translationEn': instance.translationEn,
      'occasions': instance.occasions,
    };
