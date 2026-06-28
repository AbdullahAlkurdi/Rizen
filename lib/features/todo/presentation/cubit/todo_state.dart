import 'package:equatable/equatable.dart';
import '../../data/models/todo_list_model.dart';

sealed class TodoState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class TodoInitial extends TodoState {}

final class TodoLoading extends TodoState {}

final class TodoLoaded extends TodoState {
  TodoLoaded(this.todoList);

  final TodoListModel todoList;

  @override
  List<Object?> get props => [todoList];
}

final class TodoItemChecked extends TodoState {
  TodoItemChecked({
    required this.itemId,
    required this.newPct,
    required this.todoList,
  });

  final String itemId;
  final double newPct;
  final TodoListModel todoList;

  @override
  List<Object?> get props => [itemId, newPct, todoList];
}

final class TodoSaved extends TodoState {}

final class TodoError extends TodoState {
  TodoError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}