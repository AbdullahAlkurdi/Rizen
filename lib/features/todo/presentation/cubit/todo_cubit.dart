import 'package:flutter_bloc/flutter_bloc.dart';
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

  Future<void> loadTodoList(String parentId, String parentType) async {
    emit(TodoLoading());
    try {
      final todoList = await _getTodoList(parentId, parentType);
      if (todoList == null) {
        emit(TodoLoaded(TodoListModel(
          id: parentId,
          parentId: parentId,
          parentType: parentType,
          items: [],
          completionThreshold: 70,
        )));
      } else {
        emit(TodoLoaded(todoList));
      }
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  Future<void> saveTodoList(TodoListModel todoList) async {
    try {
      await _saveTodoList(todoList);
      emit(TodoSaved());
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  Future<void> checkItem(String todoListId, String itemId) async {
    try {
      await _checkItem(todoListId, itemId, true);
      await _reloadList(todoListId);
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  Future<void> uncheckItem(String todoListId, String itemId) async {
    try {
      await _uncheckItem(todoListId, itemId);
      await _reloadList(todoListId);
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  Future<void> _reloadList(String todoListId) async {
    final currentState = state;
    if (currentState is TodoLoaded) {
      final todoList = await _getTodoList(todoListId, currentState.todoList.parentType);
      if (todoList != null) {
        emit(TodoLoaded(todoList));
      }
    }
  }

  TodoCompletionResult computeScore(TodoListModel todoList) {
    return _computeScore(todoList);
  }
}