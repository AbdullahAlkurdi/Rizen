import '../../data/repositories/notes_repository.dart';
import '../entities/notes_streak.dart';

class ComputeNotesStreakUseCase {
  ComputeNotesStreakUseCase(this._repository);

  final NotesRepository _repository;

  Future<NotesStreak> execute() async {
    final notes = await _repository.getAllNotes();
    
    final datesWithNotes = <DateTime>{};
    for (final note in notes) {
      final day = DateTime(note.loggedAt.year, note.loggedAt.month, note.loggedAt.day);
      datesWithNotes.add(day);
    }

    final sortedDates = datesWithNotes.toList()..sort((a, b) => b.compareTo(a));
    
    int currentStreak = 0;
    int longestStreak = 0;
    
    if (sortedDates.isNotEmpty) {
      final today = DateTime.now();
      final todayDay = DateTime(today.year, today.month, today.day);
      
      if (sortedDates.contains(todayDay)) {
        currentStreak = _calculateCurrentStreak(sortedDates, todayDay);
      }
      
      longestStreak = _calculateLongestStreak(sortedDates);
    }
    
    return NotesStreak(
      currentStreak: currentStreak,
      longestStreak: longestStreak,
      totalDaysWithNotes: datesWithNotes.length,
      datesWithNotes: sortedDates,
    );
  }

  int _calculateCurrentStreak(List<DateTime> sortedDates, DateTime today) {
    int streak = 0;
    DateTime current = today;
    
    while (sortedDates.contains(current)) {
      streak++;
      current = DateTime(current.year, current.month, current.day - 1);
    }
    
    return streak;
  }

  int _calculateLongestStreak(List<DateTime> sortedDates) {
    if (sortedDates.isEmpty) return 0;
    
    int maxStreak = 1;
    int currentStreak = 1;
    
    for (int i = 1; i < sortedDates.length; i++) {
      final diff = sortedDates[i - 1].difference(sortedDates[i]).inDays;
      if (diff == 1) {
        currentStreak++;
      } else {
        maxStreak = maxStreak > currentStreak ? maxStreak : currentStreak;
        currentStreak = 1;
      }
    }
    
    return maxStreak > currentStreak ? maxStreak : currentStreak;
  }
}