import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_model.freezed.dart';
part 'note_model.g.dart';

String _moodFromFirestore(String? mood) => mood ?? 'neutral';

@freezed
class Note with _$Note {
  const Note._();

  const factory Note({
    required String id,
    required String uid,
    required String title,
    required String content,
    @Default([]) List<String> tags,
    required String mood,
    required DateTime loggedAt,
    DateTime? updatedAt,
  }) = _Note;

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  factory Note.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Note(
      id: doc.id,
      uid: data['uid'] as String? ?? '',
      title: data['title'] as String? ?? '',
      content: data['content'] as String? ?? data['body'] as String? ?? '',
      tags: (data['tags'] as List<dynamic>?)?.cast<String>() ?? [],
      mood: _moodFromFirestore(data['mood'] as String?),
      loggedAt: (data['loggedAt'] as Timestamp?)?.toDate() ??
          (data['createdAt'] as Timestamp?)?.toDate() ??
          DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'uid': uid,
        'title': title,
        'content': content,
        'tags': tags,
        'mood': mood,
        'loggedAt': Timestamp.fromDate(loggedAt),
        if (updatedAt != null) 'updatedAt': Timestamp.fromDate(updatedAt!),
      };
}
