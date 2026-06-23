import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/routine_model.dart';
import '../../data/repositories/routine_repository.dart';

class RoutineState extends Equatable {
  final List<Routine> routines;
  final List<TimeBlock> activeTimeBlocks;
  final bool isLoading;
  final String? error;

  const RoutineState({
    this.routines = const [],
    this.activeTimeBlocks = const [],
    this.isLoading = false,
    this.error,
  });

  RoutineState copyWith({
    List<Routine>? routines,
    List<TimeBlock>? activeTimeBlocks,
    bool? isLoading,
    String? error,
  }) {
    return RoutineState(
      routines: routines ?? this.routines,
      activeTimeBlocks: activeTimeBlocks ?? this.activeTimeBlocks,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [routines, activeTimeBlocks, isLoading, error];

  factory RoutineState.initial() => const RoutineState();
  factory RoutineState.loading() => const RoutineState(isLoading: true);
  factory RoutineState.loaded(List<Routine> routines, List<TimeBlock> activeBlocks) =>
      RoutineState(routines: routines, activeTimeBlocks: activeBlocks);
  factory RoutineState.error(String message) => RoutineState(error: message);
}

class RoutineCubit extends Cubit<RoutineState> {
  final RoutineRepository repository;

  RoutineCubit(this.repository) : super(RoutineState.initial());

  Future<void> loadRoutines() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final routines = await repository.getAllRoutines();
      final activeBlocks = <TimeBlock>[];
      final nowMinutes = DateTime.now().hour * 60 + DateTime.now().minute;

      for (final routine in routines.where((r) => r.isEnabled)) {
        final blocks = await repository.getTimeBlocks(routine.id);
        for (final block in blocks.where((b) => !b.isCompleted)) {
          if (block.startTime >= nowMinutes || block.endTime > nowMinutes) {
            activeBlocks.add(block);
          }
        }
      }

      emit(RoutineState(routines: routines, activeTimeBlocks: activeBlocks));
    } catch (e) {
      emit(RoutineState(error: e.toString(), isLoading: false));
    }
  }

  Future<void> createRoutine(String title, String description) async {
    try {
      await repository.createRoutine(title: title, description: description);
      await loadRoutines();
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> toggleRoutine(String routineId, bool isEnabled) async {
    try {
      await repository.updateRoutine(
        routineId: routineId,
        updates: {'isEnabled': isEnabled},
      );
      await loadRoutines();
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> deleteRoutine(String routineId) async {
    try {
      await repository.deleteRoutine(routineId);
      await loadRoutines();
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}