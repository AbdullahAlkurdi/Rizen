import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/todo_list_model.dart';

abstract class TodoRemoteDataSource {
  Future<TodoListModel?> getTodoList(String parentId, String parentType);
  Future<void> saveTodoList(TodoListModel todoList);
  Future<void> checkItem(String todoListId, String itemId, bool checked);
  Future<void> uncheckItem(String todoListId, String itemId);
  Future<void> reorderItems(String todoListId, List<String> orderedIds);
  Future<void> deleteTodoList(String parentId);
  Future<List<TodoListModel>> getTodoListsByDate(DateTime date);
  Future<Map<String, double>> getMissedItemFrequency(
    String parentId, int lastNDays);
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  TodoRemoteDataSourceImpl({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  String get _uid {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');
    return user.uid;
  }

  CollectionReference get _todoListsCollection =>
      _firestore.collection('users').doc(_uid).collection('todo_lists');

  @override
  Future<TodoListModel?> getTodoList(String parentId, String parentType) async {
    final doc = await _todoListsCollection.doc(parentId).get();
    if (!doc.exists) return null;
    return TodoListModel.fromFirestore(doc);
  }

  @override
  Future<void> saveTodoList(TodoListModel todoList) async {
    await _todoListsCollection.doc(todoList.parentId).set(todoList.toFirestore());
  }

  @override
  Future<void> checkItem(
      String todoListId, String itemId, bool checked) async {
    final todoList = await getTodoList(todoListId, 'habit');
    if (todoList == null) return;
    final updatedItems = todoList.items.map((item) {
      if (item.id == itemId) {
        return item.copyWith(
          isCompleted: checked,
          completedAt: checked ? DateTime.now() : null,
        );
      }
      return item;
    }).toList();
    final updatedList = todoList.copyWith(items: updatedItems);
    await saveTodoList(updatedList);
  }

  @override
  Future<void> uncheckItem(String todoListId, String itemId) async {
    await checkItem(todoListId, itemId, false);
  }

  @override
  Future<void> reorderItems(String todoListId, List<String> orderedIds) async {
    final todoList = await getTodoList(todoListId, 'habit');
    if (todoList == null) return;
    final updatedItems = orderedIds.asMap().entries.map((entry) {
      final index = entry.key;
      final id = entry.value;
      final item = todoList.items.firstWhere((i) => i.id == id);
      return item.copyWith(order: index);
    }).toList();
    await saveTodoList(todoList.copyWith(items: updatedItems));
  }

  @override
  Future<void> deleteTodoList(String parentId) async {
    await _todoListsCollection.doc(parentId).delete();
  }

  @override
  Future<List<TodoListModel>> getTodoListsByDate(DateTime date) async {
    final dateStr = date.toIso8601String().substring(0, 10);
    final snapshot = await _todoListsCollection
        .where('date', isEqualTo: dateStr)
        .get();
    return snapshot.docs.map((doc) => TodoListModel.fromFirestore(doc)).toList();
  }

  @override
  Future<Map<String, double>> getMissedItemFrequency(
      String parentId, int lastNDays) async {
    final frequency = <String, double>{};
    final now = DateTime.now();
    for (int i = 0; i < lastNDays; i++) {
      final date = now.subtract(Duration(days: i));
      final dateStr = date.toIso8601String().substring(0, 10);
      final snapshot = await _firestore
          .collection('users')
          .doc(_uid)
          .collection('todo_lists_history')
          .doc(dateStr)
          .collection('items')
          .where('parent_id', isEqualTo: parentId)
          .where('is_completed', isEqualTo: false)
          .get();
      for (final doc in snapshot.docs) {
        final title = doc['title'] as String? ?? '';
        frequency[title] = (frequency[title] ?? 0) + 1;
      }
    }
    return frequency;
  }
}