class TableFormatter {
  static String formatHabits(List<Map<String, dynamic>> habits) {
    if (habits.isEmpty) return 'No habits found.';
    final buffer = StringBuffer();
    buffer.writeln('ID         | Name           | Streak | Last Completed');
    buffer.writeln('-----------+----------------+--------+----------------');
    for (final h in habits) {
      final id = '${h['id'] ?? ''}'.padRight(10);
      final name = '${h['name'] ?? ''}'.padRight(15);
      final streak = '${h['streak'] ?? 0}'.padRight(7);
      final last = (h['lastCompleted'] as Timestamp?)?.toDate().toString().split(' ')[0] ?? 'Never';
      buffer.writeln('$id | $name | $streak | $last');
    }
    return buffer.toString();
  }

  static String formatTodos(List<Map<String, dynamic>> todos) {
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

  static String formatRoutines(List<Map<String, dynamic>> routines) {
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

  static String formatAnalytics(Map<String, dynamic> data) {
    final buffer = StringBuffer();
    buffer.writeln('Metric           | Value');
    buffer.writeln('-----------------+-------');
    for (final entry in data.entries) {
      final key = '${entry.key}'.padRight(16);
      buffer.writeln('$key | ${entry.value}');
    }
    return buffer.toString();
  }
}
    return table.render();
  }

  static String formatTodos(List<Map<String, dynamic>> todos) {
    if (todos.isEmpty) return 'No todos found.';
    final table = Table([['ID', 'Title', 'Done', 'Priority']]);
    for (final t in todos) {
      table.addRow([
        t['id'] ?? '',
        t['title'] ?? '',
        t['done'] == true ? '✅' : '⬜',
        '${t['priority'] ?? 'med'}',
      ]);
    }
    return table.render();
  }

  static String formatRoutines(List<Map<String, dynamic>> routines) {
    if (routines.isEmpty) return 'No routines found for today.';
    final table = Table([['Time', 'Title', 'Status']]);
    for (final r in routines) {
      table.addRow([
        r['time'] ?? '',
        r['title'] ?? '',
        r['done'] == true ? '✅' : '⬜',
      ]);
    }
    return table.render();
  }

  static String formatAnalytics(Map<String, dynamic> data) {
    final rows = <List<String>>[];
    rows.add(['Metric', 'Value']);
    for (final entry in data.entries) {
      rows.add([entry.key, '${entry.value}']);
    }
    final table = Table(rows);
    return table.render();
  }
}
