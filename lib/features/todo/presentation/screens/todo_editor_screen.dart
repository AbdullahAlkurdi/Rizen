import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../../data/models/todo_item_model.dart';
import '../../data/models/todo_list_model.dart';
import '../../../../core/tutorials/tutorial_mixin.dart';
import '../../../../core/services/tutorial_service.dart';
import '../../../../core/tutorials/rizen_tutorial.dart';
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

class _TodoEditorScreenState extends State<TodoEditorScreen> with TutorialMixin {
  @override
  String get tutorialKey => TutorialService.keys['todo_editor']!;

  @override
  List<TargetFocus> buildTargets() => RizenTutorial.todoEditor(_tutorialKeys);

  final Map<String, GlobalKey> _tutorialKeys = {
    'items': GlobalKey(),
    'threshold': GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    _loadTodoList();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) maybeShowTutorial();
    });
  }

  List<TodoItemModel> _items = [];
  int _threshold = 70;

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
          IconButton(
            onPressed: showTutorialNow,
            icon: const Icon(PhosphorIconsBold.question),
            color: const Color(0xFF9CA3AF),
            tooltip: 'Help',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          key: _tutorialKeys['items'],
          child: TodoBuilderWidget(
            initialItems: _items,
            initialThreshold: _threshold,
            onChanged: (items) {
              setState(() => _items = items);
            },
          ),
        ),
      ),
    );
  }
}