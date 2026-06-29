import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import '../../../../core/interfaces/domain_service_interface.dart';
import '../../../../core/interfaces/habit_service_interface.dart';
import '../../../../core/interfaces/note_service_interface.dart';
import '../../../../features/todo/domain/repositories/todo_repository_interface.dart';
import '../../../../features/todo/domain/usecases/check_todo_item_usecase.dart';
import '../../../../features/todo/domain/usecases/uncheck_todo_item_usecase.dart';
import '../../../../features/habits/domain/usecases/complete_habit_usecase.dart';
import '../services/voice_parse_result.dart';

class VoiceLogOrchestrator {
  final HabitServiceInterface _habitsRepository;
  final DomainServiceInterface _domainLogsRepository;
  final NoteServiceInterface _notesRepository;
  final TodoRepositoryInterface _todoRepository;
  final CompleteHabitUseCase _completeHabitUseCase;
  final CheckTodoItemUseCase _checkTodoItemUseCase;
  final UncheckTodoItemUseCase _uncheckTodoItemUseCase;

  VoiceLogOrchestrator({
    required HabitServiceInterface habitsRepository,
    required DomainServiceInterface domainLogsRepository,
    required NoteServiceInterface notesRepository,
    required TodoRepositoryInterface todoRepository,
    required CompleteHabitUseCase completeHabitUseCase,
    required CheckTodoItemUseCase checkTodoItemUseCase,
    required UncheckTodoItemUseCase uncheckTodoItemUseCase,
  }) : _habitsRepository = habitsRepository,
       _domainLogsRepository = domainLogsRepository,
       _notesRepository = notesRepository,
       _todoRepository = todoRepository,
       _completeHabitUseCase = completeHabitUseCase,
       _checkTodoItemUseCase = checkTodoItemUseCase,
       _uncheckTodoItemUseCase = uncheckTodoItemUseCase;

  Future<VoiceLogSummary> apply(VoiceParseResult result) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null || uid.isEmpty) {
      return VoiceLogSummary(
        domainLogsCreated: 0,
        habitsUpdated: 0,
        todosUpdated: 0,
        reflectionSaved: false,
        unmatched: ['Auth required'],
        sleepNote: null,
      );
    }

    int domainLogsCreated = 0;
    int habitsUpdated = 0;
    int todosUpdated = 0;
    bool reflectionSaved = false;
    final unmatched = <String>[];
    String? sleepNote;

    try {
      for (final entry in result.domainLogs) {
        try {
          if (entry.durationMinutes == null) continue;
          await _domainLogsRepository.addLog(
            domainId: entry.domain,
            duration: entry.durationMinutes!,
            notes: entry.notes,
          );
          domainLogsCreated++;
        } catch (e) {
          unmatched.add('Domain log: ${entry.domain}');
        }
      }
    } catch (e) {
      unmatched.add('Domain logs update failed');
    }

    if (result.sleepNote != null) {
      sleepNote = result.sleepNote;
    }

    try {
      final habits = await _habitsRepository.getAllHabits();

      for (final name in result.habitsCompleted) {
        final match = _findHabit(habits, name);
        if (match != null) {
          try {
            await _completeHabitUseCase.call(
              habitId: match.id,
              habitName: match.name,
              hasTodoList: match.hasTodoList,
            );
            habitsUpdated++;
          } catch (e) {
            unmatched.add('Habit complete: $name');
          }
        } else {
          unmatched.add('Habit complete: $name');
        }
      }

      for (final name in result.habitsMissed) {
        final match = _findHabit(habits, name);
        if (match != null) {
          unmatched.add('missed:$name');
        } else {
          unmatched.add('missed:$name');
        }
      }
    } catch (e) {
      unmatched.add('Habits update failed');
    }

    try {
      final todayLists = await _todoRepository.getTodoListsByDate(
        DateTime.now(),
      );
      final allItems = <Map<String, dynamic>>[];
      for (final list in todayLists) {
        for (final item in list.items) {
          allItems.add({
            'listId': list.id,
            'itemId': item.id,
            'title': item.title,
          });
        }
      }

      for (final title in result.todoChecked) {
        final item = _findTodoItem(allItems, title);
        if (item != null) {
          try {
            await _checkTodoItemUseCase.call(
              item['listId'] as String,
              item['itemId'] as String,
              true,
            );
            todosUpdated++;
          } catch (e) {
            unmatched.add('Todo check: $title');
          }
        } else {
          unmatched.add('Todo check: $title');
        }
      }

      for (final title in result.todoUnchecked) {
        final item = _findTodoItem(allItems, title);
        if (item != null) {
          try {
            await _uncheckTodoItemUseCase.call(
              item['listId'] as String,
              item['itemId'] as String,
            );
            todosUpdated++;
          } catch (e) {
            unmatched.add('Todo uncheck: $title');
          }
        } else {
          unmatched.add('Todo uncheck: $title');
        }
      }
    } catch (e) {
      unmatched.add('Todos update failed');
    }

    if (result.reflection != null) {
      try {
        final title = 'Voice Reflection — ${DateFormat('yyyy-MM-dd').format(DateTime.now())}';
        await _notesRepository.createNote(
          Note(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            uid: uid,
            title: title,
            content: result.reflection!,
            tags: const ['voice', 'reflection'],
            mood: 'neutral',
            loggedAt: DateTime.now(),
          ),
        );
        reflectionSaved = true;
      } catch (e) {
        unmatched.add('Reflection save failed');
      }
    }

    return VoiceLogSummary(
      domainLogsCreated: domainLogsCreated,
      habitsUpdated: habitsUpdated,
      todosUpdated: todosUpdated,
      reflectionSaved: reflectionSaved,
      unmatched: unmatched,
      sleepNote: sleepNote,
    );
  }

  Habit? _findHabit(List<Habit> habits, String query) {
    final lower = query.toLowerCase();
    Habit? bestMatch;
    int bestScore = 0;
    for (final habit in habits) {
      final name = habit.name.toLowerCase();
      if (name == lower) return habit;
      if (name.contains(lower)) {
        final score = lower.length;
        if (score > bestScore) {
          bestScore = score;
          bestMatch = habit;
        }
      }
    }
    return bestMatch;
  }

  Map<String, dynamic>? _findTodoItem(
    List<Map<String, dynamic>> items,
    String query,
  ) {
    final lower = query.toLowerCase();
    Map<String, dynamic>? bestMatch;
    int bestScore = 0;
    for (final item in items) {
      final title = (item['title'] as String).toLowerCase();
      if (title == lower) return item;
      if (title.contains(lower)) {
        final score = lower.length;
        if (score > bestScore) {
          bestScore = score;
          bestMatch = item;
        }
      }
    }
    return bestMatch;
  }
}

class VoiceLogSummary {
  final int domainLogsCreated;
  final int habitsUpdated;
  final int todosUpdated;
  final bool reflectionSaved;
  final List<String> unmatched;
  final String? sleepNote;

  const VoiceLogSummary({
    required this.domainLogsCreated,
    required this.habitsUpdated,
    required this.todosUpdated,
    required this.reflectionSaved,
    required this.unmatched,
    this.sleepNote,
  });
}
