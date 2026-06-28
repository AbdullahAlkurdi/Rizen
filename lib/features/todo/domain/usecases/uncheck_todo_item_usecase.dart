import '../repositories/todo_repository_interface.dart';

class UncheckTodoItemUseCase {
  UncheckTodoItemUseCase(this._repository);

  final TodoRepositoryInterface _repository;

  Future<void> call(String todoListId, String itemId) {
    return _repository.uncheckItem(todoListId, itemId);
  }
}