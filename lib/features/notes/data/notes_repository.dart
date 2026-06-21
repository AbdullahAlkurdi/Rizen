import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'note_model.dart';

class NotesRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  NotesRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  CollectionReference get _notesCollection => _firestore.collection('notes');

  Future<Note?> getNote(String noteId) async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final doc = await _notesCollection.doc(noteId).get();
    if (!doc.exists) return null;

    final note = Note.fromFirestore(doc);
    if (note.uid != user.uid) return null;

    return note;
  }

  Future<void> createNote({
    required String title,
    required String content,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final ref = _notesCollection.doc();
    final now = FieldValue.serverTimestamp();

    await ref.set({
      'noteId': ref.id,
      'uid': user.uid,
      'title': title,
      'content': content,
      'createdAt': now,
      'updatedAt': null,
    });
  }

  Future<void> updateNote({
    required String noteId,
    required String title,
    required String content,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final noteRef = _notesCollection.doc(noteId);
    final doc = await noteRef.get();

    if (!doc.exists) throw Exception('Note not found');

    final existingNote = Note.fromFirestore(doc);
    if (existingNote.uid != user.uid) {
      throw Exception('Unauthorized');
    }

    await noteRef.update({
      'title': title,
      'content': content,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteNote(String noteId) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final noteRef = _notesCollection.doc(noteId);
    final doc = await noteRef.get();

    if (!doc.exists) return;

    final existingNote = Note.fromFirestore(doc);
    if (existingNote.uid != user.uid) return;

    await noteRef.delete();
  }

  Future<List<Note>> getAllNotes() async {
    final user = _auth.currentUser;
    if (user == null) return [];

    final snapshot = await _notesCollection
        .where('uid', isEqualTo: user.uid)
        .orderBy('updatedAt', descending: true)
        .get();

    return snapshot.docs.map((doc) => Note.fromFirestore(doc)).toList();
  }
}