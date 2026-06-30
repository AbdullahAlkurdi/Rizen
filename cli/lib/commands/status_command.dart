import 'dart:io';
import 'package:args/args.dart';
import 'package:rizen_cli/services/firestore_service.dart';
import 'package:rizen_cli/services/table_formatter.dart';

class StatusCommand {
  final FirestoreService firestore;
  StatusCommand(this.firestore);

  Future<void> execute(ArgResults args) async {
    final habits = await firestore.getTodayHabits();
    final routine = await firestore.getTodayRoutine();
    final sleep = await firestore.getLastSleepLog();
    final growth = await firestore.getGrowthIndex();

    stdout.writeln('\n📊 Today\'s Summary');
    stdout.writeln('==================');

    final completed = habits.where((h) => h['completedToday'] == true).length;
    stdout.writeln('Habits: $completed / ${habits.length} completed');

    if (routine != null) {
      stdout.writeln('Active Routine: ${routine['title'] ?? 'None'}');
    } else {
      stdout.writeln('Active Routine: None');
    }

    if (sleep != null) {
      final bed = sleep['bedTime'] ?? 'Unknown';
      final wake = sleep['wakeTime'] ?? 'Unknown';
      stdout.writeln('Sleep: $bed → $wake');
    } else {
      stdout.writeln('Sleep: No data');
    }

    if (growth != null) {
      final score = growth['score'] ?? 0;
      final bar = TableFormatter.formatProgressBar(score, 100, 20);
      stdout.writeln('Growth Index: $bar $score%');
    } else {
      stdout.writeln('Growth Index: No data');
    }
    stdout.writeln('');
  }
}
