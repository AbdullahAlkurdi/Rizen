// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_cycle_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BudgetCycleImpl _$$BudgetCycleImplFromJson(Map<String, dynamic> json) =>
    _$BudgetCycleImpl(
      id: json['id'] as String,
      uid: json['uid'] as String,
      monthlyIncome: (json['monthlyIncome'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'SAR',
      cycleStart: _dateTimeFromJson(json['cycleStart']),
      cycleEnd: _dateTimeFromJson(json['cycleEnd']),
      totalSpent: (json['totalSpent'] as num).toDouble(),
      totalCommitted: (json['totalCommitted'] as num).toDouble(),
      status: $enumDecode(_$BudgetCycleStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$$BudgetCycleImplToJson(_$BudgetCycleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'monthlyIncome': instance.monthlyIncome,
      'currency': instance.currency,
      'cycleStart': _dateTimeToJson(instance.cycleStart),
      'cycleEnd': _dateTimeToJson(instance.cycleEnd),
      'totalSpent': instance.totalSpent,
      'totalCommitted': instance.totalCommitted,
      'status': _$BudgetCycleStatusEnumMap[instance.status]!,
    };

const _$BudgetCycleStatusEnumMap = {
  BudgetCycleStatus.active: 'active',
  BudgetCycleStatus.closed: 'closed',
};
