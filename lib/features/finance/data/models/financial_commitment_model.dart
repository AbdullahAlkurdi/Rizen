import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'financial_commitment_model.freezed.dart';
part 'financial_commitment_model.g.dart';

// ignore_for_file: invalid_annotation_target

enum CommitmentFrequency { daily, weekly, monthly }

DateTime _dateTimeFromJson(Object? value) {
  if (value is Timestamp) return value.toDate();
  if (value is DateTime) return value;
  if (value is String) return DateTime.parse(value);
  return DateTime.now();
}

String _dateTimeToJson(DateTime value) => value.toIso8601String();

@freezed
class FinancialCommitment with _$FinancialCommitment {
  const FinancialCommitment._();

  const factory FinancialCommitment({
    required String id,
    required String uid,
    required String name,
    required double amount,
    required CommitmentFrequency frequency,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    required DateTime nextDueDate,
    required bool active,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    required DateTime createdAt,
  }) = _FinancialCommitment;

  factory FinancialCommitment.fromJson(Map<String, dynamic> json) =>
      _$FinancialCommitmentFromJson(json);

  factory FinancialCommitment.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FinancialCommitment.fromJson({
      'id': doc.id,
      'uid': data['uid'] as String? ?? '',
      'name': data['name'] as String? ?? '',
      'amount': (data['amount'] as num?)?.toDouble() ?? 0,
      'frequency':
          data['frequency'] as String? ?? CommitmentFrequency.monthly.name,
      'nextDueDate': data['nextDueDate'],
      'active': data['active'] as bool? ?? true,
      'createdAt': data['createdAt'],
    });
  }

  Map<String, dynamic> toFirestore() => {
    'uid': uid,
    'name': name,
    'amount': amount,
    'frequency': frequency.name,
    'nextDueDate': Timestamp.fromDate(nextDueDate),
    'active': active,
    'createdAt': Timestamp.fromDate(createdAt),
  };
}
