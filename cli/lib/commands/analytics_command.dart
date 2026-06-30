import 'dart:io';
import 'package:args/args.dart';
import 'package:rizen_cli/services/firestore_service.dart';
import 'package:rizen_cli/services/table_formatter.dart';

class AnalyticsCommand {
  final FirestoreService firestore;
  AnalyticsCommand(this.firestore);

  Future<void> execute(ArgResults args) async {
    final sub = args.command?.name;

    switch (sub) {
      case 'growth':
        await _growth();
        break;
      case 'week':
        await _week();
        break;
      default:
        stdout.writeln('Usage: analytics growth | analytics week');
    }
  }

  Future<void> _growth() async {
    final growth = await firestore.getGrowthIndex();
    if (growth == null) {
      stdout.writeln('📭 No growth data available.');
      return;
    }
    final score = growth['score'] ?? 0;
    final burnout = growth['burnoutRisk'] ?? 'low';
    stdout.writeln('\n📈 Growth Index');
    final kv = <String, dynamic>{
      'Score': '$score/100',
      'Burnout Risk': burnout,
      'Domain Balance': '${growth['domainBalance'] ?? 'N/A'}',
    };
    stdout.writeln(TableFormatter.formatAnalytics(kv));
  }

  Future<void> _week() async {
    final stats = await firestore.getTodayDomainStats();
    stdout.writeln('\n📊 Weekly Summary');
    for (final domain in stats.keys) {
      stdout.writeln('  ${domain.toUpperCase()}: ${stats[domain]}m');
    }
  }
}
