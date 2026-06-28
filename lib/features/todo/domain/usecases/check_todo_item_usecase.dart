import '../repositories/todo_repository_interface.dart';

class CheckTodoItemUseCase {
  CheckTodoItemUseCase(this._repository);

  final TodoRepositoryInterface _repository;

  Future<void> call(String todoListId, String itemId, bool checked) {
    return _repository.checkItem(todoListId, itemId, checked);
  }
}