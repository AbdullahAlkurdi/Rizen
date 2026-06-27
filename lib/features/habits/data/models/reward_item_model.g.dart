// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RewardItemImpl _$$RewardItemImplFromJson(Map<String, dynamic> json) =>
    _$RewardItemImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      cost: (json['cost'] as num).toInt(),
      icon: json['icon'] as String,
      unlocked: json['unlocked'] as bool? ?? false,
    );

Map<String, dynamic> _$$RewardItemImplToJson(_$RewardItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'cost': instance.cost,
      'icon': instance.icon,
      'unlocked': instance.unlocked,
    };
