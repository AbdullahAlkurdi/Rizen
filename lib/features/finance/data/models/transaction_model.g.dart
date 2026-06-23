// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionImpl _$$TransactionImplFromJson(Map<String, dynamic> json) =>
    _$TransactionImpl(
      id: json['id'] as String,
      uid: json['uid'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'SAR',
      description: json['description'] as String,
      category: json['category'] as String?,
      type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
      source: $enumDecode(_$TransactionSourceEnumMap, json['source']),
      loggedAt: _dateTimeFromJson(json['loggedAt']),
      createdAt: _dateTimeFromJson(json['createdAt']),
    );

Map<String, dynamic> _$$TransactionImplToJson(_$TransactionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'amount': instance.amount,
      'currency': instance.currency,
      'description': instance.description,
      'category': instance.category,
      'type': _$TransactionTypeEnumMap[instance.type]!,
      'source': _$TransactionSourceEnumMap[instance.source]!,
      'loggedAt': _dateTimeToJson(instance.loggedAt),
      'createdAt': _dateTimeToJson(instance.createdAt),
    };

const _$TransactionTypeEnumMap = {
  TransactionType.income: 'income',
  TransactionType.expense: 'expense',
};

const _$TransactionSourceEnumMap = {
  TransactionSource.quickEntry: 'quick_entry',
  TransactionSource.manual: 'manual',
  TransactionSource.recurringAuto: 'recurring_auto',
};
