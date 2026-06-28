import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/todo_cubit.dart';
import '../cubit/todo_state.dart';
import '../../data/models/todo_item_model.dart';
import '../../domain/usecases/get_todo_list_usecase.dart';
import '../../domain/usecases/save_todo_list_usecase.dart';
import '../../domain/usecases/check_todo_item_usecase.dart';
import '../../domain/usecases/uncheck_todo_item_usecase.dart';
import '../../domain/usecases/compute_todo_score_usecase.dart';

class TodoChecklistWidget extends StatelessWidget {
  const TodoChecklistWidget({
    super.key,
    required this.parentId,
    required this.parentType,
    this.readOnly = false,
    this.onCompletionChanged,
  });

  final String parentId;
  final String parentType;
  final bool readOnly;
  final VoidCallback? onCompletionChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoCubit(
        getTodoList: context.read<GetTodoListUseCase>(),
        saveTodoList: context.read<SaveTodoListUseCase>(),
        checkItem: context.read<CheckTodoItemUseCase>(),
        uncheckItem: context.read<UncheckTodoItemUseCase>(),
        computeScore: context.read<ComputeTodoScoreUseCase>(),
      )..loadTodoList(parentId, parentType),
      child: _TodoChecklistView(
        readOnly: readOnly,
        onCompletionChanged: onCompletionChanged,
      ),
    );
  }
}

class _TodoChecklistView extends StatelessWidget {
  const _TodoChecklistView({
    this.readOnly = false,
    this.onCompletionChanged,
  });

  final bool readOnly;
  final VoidCallback? onCompletionChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, TodoState>(
      builder: (context, state) {
        if (state is TodoLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is TodoLoaded) {
          final todoList = state.todoList;
          final completed =
              todoList.items.where((i) => i.isCompleted).length;
          final total = todoList.items.length;
          final pct = todoList.completionPct;
          final threshold = todoList.completionThreshold;

          Color progressColor;
          if (pct >= 100) {
            progressColor = Colors.green;
          } else if (pct >= threshold) {
            progressColor = Colors.amber;
          } else {
            progressColor = Colors.red;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                value: pct / 100,
                backgroundColor: Colors.grey[700],
                color: progressColor,
                minHeight: 6,
              ),
              const SizedBox(height: 4),
              Text(
                '$completed / $total completed',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              if (todoList.items.isEmpty)
                const Text('No checklist items.')
              else
                ...todoList.items.map(
                  (item) => _buildItemRow(context, item, todoList.id),
                ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildItemRow(
    BuildContext context,
    TodoItemModel item,
    String todoListId,
  ) {
    return ListTile(
      key: ValueKey(item.id),
      leading: item.isRequired
          ? const Icon(Icons.circle, size: 8, color: Colors.amber)
          : const SizedBox(width: 8),
      trailing: readOnly
          ? (item.isCompleted
              ? const Icon(Icons.check_circle, color: Colors.green)
              : const Icon(Icons.radio_button_unchecked))
          : Switch(
              value: item.isCompleted,
              onChanged: (checked) {
                if (checked) {
                  context.read<TodoCubit>().checkItem(todoListId, item.id);
                } else {
                  context.read<TodoCubit>().uncheckItem(todoListId, item.id);
                }
                onCompletionChanged?.call();
              },
            ),
      title: Text(
        item.title,
        style: TextStyle(
          decoration: item.isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: item.note != null ? Text(item.note!) : null,
    );
  }
}