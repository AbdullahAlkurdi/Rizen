import 'package:args/args.dart';
import 'package:rizen_cli/services/firestore_service.dart';
import 'package:rizen_cli/services/table_formatter.dart';

class RoutineCommand extends BaseCommand {
  RoutineCommand(super.firestore);

  @override
  Future<void> execute(ArgResults args) async {
    final sub = args.command?.name;

    switch (sub) {
      case 'today':
        await _today();
        break;
      case 'next':
        await _next();
        break;
      default:
        print('Usage: routine today | routine next');
    }
  }

  Future<void> _today() async {
    final routine = await firestore.getTodayRoutine();
    if (routine == null) {
      print('📭 No routine found for today.');
      return;
    }
    final blocks = routine['blocks'] as List? ?? [];
    print('\n📅 Today\'s Routine');
    print(TableFormatter.formatRoutines(blocks.map((b) {
      return {
        'time': b['startTime'] ?? '',
        'title': b['title'] ?? '',
        'done': b['done'] ?? false,
      };
    }).toList()));
  }

  Future<void> _next() async {
    print('⏳ Next block feature requires schedule parsing (not yet implemented).');
  }
}
