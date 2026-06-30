import 'dart:io';
import 'package:args/args.dart';
import 'package:rizen_cli/services/firestore_service.dart';

class LogCommand {
  final FirestoreService firestore;
  LogCommand(this.firestore);

  static const domains = ['sports', 'study', 'work', 'coding', 'nutrition', 'spiritual', 'custom'];

  Future<void> execute(ArgResults args) async {
    final domain = args.rest.firstOrNull?.toLowerCase();
    final duration = args['duration'] as String?;
    final notes = args['notes'] as String?;

    if (domain == null || !domains.contains(domain)) {
      stderr.writeln('❌ Invalid domain. Valid: ${domains.join(", ")}');
      return;
    }

    int minutes = 0;
    if (duration != null) {
      minutes = _parseDuration(duration);
      if (minutes <= 0) {
        stderr.writeln('❌ Invalid duration. Use formats like: 30m, 1h, 1h 30m');
        return;
      }
    }

    await firestore.logDomainSession(domain, minutes, notes ?? '');
    stdout.writeln('✅ Logged $domain${minutes > 0 ? " for ${minutes}m" : ""}');
  }

  int _parseDuration(String input) {
    var total = 0;
    final hours = RegExp(r'(\d+)\s*h').firstMatch(input);
    final mins = RegExp(r'(\d+)\s*m').firstMatch(input);
    if (hours != null) total += int.parse(hours.group(1)!) * 60;
    if (mins != null) total += int.parse(mins.group(1)!);
    return total;
  }
}
