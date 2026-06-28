import 'package:flutter_test/flutter_test.dart';
import 'package:rizen/features/notes/presentation/cubit/notes_cubit.dart';

void main() {
  group('NotesState', () {
    test('NotesInitial is a valid state', () {
      expect(NotesInitial(), isA<NotesState>());
    });

    test('NotesLoading is a valid state', () {
      expect(NotesLoading(), isA<NotesState>());
    });

    test('NotesLoaded holds notes list', () {
      final state = NotesLoaded(notes: []);
      expect(state.notes, isEmpty);
    });

    test('NotesLoaded holds selected note', () {
      final state = NotesLoaded(notes: []);
      expect(state.selectedNote, isNull);
    });

    test('NotesError holds error message', () {
      final state = NotesError('Something went wrong');
      expect(state.message, equals('Something went wrong'));
    });
  });
}