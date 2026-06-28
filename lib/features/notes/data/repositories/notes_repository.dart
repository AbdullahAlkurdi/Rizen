import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/interfaces/note_service_interface.dart';

class NotesRepository implements NoteServiceInterface {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  NotesRepository({FirebaseFirestore? firestore, FirebaseAuth? auth})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  CollectionReference get _notesCollection => _firestore.collection('notes');

  @override
  Future<List<Note>> getRecentNotes(int count) async {
    final user = _auth.currentUser;
    if (user == null) return [];

    final snapshot = await _notesCollection
        .where('uid', isEqualTo: user.uid)
        .orderBy('loggedAt', descending: true)
        .limit(count)
        .get();

    return snapshot.docs.map((doc) => Note.fromFirestore(doc)).toList();
  }

  @override
  Future<List<Note>> getAllNotes() async {
    final user = _auth.currentUser;
    if (user == null) return [];

    final snapshot = await _notesCollection
        .where('uid', isEqualTo: user.uid)
        .orderBy('loggedAt', descending: true)
        .get();

    return snapshot.docs.map((doc) => Note.fromFirestore(doc)).toList();
  }

  @override
  Future<void> createNote(Note note) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final ref = _notesCollection.doc(note.id);
    await ref.set(note.toFirestore());
  }

  @override
  Future<Note?> getNote(String noteId) async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final doc = await _notesCollection.doc(noteId).get();
    if (!doc.exists) return null;

    final note = Note.fromFirestore(doc);
    if (note.uid != user.uid) return null;
    return note;
  }

  @override
  Future<void> updateNote(Note note) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final noteRef = _notesCollection.doc(note.id);
    final doc = await noteRef.get();

    if (!doc.exists) throw Exception('Note not found');
    final data = doc.data() as Map<String, dynamic>;
    if (data['uid'] != user.uid) {
      throw Exception('Unauthorized');
    }

    await noteRef.update(note.toFirestore());
  }

  @override
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

  Future<List<Note>> getNotesByDate(DateTime date) async {
    final user = _auth.currentUser;
    if (user == null) return [];

    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));

    final snapshot = await _notesCollection
        .where('uid', isEqualTo: user.uid)
        .where('loggedAt', isGreaterThanOrEqualTo: start)
        .where('loggedAt', isLessThan: end)
        .orderBy('loggedAt', descending: true)
        .get();

    return snapshot.docs.map((doc) => Note.fromFirestore(doc)).toList();
  }

  Future<List<Note>> getNotesByTag(String tag) async {
    final user = _auth.currentUser;
    if (user == null) return [];

    final snapshot = await _notesCollection
        .where('uid', isEqualTo: user.uid)
        .where('tags', arrayContains: tag)
        .orderBy('loggedAt', descending: true)
        .get();

    return snapshot.docs.map((doc) => Note.fromFirestore(doc)).toList();
  }

  Future<List<Note>> searchNotes(String query) async {
    final user = _auth.currentUser;
    if (user == null) return [];

    final snapshot = await _notesCollection
        .where('uid', isEqualTo: user.uid)
        .get();

    final notes = snapshot.docs.map((doc) => Note.fromFirestore(doc)).toList();
    final lowerQuery = query.toLowerCase();

    return notes.where((note) {
      return note.title.toLowerCase().contains(lowerQuery) ||
          note.content.toLowerCase().contains(lowerQuery) ||
          note.tags.any((t) => t.toLowerCase().contains(lowerQuery));
    }).toList();
  }
}
