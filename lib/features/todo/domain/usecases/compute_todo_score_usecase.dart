import '../../data/models/todo_list_model.dart';

class TodoCompletionResult {
  final double completionPct;
  final TodoStatus status;
  final bool streakContinues;
  final int missedRequiredCount;

  TodoCompletionResult({
    required this.completionPct,
    required this.status,
    required this.streakContinues,
    required this.missedRequiredCount,
  });
}

class ComputeTodoScoreUseCase {
  TodoCompletionResult call(TodoListModel todoList) {
    final pct = _computeCompletionPct(todoList);
    
    TodoStatus status;
    if (pct >= 100) {
      status = TodoStatus.complete;
    } else if (pct >= todoList.completionThreshold) {
      status = TodoStatus.partial;
    } else if (pct > 0) {
      status = TodoStatus.incomplete;
    } else {
      status = TodoStatus.missed;
    }
    
    bool streakContinues;
    if (pct >= 100) {
      streakContinues = true;
    } else if (pct >= todoList.completionThreshold) {
      streakContinues = true;
    } else {
      streakContinues = false;
    }
    
    final missedRequiredCount = todoList.items
        .where((item) => item.isRequired && !item.isCompleted)
        .length;
    
    return TodoCompletionResult(
      completionPct: pct,
      status: status,
      streakContinues: streakContinues,
      missedRequiredCount: missedRequiredCount,
    );
  }

  double _computeCompletionPct(TodoListModel todoList) {
    if (todoList.items.isEmpty) return 0.0;
    final totalWeight = todoList.items.fold(0.0, (sum, item) => sum + item.weight);
    final completedWeight = todoList.items
        .where((item) => item.isCompleted)
        .fold(0.0, (sum, item) => sum + item.weight);
    return (completedWeight / totalWeight) * 100;
  }
}