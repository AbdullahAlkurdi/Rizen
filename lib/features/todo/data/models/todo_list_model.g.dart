// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoListModelImpl _$$TodoListModelImplFromJson(Map<String, dynamic> json) =>
    _$TodoListModelImpl(
      id: json['id'] as String,
      parentId: json['parentId'] as String,
      parentType: json['parentType'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => TodoItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      completionThreshold: (json['completionThreshold'] as num?)?.toInt() ?? 70,
      completionPct: (json['completionPct'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$TodoListModelImplToJson(_$TodoListModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'parentId': instance.parentId,
      'parentType': instance.parentType,
      'items': instance.items,
      'completionThreshold': instance.completionThreshold,
      'completionPct': instance.completionPct,
    };
