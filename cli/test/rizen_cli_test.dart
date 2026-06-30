import 'package:test/test.dart';
import 'package:rizen_cli/services/table_formatter.dart';

void main() {
  group('TableFormatter', () {
    test('formatHabits returns formatted table', () {
      final habits = [
        {'id': '1', 'name': 'Gym', 'streak': 5, 'lastCompleted': '2024-01-01', 'completedToday': true},
        {'id': '2', 'name': 'Reading', 'streak': 0, 'lastCompleted': null, 'completedToday': false},
      ];
      final result = TableFormatter.formatHabits(habits);
      expect(result, contains('Gym'));
      expect(result, contains('Reading'));
      expect(result, contains('5'));
    });

    test('formatHabits returns message for empty list', () {
      expect(TableFormatter.formatHabits([]), 'No habits found.');
    });

    test('formatTodos returns formatted table', () {
      final todos = [
        {'id': '1', 'title': 'Drink water', 'done': true, 'priority': 'high'},
        {'id': '2', 'title': 'Send email', 'done': false, 'priority': 'med'},
      ];
      final result = TableFormatter.formatTodos(todos);
      expect(result, contains('Drink water'));
      expect(result, contains('Send email'));
      expect(result, contains('✅'));
      expect(result, contains('⬜'));
    });

    test('formatTodos returns message for empty list', () {
      expect(TableFormatter.formatTodos([]), 'No todos found.');
    });

    test('formatRoutines returns formatted table', () {
      final routines = [
        {'time': '06:00', 'title': 'Fajr', 'done': true},
        {'time': '08:00', 'title': 'Gym', 'done': false},
      ];
      final result = TableFormatter.formatRoutines(routines);
      expect(result, contains('Fajr'));
      expect(result, contains('Gym'));
    });

    test('formatRoutines returns message for empty list', () {
      expect(TableFormatter.formatRoutines([]), 'No routines found for today.');
    });

    test('formatAnalytics returns formatted table', () {
      final data = {'Score': '85', 'Burnout Risk': 'low'};
      final result = TableFormatter.formatAnalytics(data);
      expect(result, contains('Score'));
      expect(result, contains('85'));
      expect(result, contains('Burnout Risk'));
      expect(result, contains('low'));
    });

    test('formatProgressBar returns correct bar', () {
      final bar = TableFormatter.formatProgressBar(5, 10, 10);
      expect(bar, '[█████░░░░░]');
    });

    test('formatProgressBar handles zero total', () {
      final bar = TableFormatter.formatProgressBar(0, 0, 10);
      expect(bar, '[░░░░░░░░░░]');
    });
  });
}
