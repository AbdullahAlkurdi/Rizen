import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'quran_log_model.freezed.dart';
part 'quran_log_model.g.dart';

@freezed
class QuranLog with _$QuranLog {
  const factory QuranLog({
    required String id,
    required String uid,
    required int pagesRead,
    required DateTime loggedAt,
  }) = _QuranLog;

  factory QuranLog.fromJson(Map<String, dynamic> json) =>
      _$QuranLogFromJson(json);

  factory QuranLog.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return QuranLog(
      id: doc.id,
      uid: data['uid'] as String? ?? '',
      pagesRead: data['pagesRead'] as int? ?? 0,
      loggedAt: (data['loggedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
