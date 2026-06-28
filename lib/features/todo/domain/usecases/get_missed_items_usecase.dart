import '../repositories/todo_repository_interface.dart';

class MissedItem {
  final String title;
  final int missCount;
  final DateTime lastMissed;

  MissedItem({
    required this.title,
    required this.missCount,
    required this.lastMissed,
  });
}

class GetMissedItemsUseCase {
  GetMissedItemsUseCase(this._repository);

  final TodoRepositoryInterface _repository;

  Future<List<MissedItem>> call(String? parentId, int lastNDays) async {
    final frequency = await _repository.getMissedItemFrequency(parentId, lastNDays);
    final now = DateTime.now();
    return frequency.entries
        .where((e) => e.value >= 3)
        .map((e) => MissedItem(
              title: e.key,
              missCount: e.value.toInt(),
              lastMissed: now,
            ))
        .toList();
  }
}