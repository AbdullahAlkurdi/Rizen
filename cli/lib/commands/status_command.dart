import 'package:args/args.dart';
import 'package:rizen_cli/services/firestore_service.dart';
import 'package:rizen_cli/services/table_formatter.dart';

class StatusCommand extends BaseCommand {
  StatusCommand(super.firestore);

  @override
  Future<void> execute(ArgResults args) async {
    final habits = await firestore.getTodayHabits();
    final routine = await firestore.getTodayRoutine();
    final sleep = await firestore.getLastSleepLog();
    final growth = await firestore.getGrowthIndex();

    print('\n📊 Today\'s Summary');
    print('==================');

    final completed = habits.where((h) => h['completedToday'] == true).length;
    print('Habits: $completed / ${habits.length} completed');

    if (routine != null) {
      print('Active Routine: ${routine['title'] ?? 'None'}');
    } else {
      print('Active Routine: None');
    }

    if (sleep != null) {
      final bed = sleep['bedTime'] ?? 'Unknown';
      final wake = sleep['wakeTime'] ?? 'Unknown';
      print('Sleep: $bed → $wake');
    } else {
      print('Sleep: No data');
    }

    if (growth != null) {
      final score = growth['score'] ?? 0;
      final bar = TableFormatter.formatProgressBar(score, 100, 20);
      print('Growth Index: $bar $score%');
    } else {
      print('Growth Index: No data');
    }
    print('');
  }
}
