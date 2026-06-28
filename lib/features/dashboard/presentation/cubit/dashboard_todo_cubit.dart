import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_todo_state.dart';
import '../../../todo/data/models/todo_list_model.dart';

class DashboardTodoCubit extends Cubit<DashboardTodoState> {
  DashboardTodoCubit({
    required this.getTodoListsByDate,
  }) : super(DashboardTodoInitial());

  final Future<List<TodoListModel>> Function(DateTime date) getTodoListsByDate;
  Timer? _retryTimer;

  Future<void> loadTodayChecklists() async {
    emit(DashboardTodoLoading());
    try {
      final allLists = await getTodoListsByDate(DateTime.now());
      final openItems = <OpenChecklistItem>[];
      for (final list in allLists) {
        if (list.completionPct < 100) {
          final checked = list.items.where((i) => i.isCompleted).length;
          openItems.add(
            OpenChecklistItem(
              parentId: list.parentId,
              parentType: list.parentType,
              parentName: list.parentId,
              checkedCount: checked,
              totalCount: list.items.length,
              completionPct: list.completionPct,
              route: _buildRoute(list.parentId, list.parentType),
            ),
          );
        }
      }
      final score = allLists.isEmpty
          ? 100.0
          : allLists.map((l) => l.completionPct).reduce((a, b) => a + b) /
                allLists.length;
      emit(DashboardTodoLoaded(
        openItems: openItems,
        checklistScore: score.clamp(0.0, 100.0),
        allComplete: openItems.isEmpty,
      ));
    } catch (e) {
      emit(DashboardTodoError(
        e.toString().replaceAll('Exception: ', ''),
        loadTodayChecklists,
      ));
    }
  }

  Future<void> refresh() => loadTodayChecklists();

  String _buildRoute(String parentId, String parentType) {
    switch (parentType) {
      case 'habit':
        return '/habits/detail/$parentId';
      case 'domain_log':
      case 'domain_session':
        return '/domains/log/$parentId';
      case 'routine_block':
        return '/routines/detail/$parentId';
      default:
        return '/home';
    }
  }

  @override
  Future<void> close() async {
    _retryTimer?.cancel();
    return super.close();
  }
}
