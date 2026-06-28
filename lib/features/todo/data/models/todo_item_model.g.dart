// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoItemModelImpl _$$TodoItemModelImplFromJson(Map<String, dynamic> json) =>
    _$TodoItemModelImpl(
      id: json['id'] as String,
      parentId: json['parentId'] as String,
      parentType: json['parentType'] as String,
      title: json['title'] as String,
      order: (json['order'] as num).toInt(),
      isRequired: json['isRequired'] as bool? ?? true,
      weight: (json['weight'] as num?)?.toDouble() ?? 1.0,
      isCompleted: json['isCompleted'] as bool? ?? false,
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      note: json['note'] as String?,
      date: json['date'] as String?,
    );

Map<String, dynamic> _$$TodoItemModelImplToJson(_$TodoItemModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'parentId': instance.parentId,
      'parentType': instance.parentType,
      'title': instance.title,
      'order': instance.order,
      'isRequired': instance.isRequired,
      'weight': instance.weight,
      'isCompleted': instance.isCompleted,
      'completedAt': instance.completedAt?.toIso8601String(),
      'note': instance.note,
      'date': instance.date,
    };
