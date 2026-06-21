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
  final NotesRepository _repository;

  NotesCubit({NotesRepository? repository})
      : _repository = repository ?? NotesRepository(),
        super(NotesInitial());

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

  Future<void> createNote({
    required String title,
    required String body,
    List<String> tags = const [],
  }) async {
    emit(NotesLoading());
    try {
      await _repository.createNote(title: title, body: body, tags: tags);
      final notes = await _repository.getAllNotes();
      emit(NotesLoaded(notes: notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> updateNote({
    required String noteId,
    required String title,
    required String body,
    List<String> tags = const [],
  }) async {
    emit(NotesLoading());
    try {
      await _repository.updateNote(
        noteId: noteId,
        title: title,
        body: body,
        tags: tags,
      );
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
