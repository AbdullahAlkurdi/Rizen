import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/workout_session_model.dart';
import '../../data/repositories/workout_session_repository.dart';

sealed class WorkoutState {}

final class WorkoutInitial extends WorkoutState {}

final class WorkoutLoading extends WorkoutState {}

final class WorkoutLoaded extends WorkoutState {
  final List<WorkoutSession> workouts;
  final WorkoutSession? activeWorkout;
  WorkoutLoaded({required this.workouts, this.activeWorkout});
}

final class WorkoutError extends WorkoutState {
  final String message;
  WorkoutError(this.message);
}

class WorkoutCubit extends Cubit<WorkoutState> {
  final WorkoutSessionRepository repository;

  WorkoutCubit({WorkoutSessionRepository? repository})
    : repository = repository ?? WorkoutSessionRepository(),
      super(WorkoutInitial());

  Future<void> loadWorkouts() async {
    emit(WorkoutLoading());
    try {
      final workouts = await repository.getUserWorkouts();
      emit(WorkoutLoaded(workouts: workouts));
    } catch (e) {
      emit(WorkoutError(e.toString()));
    }
  }

  Future<void> generateWorkout({
    required String goal,
    required int durationMinutes,
    String? injuryNote,
  }) async {
    emit(WorkoutLoading());
    try {
      final exercises = _generateExercises(goal, durationMinutes, injuryNote);
      await repository.createWorkout(
        title: '$goal Workout',
        goal: goal,
        durationMinutes: durationMinutes,
        exercises: exercises,
        generatedBy: 'ai',
      );
      await loadWorkouts();
    } catch (e) {
      emit(WorkoutError(e.toString()));
    }
  }

  List<WorkoutExercise> _generateExercises(
    String goal,
    int durationMinutes,
    String? injuryNote,
  ) {
    final exercises = <WorkoutExercise>[];
    final numExercises = (durationMinutes / 5).round();

    final warmup = ['Jumping Jacks', 'Arm Circles', 'Leg Swings'];

    final main = ['Push-ups', 'Squats', 'Lunges', 'Plank', 'Burpees'];

    final cooldown = ['Stretching', 'Deep Breathing'];

    exercises.add(
      WorkoutExercise(
        name: warmup[0],
        phase: 'warmup',
        durationSeconds: 120,
        restSeconds: 30,
      ),
    );

    for (var i = 0; i < numExercises - 2; i++) {
      exercises.add(
        WorkoutExercise(
          name: main[i % main.length],
          phase: 'main',
          sets: 3,
          reps: 10,
          restSeconds: 60,
        ),
      );
    }

    exercises.add(
      WorkoutExercise(
        name: cooldown[0],
        phase: 'cooldown',
        durationSeconds: 180,
      ),
    );

    return exercises;
  }
}
