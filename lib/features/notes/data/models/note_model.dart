import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_model.freezed.dart';
part 'note_model.g.dart';

@freezed
class Note with _$Note {
  const factory Note({
    required String id,
    required String title,
    required String body,
    required DateTime createdAt,
    DateTime? updatedAt,
    @Default([]) List<String> tags,
  }) = _Note;

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  factory Note.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Note.fromJson({
      'id': doc.id,
      'title': data['title'] as String? ?? '',
      'body': data['body'] as String? ?? '',
      'createdAt': (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      'updatedAt': (data['updatedAt'] as Timestamp?)?.toDate(),
      'tags': (data['tags'] as List<dynamic>?)?.cast<String>() ?? [],
    });
  }
}
