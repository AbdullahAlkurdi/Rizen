import 'dart:io';
import 'package:args/args.dart';
import 'package:rizen_cli/services/firestore_service.dart';
import 'package:rizen_cli/services/table_formatter.dart';

class TodoCommand {
  final FirestoreService firestore;
  TodoCommand(this.firestore);

  Future<void> execute(ArgResults args) async {
    final sub = args.command?.name;

    switch (sub) {
      case 'list':
        await _list(args);
        break;
      case 'check':
        await _check(args);
        break;
      case 'uncheck':
        await _uncheck(args);
        break;
      default:
        stdout.writeln('Usage: todo list --habit <name> | todo check <habit> <item> | todo uncheck <habit> <item>');
    }
  }

  Future<void> _list(ArgResults args) async {
    final habit = args['habit'] as String?;
    if (habit == null) { stdout.writeln('Usage: todo list --habit <name>'); return; }
    final todos = await firestore.getTodoItems(habit);
    stdout.writeln('\n📋 Todos for $habit');
    stdout.writeln(TableFormatter.formatTodos(todos.map((t) {
      final data = Map<String, dynamic>.from(t);
      data['id'] = data['id'] ?? '';
      return data;
    }).toList()));
  }

  Future<void> _check(ArgResults args) async {
    final parts = args.command?.rest;
    if (parts == null || parts.length < 2) { stdout.writeln('Usage: todo check <habit> <item>'); return; }
    final habit = parts[0];
    final item = parts[1];
    final todos = await firestore.getTodoItems(habit);
    final doc = todos.firstWhere((t) => (t['title'] ?? '').toLowerCase() == item.toLowerCase(), orElse: () => throw Exception('Item not found'));
    await firestore.checkTodo(habit, doc['id'] ?? '');
    stdout.writeln('✅ Todo checked: $item');
  }

  Future<void> _uncheck(ArgResults args) async {
    stdout.writeln('⚠️ Uncheck feature requires Firestore backend update (not yet implemented).');
  }
}
