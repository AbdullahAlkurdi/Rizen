import '../../data/models/todo_list_model.dart';

abstract class TodoRepositoryInterface {
  Future<TodoListModel?> getTodoList(String parentId, String parentType);
  Future<void> saveTodoList(TodoListModel todoList);
  Future<void> checkItem(String todoListId, String itemId, bool checked);
  Future<void> uncheckItem(String todoListId, String itemId);
  Future<void> reorderItems(String todoListId, List<String> orderedIds);
  Future<void> deleteTodoList(String parentId);
  Future<List<TodoListModel>> getTodoListsByDate(DateTime date);
  Future<Map<String, double>> getMissedItemFrequency(
    String parentId, int lastNDays);
}