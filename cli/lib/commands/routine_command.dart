import 'dart:io';
import 'package:args/args.dart';
import 'package:rizen_cli/services/firestore_service.dart';
import 'package:rizen_cli/services/table_formatter.dart';

class RoutineCommand {
  final FirestoreService firestore;
  RoutineCommand(this.firestore);

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
        stdout.writeln('Usage: routine today | routine next');
    }
  }

  Future<void> _today() async {
    final routine = await firestore.getTodayRoutine();
    if (routine == null) {
      stdout.writeln('📭 No routine found for today.');
      return;
    }
    final blocks = routine['blocks'] as List? ?? [];
    stdout.writeln('\n📅 Today\'s Routine');
    stdout.writeln(TableFormatter.formatRoutines(blocks.map((b) {
      return {
        'time': b['startTime'] ?? '',
        'title': b['title'] ?? '',
        'done': b['done'] ?? false,
      };
    }).toList()));
  }

  Future<void> _next() async {
    stdout.writeln('⏳ Next block feature requires schedule parsing (not yet implemented).');
  }
}
