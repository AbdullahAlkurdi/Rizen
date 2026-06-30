import '../../../notes/domain/entities/note_category.dart';

class NotesAnalyticsSummary {
  const NotesAnalyticsSummary({
    required this.totalNotes,
    required this.notesThisWeek,
    required this.notesByCategory,
    required this.topTags,
    required this.notesByDay,
    required this.averageNoteLength,
    required this.streakDates,
  });

  final int totalNotes;
  final int notesThisWeek;
  final Map<NoteCategory, int> notesByCategory;
  final Map<String, int> topTags;
  final Map<DateTime, int> notesByDay;
  final double averageNoteLength;
  final List<DateTime> streakDates;
}