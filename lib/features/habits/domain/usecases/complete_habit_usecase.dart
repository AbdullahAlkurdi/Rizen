import '../../../todo/domain/usecases/compute_todo_score_usecase.dart';
import '../../../todo/domain/repositories/todo_repository_interface.dart';
import '../../data/repositories/habits_repository.dart';
import '../../domain/repositories/shadow_tracker_repository_interface.dart';

class CompleteHabitUseCase {
  CompleteHabitUseCase({
    required HabitsRepository habitsRepository,
    required TodoRepositoryInterface todoRepository,
    required ComputeTodoScoreUseCase computeTodoScore,
    required ShadowTrackerRepositoryInterface shadowTrackerRepository,
  })  : _habitsRepository = habitsRepository,
        _todoRepository = todoRepository,
        _computeTodoScore = computeTodoScore,
        _shadowTrackerRepository = shadowTrackerRepository;

  final HabitsRepository _habitsRepository;
  final TodoRepositoryInterface _todoRepository;
  final ComputeTodoScoreUseCase _computeTodoScore;
  final ShadowTrackerRepositoryInterface _shadowTrackerRepository;

  Future<void> call({
    required String habitId,
    required String habitName,
    bool hasTodoList = false,
    String? note,
  }) async {
    await _habitsRepository.createHabitLog(habitId: habitId, note: note);
    
    if (hasTodoList) {
      final todoList = await _todoRepository.getTodoList(habitId, 'habit');
      if (todoList != null) {
        final result = _computeTodoScore(todoList);
        if (result.completionPct < 100) {
          final missedRequired = todoList.items
              .where((item) => item.isRequired && !item.isCompleted)
              .map((item) => item.title)
              .toList();
          
          if (missedRequired.isNotEmpty) {
            await _shadowTrackerRepository.addTodoMissContribution(
              habitId: habitId,
              habitName: habitName,
              missedRequiredItems: missedRequired,
              completionPct: result.completionPct,
              date: DateTime.now(),
            );
          }
        }
      }
    }
  }
}
