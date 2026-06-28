import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/note_model.dart';
import '../../data/repositories/notes_repository.dart';

sealed class NotesState {}

final class NotesInitial extends NotesState {}

final class NotesLoading extends NotesState {}

final class NotesLoaded extends NotesState {
  final List<Note> notes;
  final Note? selectedNote;
  NotesLoaded({required this.notes, this.selectedNote});
}

final class NotesError extends NotesState {
  final String message;
  NotesError(this.message);
}

class NotesCubit extends Cubit<NotesState> {
  NotesCubit({NotesRepository? repository})
    : _repository = repository ?? NotesRepository(),
      super(NotesInitial());

  final NotesRepository _repository;

  Future<void> loadNotes() async {
    emit(NotesLoading());
    try {
      final notes = await _repository.getAllNotes();
      emit(NotesLoaded(notes: notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> loadNote(String noteId) async {
    emit(NotesLoading());
    try {
      final note = await _repository.getNote(noteId);
      if (note == null) {
        emit(NotesError('Note not found'));
        return;
      }
      emit(NotesLoaded(notes: [], selectedNote: note));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> loadTodayNotes() async {
    emit(NotesLoading());
    try {
      final notes = await _repository.getNotesByDate(DateTime.now());
      emit(NotesLoaded(notes: notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> loadNotesByTag(String tag) async {
    emit(NotesLoading());
    try {
      final notes = await _repository.getNotesByTag(tag);
      emit(NotesLoaded(notes: notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> searchNotes(String query) async {
    emit(NotesLoading());
    try {
      final notes = await _repository.searchNotes(query);
      emit(NotesLoaded(notes: notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> createNote(Note note) async {
    emit(NotesLoading());
    try {
      await _repository.createNote(note);
      final notes = await _repository.getAllNotes();
      emit(NotesLoaded(notes: notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> updateNote(Note note) async {
    emit(NotesLoading());
    try {
      await _repository.updateNote(note);
      final notes = await _repository.getAllNotes();
      emit(NotesLoaded(notes: notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> deleteNote(String noteId) async {
    emit(NotesLoading());
    try {
      await _repository.deleteNote(noteId);
      final notes = await _repository.getAllNotes();
      emit(NotesLoaded(notes: notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }
}
