import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

// ignore_for_file: invalid_annotation_target

enum TransactionType { income, expense }

enum TransactionSource {
  @JsonValue('quick_entry')
  quickEntry,
  manual,
  @JsonValue('recurring_auto')
  recurringAuto,
}

DateTime _dateTimeFromJson(Object? value) {
  if (value is Timestamp) return value.toDate();
  if (value is DateTime) return value;
  if (value is String) return DateTime.parse(value);
  return DateTime.now();
}

String _dateTimeToJson(DateTime value) => value.toIso8601String();

@freezed
class Transaction with _$Transaction {
  const Transaction._();

  const factory Transaction({
    required String id,
    required String uid,
    required double amount,
    @Default('SAR') String currency,
    required String description,
    String? category,
    required TransactionType type,
    required TransactionSource source,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    required DateTime loggedAt,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    required DateTime createdAt,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  factory Transaction.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Transaction.fromJson({
      'id': doc.id,
      'uid': data['uid'] as String? ?? '',
      'amount': (data['amount'] as num?)?.toDouble() ?? 0,
      'currency': data['currency'] as String? ?? 'SAR',
      'description': data['description'] as String? ?? '',
      'category': data['category'] as String?,
      'type': data['type'] as String? ?? TransactionType.expense.name,
      'source': data['source'] as String? ?? TransactionSource.manual.name,
      'loggedAt': data['loggedAt'],
      'createdAt': data['createdAt'],
    });
  }

  Map<String, dynamic> toFirestore() => {
    'uid': uid,
    'amount': amount,
    'currency': currency,
    'description': description,
    'category': category,
    'type': type.name,
    'source': source.name,
    'loggedAt': Timestamp.fromDate(loggedAt),
    'createdAt': Timestamp.fromDate(createdAt),
  };
}
