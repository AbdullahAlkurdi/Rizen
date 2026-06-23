import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'budget_cycle_model.freezed.dart';
part 'budget_cycle_model.g.dart';

// ignore_for_file: invalid_annotation_target

enum BudgetCycleStatus { active, closed }

DateTime _dateTimeFromJson(Object? value) {
  if (value is Timestamp) return value.toDate();
  if (value is DateTime) return value;
  if (value is String) return DateTime.parse(value);
  return DateTime.now();
}

String _dateTimeToJson(DateTime value) => value.toIso8601String();

@freezed
class BudgetCycle with _$BudgetCycle {
  const BudgetCycle._();

  const factory BudgetCycle({
    required String id,
    required String uid,
    required double monthlyIncome,
    @Default('SAR') String currency,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    required DateTime cycleStart,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    required DateTime cycleEnd,
    required double totalSpent,
    required double totalCommitted,
    required BudgetCycleStatus status,
  }) = _BudgetCycle;

  factory BudgetCycle.fromJson(Map<String, dynamic> json) =>
      _$BudgetCycleFromJson(json);

  factory BudgetCycle.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BudgetCycle.fromJson({
      'id': doc.id,
      'uid': data['uid'] as String? ?? '',
      'monthlyIncome': (data['monthlyIncome'] as num?)?.toDouble() ?? 0,
      'currency': data['currency'] as String? ?? 'SAR',
      'cycleStart': data['cycleStart'],
      'cycleEnd': data['cycleEnd'],
      'totalSpent': (data['totalSpent'] as num?)?.toDouble() ?? 0,
      'totalCommitted': (data['totalCommitted'] as num?)?.toDouble() ?? 0,
      'status': data['status'] as String? ?? BudgetCycleStatus.active.name,
    });
  }

  Map<String, dynamic> toFirestore() => {
    'uid': uid,
    'monthlyIncome': monthlyIncome,
    'currency': currency,
    'cycleStart': Timestamp.fromDate(cycleStart),
    'cycleEnd': Timestamp.fromDate(cycleEnd),
    'totalSpent': totalSpent,
    'totalCommitted': totalCommitted,
    'status': status.name,
  };
}
