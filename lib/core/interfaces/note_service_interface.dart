import '../../features/notes/data/models/note_model.dart';

export '../../features/notes/data/models/note_model.dart';

abstract class NoteServiceInterface {
  Future<List<Note>> getRecentNotes(int count);
  Future<List<Note>> getAllNotes();
  Future<void> createNote(Note note);
  Future<Note?> getNote(String noteId);
  Future<void> updateNote(Note note);
  Future<void> deleteNote(String noteId);
}