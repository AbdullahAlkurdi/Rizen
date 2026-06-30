import 'dart:io';
import 'package:args/args.dart';
import 'package:rizen_cli/services/firestore_service.dart';
import 'package:rizen_cli/services/table_formatter.dart';

class HabitCommand {
  final FirestoreService firestore;
  HabitCommand(this.firestore);

  Future<void> execute(ArgResults args) async {
    final sub = args.command?.name;

    switch (sub) {
      case 'list':
        await _list(args);
        break;
      case 'check':
        await _check(args);
        break;
      case 'streak':
        await _streak(args);
        break;
      default:
        stdout.writeln('Usage: habit list | habit check <name> | habit streak <name>');
    }
  }

  Future<void> _list(ArgResults args) async {
    final habits = await firestore.getTodayHabits();
    stdout.writeln('\n Habits');
    stdout.writeln(TableFormatter.formatHabits(habits.map((h) {
      return {
        'id': h['id'],
        'name': h['name'],
        'streak': h['streak'] ?? 0,
        'lastCompleted': h['lastCompleted'],
        'completedToday': h['completedToday'] ?? false,
      };
    }).toList()));
  }

  Future<void> _check(ArgResults args) async {
    final name = args.command?.rest.firstOrNull;
    if (name == null) { stdout.writeln('Usage: habit check <name>'); return; }
    final habits = await firestore.getTodayHabits();
    final doc = habits.firstWhere((h) => (h['name'] ?? '').toLowerCase() == name.toLowerCase(), orElse: () => throw Exception('Habit not found'));
    await firestore.checkHabit(doc['id']);
    stdout.writeln('✅ Habit checked: $name');
  }

  Future<void> _streak(ArgResults args) async {
    final name = args.command?.rest.firstOrNull;
    if (name == null) { stdout.writeln('Usage: habit streak <name>'); return; }
    stdout.writeln('🔗 Streak feature requires analytics endpoint (not yet implemented).');
  }
}
