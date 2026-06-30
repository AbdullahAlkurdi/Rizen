import 'package:args/args.dart';
import 'package:rizen_cli/services/firestore_service.dart';
import 'package:rizen_cli/services/table_formatter.dart';

class HabitCommand extends BaseCommand {
  HabitCommand(super.firestore);

  @override
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
        print('Usage: habit list | habit check <name> | habit streak <name>');
    }
  }

  Future<void> _list(ArgResults args) async {
    final habits = await firestore.getTodayHabits();
    print('\n Habits');
    print(TableFormatter.formatHabits(habits.map((h) {
      return {
        'id': h.id,
        'name': h['name'],
        'streak': h['streak'] ?? 0,
        'lastCompleted': h['lastCompleted'],
        'completedToday': h['completedToday'] ?? false,
      };
    }).toList()));
  }

  Future<void> _check(ArgResults args) async {
    final name = args.command?.rest.firstOrNull;
    if (name == null) { print('Usage: habit check <name>'); return; }
    final habits = await firestore.getTodayHabits();
    final doc = habits.docs.firstWhere((h) => (h.data()['name'] ?? '').toLowerCase() == name.toLowerCase(), orElse: () => throw Exception('Habit not found'));
    await firestore.checkHabit(doc.id);
    print('✅ Habit checked: $name');
  }

  Future<void> _streak(ArgResults args) async {
    final name = args.command?.rest.firstOrNull;
    if (name == null) { print('Usage: habit streak <name>'); return; }
    print('🔗 Streak feature requires analytics endpoint (not yet implemented).');
  }
}
