// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NoteImpl _$$NoteImplFromJson(Map<String, dynamic> json) => _$NoteImpl(
  id: json['id'] as String,
  uid: json['uid'] as String,
  title: json['title'] as String,
  content: json['content'] as String,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  mood: json['mood'] as String,
  loggedAt: DateTime.parse(json['loggedAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  category: $enumDecodeNullable(_$NoteCategoryEnumMap, json['category']),
  isPinned: json['isPinned'] as bool? ?? false,
  reminderAt: json['reminderAt'] == null
      ? null
      : DateTime.parse(json['reminderAt'] as String),
  editHistory:
      (json['editHistory'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$NoteImplToJson(
  _$NoteImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'uid': instance.uid,
  'title': instance.title,
  'content': instance.content,
  'tags': instance.tags,
  'mood': instance.mood,
  'loggedAt': instance.loggedAt.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'category': _$NoteCategoryEnumMap[instance.category],
  'isPinned': instance.isPinned,
  'reminderAt': instance.reminderAt?.toIso8601String(),
  'editHistory': instance.editHistory.map((e) => e.toIso8601String()).toList(),
};

const _$NoteCategoryEnumMap = {
  NoteCategory.reflection: 'reflection',
  NoteCategory.gratitude: 'gratitude',
  NoteCategory.brainDump: 'brainDump',
  NoteCategory.insight: 'insight',
  NoteCategory.custom: 'custom',
};
