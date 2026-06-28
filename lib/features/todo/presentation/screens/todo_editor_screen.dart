import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/todo_item_model.dart';
import '../../data/models/todo_list_model.dart';
import '../widgets/todo_builder_widget.dart';
import '../../domain/usecases/get_todo_list_usecase.dart';
import '../../domain/usecases/save_todo_list_usecase.dart';

class TodoEditorScreen extends StatefulWidget {
  const TodoEditorScreen({
    super.key,
    required this.parentId,
    required this.parentType,
  });

  final String parentId;
  final String parentType;

  @override
  State<TodoEditorScreen> createState() => _TodoEditorScreenState();
}

class _TodoEditorScreenState extends State<TodoEditorScreen> {
  List<TodoItemModel> _items = [];
  int _threshold = 70;

  @override
  void initState() {
    super.initState();
    _loadTodoList();
  }

  Future<void> _loadTodoList() async {
    final todoList = await context.read<GetTodoListUseCase>()(
      widget.parentId,
      widget.parentType,
    );
    if (todoList != null) {
      setState(() {
        _items = List.from(todoList.items);
        _threshold = todoList.completionThreshold;
      });
    }
  }

  Future<void> _saveTodoList() async {
    final todoList = TodoListModel(
      id: widget.parentId,
      parentId: widget.parentId,
      parentType: widget.parentType,
      items: _items
          .map((item) => item.copyWith(
                parentId: widget.parentId,
                parentType: widget.parentType,
              ))
          .toList(),
      completionThreshold: _threshold,
    );
    try {
      await context.read<SaveTodoListUseCase>()(todoList);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Saved')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Manage Checklist'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveTodoList,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TodoBuilderWidget(
          initialItems: _items,
          initialThreshold: _threshold,
          onChanged: (items) {
            setState(() => _items = items);
          },
        ),
      ),
    );
  }
}