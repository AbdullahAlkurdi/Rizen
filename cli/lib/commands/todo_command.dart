import 'package:args/args.dart';
import 'package:rizen_cli/services/firestore_service.dart';
import 'package:rizen_cli/services/table_formatter.dart';

class TodoCommand extends BaseCommand {
  TodoCommand(super.firestore);

  @override
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
        print('Usage: todo list --habit <name> | todo check <habit> <item> | todo uncheck <habit> <item>');
    }
  }

  Future<void> _list(ArgResults args) async {
    final habit = args['habit'] as String?;
    if (habit == null) { print('Usage: todo list --habit <name>'); return; }
    final todos = await firestore.getTodos(habit);
    print('\n📋 Todos for $habit');
    print(TableFormatter.formatTodos(todos.docs.map((d) {
      final data = d.data();
      data['id'] = d.id;
      return data;
    }).toList()));
  }

  Future<void> _check(ArgResults args) async {
    final parts = args.command?.rest;
    if (parts == null || parts.length < 2) { print('Usage: todo check <habit> <item>'); return; }
    final habit = parts[0];
    final item = parts[1];
    final todos = await firestore.getTodos(habit);
    final doc = todos.docs.firstWhere((d) => (d.data()['title'] ?? '').toLowerCase() == item.toLowerCase(), orElse: () => throw Exception('Item not found'));
    await firestore.checkTodo(habit, doc.id);
    print('✅ Todo checked: $item');
  }

  Future<void> _uncheck(ArgResults args) async {
    print('⚠️ Uncheck feature requires Firestore backend update (not yet implemented).');
  }
}
