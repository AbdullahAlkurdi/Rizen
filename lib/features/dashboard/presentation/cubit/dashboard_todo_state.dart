import 'package:flutter/foundation.dart';

class OpenChecklistItem {
  const OpenChecklistItem({
    required this.parentId,
    required this.parentType,
    required this.parentName,
    required this.checkedCount,
    required this.totalCount,
    required this.completionPct,
    required this.route,
  });

  final String parentId;
  final String parentType;
  final String parentName;
  final int checkedCount;
  final int totalCount;
  final double completionPct;
  final String route;
}

sealed class DashboardTodoState {}

final class DashboardTodoInitial extends DashboardTodoState {}

final class DashboardTodoLoading extends DashboardTodoState {}

final class DashboardTodoLoaded extends DashboardTodoState {
  DashboardTodoLoaded({
    required this.openItems,
    required this.checklistScore,
    required this.allComplete,
  });

  final List<OpenChecklistItem> openItems;
  final double checklistScore;
  final bool allComplete;
}

final class DashboardTodoError extends DashboardTodoState {
  DashboardTodoError(this.message, this.retry);

  final String message;
  final VoidCallback retry;
}
