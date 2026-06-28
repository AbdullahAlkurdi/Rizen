import '../repositories/todo_repository_interface.dart';
import '../../data/models/todo_list_model.dart';

class GetTodoListUseCase {
  GetTodoListUseCase(this._repository);

  final TodoRepositoryInterface _repository;

  Future<TodoListModel?> call(String parentId, String parentType) {
    return _repository.getTodoList(parentId, parentType);
  }
}