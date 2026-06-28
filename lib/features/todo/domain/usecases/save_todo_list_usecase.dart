import '../repositories/todo_repository_interface.dart';
import '../../data/models/todo_list_model.dart';
import 'compute_todo_score_usecase.dart';

class SaveTodoListUseCase {
  SaveTodoListUseCase(this._repository, this._computeScore);

  final TodoRepositoryInterface _repository;
  final ComputeTodoScoreUseCase _computeScore;

  Future<void> call(TodoListModel todoList) async {
    final result = _computeScore(todoList);
    final updatedList = todoList.withCompletionPct(result.completionPct);
    await _repository.saveTodoList(updatedList);
  }
}