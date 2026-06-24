import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/routine_model.dart';
import '../../data/repositories/routine_repository.dart';

class RoutineState extends Equatable {
  final List<Routine> routines;
  final List<TimeBlock> activeTimeBlocks;
  final Routine? selectedRoutine;
  final List<TimeBlock> selectedTimeBlocks;
  final bool isLoading;
  final String? error;

  const RoutineState({
    this.routines = const [],
    this.activeTimeBlocks = const [],
    this.selectedRoutine,
    this.selectedTimeBlocks = const [],
    this.isLoading = false,
    this.error,
  });

  RoutineState copyWith({
    List<Routine>? routines,
    List<TimeBlock>? activeTimeBlocks,
    Routine? selectedRoutine,
    List<TimeBlock>? selectedTimeBlocks,
    bool? isLoading,
    String? error,
  }) {
    return RoutineState(
      routines: routines ?? this.routines,
      activeTimeBlocks: activeTimeBlocks ?? this.activeTimeBlocks,
      selectedRoutine: selectedRoutine ?? this.selectedRoutine,
      selectedTimeBlocks: selectedTimeBlocks ?? this.selectedTimeBlocks,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    routines,
    activeTimeBlocks,
    selectedRoutine,
    selectedTimeBlocks,
    isLoading,
    error,
  ];

  factory RoutineState.initial() => const RoutineState();
  factory RoutineState.loading() => const RoutineState(isLoading: true);
  factory RoutineState.loaded(
    List<Routine> routines,
    List<TimeBlock> activeBlocks,
  ) => RoutineState(routines: routines, activeTimeBlocks: activeBlocks);
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

  Future<String> createRoutine(String title, String description) async {
    try {
      return await repository.createRoutine(
        title: title,
        description: description,
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
      rethrow;
    }
  }

  Future<String?> generateRoutineFromPrompt(String prompt) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final title = 'AI Generated Routine';
      final routineId = await repository.createRoutine(
        title: title,
        description: prompt,
      );

      final suggestedBlocks = _parsePromptToBlocks(prompt);
      for (final block in suggestedBlocks) {
        await repository.createTimeBlock(
          routineId: routineId,
          title: block.title,
          domainId: block.domainId,
          startTime: block.startTime,
          endTime: block.endTime,
          anchor: TimeBlockAnchor.exact,
        );
      }

      final createdBlocks = await repository.getTimeBlocks(routineId);

      emit(
        state.copyWith(
          selectedRoutine: Routine(
            id: routineId,
            title: title,
            description: prompt,
            isEnabled: true,
            timeBlockIds: createdBlocks.map((b) => b.id).toList(),
            createdAt: DateTime.now(),
          ),
          selectedTimeBlocks: createdBlocks,
          isLoading: false,
        ),
      );
      return routineId;
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
      return null;
    }
  }

  List<_ParsedBlock> _parsePromptToBlocks(String prompt) {
    final lower = prompt.toLowerCase();
    final blocks = <_ParsedBlock>[
      _ParsedBlock(
        'Morning Reflection & Planning',
        6 * 60,
        6 * 60 + 30,
        'spiritual',
      ),
    ];

    if (lower.contains('coding') ||
        lower.contains('code') ||
        lower.contains('programming')) {
      blocks.add(_ParsedBlock('Coding Session', 7 * 60, 9 * 60, 'coding'));
    }
    if (lower.contains('prayer') ||
        lower.contains('spiritual') ||
        lower.contains('islamic')) {
      blocks.add(
        _ParsedBlock('Prayer & Dhuhr Break', 12 * 60, 13 * 60, 'spiritual'),
      );
    }
    if (lower.contains('work') ||
        lower.contains('meeting') ||
        lower.contains('office')) {
      blocks.add(_ParsedBlock('Work Block', 9 * 60 + 30, 12 * 60 + 30, 'work'));
    }
    if (lower.contains('sport') ||
        lower.contains('gym') ||
        lower.contains('workout') ||
        lower.contains('exercise')) {
      blocks.add(_ParsedBlock('Workout Session', 17 * 60, 18 * 60, 'sports'));
    }
    if (lower.contains('study') ||
        lower.contains('read') ||
        lower.contains('learn')) {
      blocks.add(
        _ParsedBlock('Study & Reading', 13 * 60 + 30, 16 * 60, 'study'),
      );
    }
    if (lower.contains('cook') ||
        lower.contains('meal') ||
        lower.contains('breakfast') ||
        lower.contains('lunch')) {
      blocks.add(
        _ParsedBlock('Meal Prep & Breaks', 12 * 60, 13 * 60, 'cooking'),
      );
    }

    if (blocks.length == 1) {
      blocks.add(_ParsedBlock('Deep Focus Block', 9 * 60, 12 * 60, 'work'));
    }

    blocks.add(_ParsedBlock('Evening Wind-down', 21 * 60, 22 * 60, 'custom'));
    return blocks;
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

  Future<void> loadRoutineDetail(String routineId) async {
    emit(state.copyWith(isLoading: true, error: null, selectedRoutine: null));
    try {
      final routine = await repository.getRoutineById(routineId);
      emit(state.copyWith(selectedRoutine: routine, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> loadTimeBlocks(String routineId) async {
    emit(state.copyWith(isLoading: true, error: null, selectedTimeBlocks: []));
    try {
      final blocks = await repository.getTimeBlocks(routineId);
      emit(state.copyWith(selectedTimeBlocks: blocks, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> updateRoutineDetails({
    required String routineId,
    required String title,
    required String description,
    String frequency = 'daily',
  }) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await repository.updateRoutine(
        routineId: routineId,
        updates: {
          'title': title,
          'description': description,
          'frequency': frequency,
          'updatedAt': FieldValue.serverTimestamp(),
        },
      );
      await loadRoutineDetail(routineId);
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> addTimeBlock({
    required String routineId,
    required String title,
    required String domainId,
    required int startTime,
    required int endTime,
    String? description,
    required TimeBlockAnchor anchor,
  }) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await repository.createTimeBlock(
        routineId: routineId,
        title: title,
        domainId: domainId,
        startTime: startTime,
        endTime: endTime,
        anchor: anchor,
        description: description,
      );
      await loadTimeBlocks(routineId);
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> updateTimeBlock({
    required String routineId,
    required String blockId,
    required Map<String, dynamic> updates,
  }) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await repository.updateTimeBlock(
        routineId: routineId,
        blockId: blockId,
        updates: updates,
      );
      await loadTimeBlocks(routineId);
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> deleteTimeBlock({
    required String routineId,
    required String blockId,
  }) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await repository.deleteTimeBlock(routineId: routineId, blockId: blockId);
      await loadTimeBlocks(routineId);
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
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

class _ParsedBlock {
  const _ParsedBlock(this.title, this.startTime, this.endTime, this.domainId);
  final String title;
  final int startTime;
  final int endTime;
  final String domainId;
}
