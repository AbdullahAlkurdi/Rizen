import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_item_model.freezed.dart';
part 'todo_item_model.g.dart';

@freezed
class TodoItemModel with _$TodoItemModel {
  const factory TodoItemModel({
    required String id,
    required String parentId,
    required String parentType,
    required String title,
    required int order,
    @Default(true) bool isRequired,
    @Default(1.0) double weight,
    @Default(false) bool isCompleted,
    DateTime? completedAt,
    String? note,
    String? date,
  }) = _TodoItemModel;

  const TodoItemModel._();

  factory TodoItemModel.fromJson(Map<String, dynamic> json) =>
      _$TodoItemModelFromJson(json);

  factory TodoItemModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TodoItemModel(
      id: doc.id,
      parentId: data['parent_id'] as String? ?? '',
      parentType: data['parent_type'] as String? ?? '',
      title: data['title'] as String? ?? '',
      order: data['order'] as int? ?? 0,
      isRequired: data['is_required'] as bool? ?? true,
      weight: (data['weight'] as num?)?.toDouble() ?? 1.0,
      isCompleted: data['is_completed'] as bool? ?? false,
      completedAt: (data['completed_at'] as Timestamp?)?.toDate(),
      note: data['note'] as String?,
      date: data['date'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() => {
        'parent_id': parentId,
        'parent_type': parentType,
        'title': title,
        'order': order,
        'is_required': isRequired,
        'weight': weight,
        'is_completed': isCompleted,
        'completed_at': completedAt != null ? Timestamp.fromDate(completedAt!) : null,
        'note': note,
        'date': date,
      };
}