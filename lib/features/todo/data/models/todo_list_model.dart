import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'todo_item_model.dart';

part 'todo_list_model.freezed.dart';
part 'todo_list_model.g.dart';

enum TodoStatus { complete, partial, incomplete, missed, pending }

@freezed
class TodoListModel with _$TodoListModel {
  const TodoListModel._();

  const factory TodoListModel({
    required String id,
    required String parentId,
    required String parentType,
    required List<TodoItemModel> items,
    @Default(70) int completionThreshold,
    @Default(0.0) double completionPct,
  }) = _TodoListModel;

  factory TodoListModel.fromJson(Map<String, dynamic> json) =>
      _$TodoListModelFromJson(json);

  factory TodoListModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final itemsData = data['items'] as List<dynamic>? ?? [];
    final items = itemsData
        .map((e) => TodoItemModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return TodoListModel(
      id: doc.id,
      parentId: data['parent_id'] as String? ?? '',
      parentType: data['parent_type'] as String? ?? '',
      items: items,
      completionThreshold: data['completion_threshold'] as int? ?? 70,
      completionPct: (data['completion_pct'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toFirestore() => {
        'parent_id': parentId,
        'parent_type': parentType,
        'items': items.map((e) => e.toFirestore()).toList(),
        'completion_threshold': completionThreshold,
        'completion_pct': completionPct,
        'created_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
      };

  TodoListModel withCompletionPct(double pct) => copyWith(completionPct: pct);

  TodoStatus get computedStatus {
    final pct = completionPct;
    if (pct >= 100) return TodoStatus.complete;
    if (pct >= completionThreshold) return TodoStatus.partial;
    if (pct > 0) return TodoStatus.incomplete;
    return TodoStatus.missed;
  }
}