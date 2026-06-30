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
}
