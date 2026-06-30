class TableFormatter {
  static String formatTable(List<List<String>> rows, {List<String>? headers}) {
    final buffer = StringBuffer();
    final widths = <int>[];

    if (headers != null) {
      for (var i = 0; i < headers.length; i++) {
        final cellWidth = headers[i].length;
        if (i < widths.length) {
          widths[i] = cellWidth > widths[i] ? cellWidth : widths[i];
        } else {
          widths.add(cellWidth);
        }
      }
    }

    for (final row in rows) {
      for (var i = 0; i < row.length; i++) {
        final cellWidth = row[i].length;
        if (i < widths.length) {
          widths[i] = cellWidth > widths[i] ? cellWidth : widths[i];
        } else {
          widths.add(cellWidth);
        }
      }
    }

    if (headers != null) {
      buffer.writeln(_formatRow(headers, widths));
      buffer.writeln(widths.map((w) => '-' * w).join('+--+'));
    }

    for (final row in rows) {
      buffer.writeln(_formatRow(row, widths));
    }

    return buffer.toString();
  }

  static String _formatRow(List<String> row, List<int> widths) {
    final cells = <String>[];
    for (var i = 0; i < row.length; i++) {
      final w = i < widths.length ? widths[i] : row[i].length;
      cells.add(row[i].padRight(w));
    }
    return cells.join(' | ');
  }

  static String formatKeyValue(String key, String value) {
    final buffer = StringBuffer();
    final keyCol = '$key:';
    buffer.writeln('${keyCol.padRight(20)} $value');
    return buffer.toString();
  }

  static String formatProgressBar(int current, int total, int width) {
    final fraction = total == 0 ? 0.0 : current / total;
    final filled = (fraction * width).round();
    final empty = width - filled;
    final bar = '█' * filled + '░' * empty;
    return '[$bar]';
  }

  static String formatHabits(List<Map> habits) {
    if (habits.isEmpty) return 'No habits found.';
    final buffer = StringBuffer();
    buffer.writeln('ID         | Name           | Streak | Last Completed');
    buffer.writeln('-----------+----------------+--------+----------------');
    for (final h in habits) {
      final id = '${h['id'] ?? ''}'.padRight(10);
      final name = '${h['name'] ?? ''}'.padRight(15);
      final streak = '${h['streak'] ?? 0}'.padRight(7);
      final last = (h['lastCompleted'] as dynamic)?.toString().split(' ')[0] ?? 'Never';
      buffer.writeln('$id | $name | $streak | $last');
    }
    return buffer.toString();
  }

  static String formatTodos(List<Map> todos) {
    if (todos.isEmpty) return 'No todos found.';
    final buffer = StringBuffer();
    buffer.writeln('ID         | Title                          | Done | Priority');
    buffer.writeln('-----------+--------------------------------+------+----------');
    for (final t in todos) {
      final id = '${t['id'] ?? ''}'.padRight(10);
      final title = '${t['title'] ?? ''}'.padRight(31);
      final done = t['done'] == true ? '✅' : '⬜';
      final priority = '${t['priority'] ?? 'med'}'.padRight(8);
      buffer.writeln('$id | $title | $done | $priority');
    }
    return buffer.toString();
  }

  static String formatRoutines(List<Map> routines) {
    if (routines.isEmpty) return 'No routines found for today.';
    final buffer = StringBuffer();
    buffer.writeln('Time   | Title              | Status');
    buffer.writeln('-------+--------------------+--------');
    for (final r in routines) {
      final time = '${r['time'] ?? ''}'.padRight(6);
      final title = '${r['title'] ?? ''}'.padRight(19);
      final status = r['done'] == true ? '✅' : '⬜';
      buffer.writeln('$time | $title | $status');
    }
    return buffer.toString();
  }

  static String formatAnalytics(Map analytics) {
    final buffer = StringBuffer();
    buffer.writeln('Metric           | Value');
    buffer.writeln('-----------------+-------');
    for (final entry in analytics.entries) {
      final key = '${entry.key}'.padRight(16);
      final value = '${entry.value}';
      buffer.writeln('$key | $value');
    }
    return buffer.toString();
  }
}
