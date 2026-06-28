import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'todo_state.dart';
import '../../domain/usecases/get_todo_list_usecase.dart';
import '../../domain/usecases/save_todo_list_usecase.dart';
import '../../domain/usecases/check_todo_item_usecase.dart';
import '../../domain/usecases/uncheck_todo_item_usecase.dart';
import '../../domain/usecases/compute_todo_score_usecase.dart';
import '../../data/models/todo_list_model.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit({
    required GetTodoListUseCase getTodoList,
    required SaveTodoListUseCase saveTodoList,
    required CheckTodoItemUseCase checkItem,
    required UncheckTodoItemUseCase uncheckItem,
    required ComputeTodoScoreUseCase computeScore,
  })  : _getTodoList = getTodoList,
        _saveTodoList = saveTodoList,
        _checkItem = checkItem,
        _uncheckItem = uncheckItem,
        _computeScore = computeScore,
        super(TodoInitial());

  final GetTodoListUseCase _getTodoList;
  final SaveTodoListUseCase _saveTodoList;
  final CheckTodoItemUseCase _checkItem;
  final UncheckTodoItemUseCase _uncheckItem;
  final ComputeTodoScoreUseCase _computeScore;

  StreamSubscription<TodoListModel?>? _todoSubscription;

  @override
  Future<void> close() async {
    await _todoSubscription?.cancel();
    return super.close();
  }

  Future<void> loadTodoList(String parentId, String parentType) async {
    emit(TodoLoading());
    _todoSubscription?.cancel();
    _todoSubscription = null;

    try {
      _todoSubscription = _getTodoList.stream(parentId, parentType).listen(
        (todoList) {
          if (todoList != null && !isClosed) {
            emit(TodoLoaded(todoList));
          }
        },
        onError: (e) {
          if (!isClosed) emit(TodoError(e.toString()));
        },
      );

      final todoList = await _getTodoList(parentId, parentType);
      if (todoList != null && !isClosed) {
        emit(TodoLoaded(todoList));
      }
    } catch (e) {
      if (!isClosed) emit(TodoError(e.toString()));
    }
  }

  Future<void> saveTodoList(TodoListModel todoList) async {
    try {
      await _saveTodoList(todoList);
      if (!isClosed) emit(TodoSaved());
    } catch (e) {
      if (!isClosed) emit(TodoError(e.toString()));
    }
  }

  Future<void> checkItem(String todoListId, String itemId) async {
    final currentState = state;
    if (currentState is! TodoLoaded) return;

    final oldList = currentState.todoList;
    final updatedItems = currentState.todoList.items.map((item) {
      if (item.id == itemId) {
        return item.copyWith(isCompleted: true, completedAt: DateTime.now());
      }
      return item;
    }).toList();
    final optimisticList = currentState.todoList.copyWith(items: updatedItems);

    emit(TodoItemToggling(itemId));
    emit(TodoLoaded(optimisticList));

    try {
      await _checkItem(todoListId, itemId, true);
    } catch (e) {
      if (!isClosed) {
        emit(TodoLoaded(oldList));
        emit(TodoError('Failed to check item: $e'));
      }
    }
  }

  Future<void> uncheckItem(String todoListId, String itemId) async {
    final currentState = state;
    if (currentState is! TodoLoaded) return;

    final oldList = currentState.todoList;
    final updatedItems = currentState.todoList.items.map((item) {
      if (item.id == itemId) {
        return item.copyWith(isCompleted: false, completedAt: null);
      }
      return item;
    }).toList();
    final optimisticList = currentState.todoList.copyWith(items: updatedItems);

    emit(TodoItemToggling(itemId));
    emit(TodoLoaded(optimisticList));

    try {
      await _uncheckItem(todoListId, itemId);
    } catch (e) {
      if (!isClosed) {
        emit(TodoLoaded(oldList));
        emit(TodoError('Failed to uncheck item: $e'));
      }
    }
  }

  TodoCompletionResult computeScore(TodoListModel todoList) {
    return _computeScore(todoList);
  }
}