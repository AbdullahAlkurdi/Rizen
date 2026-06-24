import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/note_model.dart';

class NotesRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  NotesRepository({FirebaseFirestore? firestore, FirebaseAuth? auth})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _auth = auth ?? FirebaseAuth.instance;

  CollectionReference get _notesCollection => _firestore.collection('notes');

  Future<Note?> getNote(String noteId) async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final doc = await _notesCollection.doc(noteId).get();
    if (!doc.exists) return null;

    final note = Note.fromFirestore(doc);
    if (note.id.isEmpty) return null;

    return note;
  }

  Future<void> createNote({
    required String title,
    required String body,
    List<String> tags = const [],
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final ref = _notesCollection.doc();

    await ref.set({
      'uid': user.uid,
      'title': title,
      'body': body,
      'tags': tags,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateNote({
    required String noteId,
    required String title,
    required String body,
    List<String> tags = const [],
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final noteRef = _notesCollection.doc(noteId);
    final doc = await noteRef.get();

    if (!doc.exists) throw Exception('Note not found');
    final data = doc.data() as Map<String, dynamic>;
    if (data['uid'] != user.uid) {
      throw Exception('Unauthorized');
    }

    await noteRef.update({
      'title': title,
      'body': body,
      'tags': tags,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteNote(String noteId) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final noteRef = _notesCollection.doc(noteId);
    final doc = await noteRef.get();

    if (!doc.exists) return;
    final data = doc.data() as Map<String, dynamic>;
    if (data['uid'] != user.uid) return;

    await noteRef.delete();
  }

  Future<List<Note>> getAllNotes() async {
    final user = _auth.currentUser;
    if (user == null) return [];

    final snapshot = await _notesCollection
        .where('uid', isEqualTo: user.uid)
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs.map((doc) => Note.fromFirestore(doc)).toList();
  }
}
