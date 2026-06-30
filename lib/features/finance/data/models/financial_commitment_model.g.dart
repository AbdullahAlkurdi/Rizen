// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_commitment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FinancialCommitmentImpl _$$FinancialCommitmentImplFromJson(
  Map<String, dynamic> json,
) => _$FinancialCommitmentImpl(
  id: json['id'] as String,
  uid: json['uid'] as String,
  name: json['name'] as String,
  amount: (json['amount'] as num).toDouble(),
  frequency: $enumDecode(_$CommitmentFrequencyEnumMap, json['frequency']),
  nextDueDate: _dateTimeFromJson(json['nextDueDate']),
  active: json['active'] as bool,
  createdAt: _dateTimeFromJson(json['createdAt']),
);

Map<String, dynamic> _$$FinancialCommitmentImplToJson(
  _$FinancialCommitmentImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'uid': instance.uid,
  'name': instance.name,
  'amount': instance.amount,
  'frequency': _$CommitmentFrequencyEnumMap[instance.frequency]!,
  'nextDueDate': _dateTimeToJson(instance.nextDueDate),
  'active': instance.active,
  'createdAt': _dateTimeToJson(instance.createdAt),
};

const _$CommitmentFrequencyEnumMap = {
  CommitmentFrequency.daily: 'daily',
  CommitmentFrequency.weekly: 'weekly',
  CommitmentFrequency.monthly: 'monthly',
};
