import '../../domain/repositories/todo_repository_interface.dart';
import '../datasources/todo_remote_datasource.dart';
import '../models/todo_list_model.dart';

class TodoRepositoryImpl implements TodoRepositoryInterface {
  TodoRepositoryImpl({TodoRemoteDataSource? remoteDataSource})
      : _remoteDataSource = remoteDataSource ?? TodoRemoteDataSourceImpl();

  final TodoRemoteDataSource _remoteDataSource;

  @override
  Future<TodoListModel?> getTodoList(String parentId, String parentType) {
    return _remoteDataSource.getTodoList(parentId, parentType);
  }

  @override
  Future<void> saveTodoList(TodoListModel todoList) {
    return _remoteDataSource.saveTodoList(todoList);
  }

  @override
  Future<void> checkItem(String todoListId, String itemId, bool checked) {
    return _remoteDataSource.checkItem(todoListId, itemId, checked);
  }

  @override
  Future<void> uncheckItem(String todoListId, String itemId) {
    return _remoteDataSource.uncheckItem(todoListId, itemId);
  }

  @override
  Future<void> reorderItems(String todoListId, List<String> orderedIds) {
    return _remoteDataSource.reorderItems(todoListId, orderedIds);
  }

  @override
  Future<void> deleteTodoList(String parentId) {
    return _remoteDataSource.deleteTodoList(parentId);
  }

  @override
  Future<List<TodoListModel>> getTodoListsByDate(DateTime date) {
    return _remoteDataSource.getTodoListsByDate(date);
  }

  @override
  Future<Map<String, double>> getMissedItemFrequency(
      String parentId, int lastNDays) {
    return _remoteDataSource.getMissedItemFrequency(parentId, lastNDays);
  }
}