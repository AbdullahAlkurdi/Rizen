import 'package:freezed_annotation/freezed_annotation.dart';

part 'dua_item_model.freezed.dart';
part 'dua_item_model.g.dart';

@freezed
class DuaItem with _$DuaItem {
  const factory DuaItem({
    required String id,
    required String arabicText,
    required String transliteration,
    required String translationAr,
    required String translationEn,
    required List<String> occasions,
  }) = _DuaItem;

  factory DuaItem.fromJson(Map<String, dynamic> json) =>
      _$DuaItemFromJson(json);
}
