class NotesStreak {
  const NotesStreak({
    required this.currentStreak,
    required this.longestStreak,
    required this.totalDaysWithNotes,
    required this.datesWithNotes,
  });

  final int currentStreak;
  final int longestStreak;
  final int totalDaysWithNotes;
  final List<DateTime> datesWithNotes;
}