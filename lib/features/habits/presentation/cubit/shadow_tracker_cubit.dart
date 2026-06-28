import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/shadow_tracker_repository_interface.dart';
import '../../../todo/domain/usecases/get_missed_items_usecase.dart';

sealed class ShadowTrackerState {}

final class ShadowTrackerInitial extends ShadowTrackerState {}

final class ShadowTrackerLoading extends ShadowTrackerState {}

final class ShadowTrackerLoaded extends ShadowTrackerState {
  ShadowTrackerLoaded({
    required this.totalImpact,
    required this.logs,
    required this.missedItems,
    required this.hasMore,
  });

  final double totalImpact;
  final List<ShadowLog> logs;
  final List<MissedItemFrequency> missedItems;
  final bool hasMore;
}

final class ShadowTrackerLoadingMore extends ShadowTrackerState {
  ShadowTrackerLoadingMore(this.previousState);
  final ShadowTrackerLoaded previousState;
}

final class ShadowTrackerError extends ShadowTrackerState {
  ShadowTrackerError(this.message, this.retry);
  final String message;
  final VoidCallback retry;
}

class MissedItemFrequency {
  MissedItemFrequency({
    required this.title,
    required this.missCount,
    required this.lastMissed,
  });
  final String title;
  final int missCount;
  final DateTime lastMissed;
}

class ShadowTrackerCubit extends Cubit<ShadowTrackerState> {
  ShadowTrackerCubit({
    required ShadowTrackerRepositoryInterface shadowTrackerRepository,
    required GetMissedItemsUseCase getMissedItemsUseCase,
  })  : _shadowTrackerRepository = shadowTrackerRepository,
        _getMissedItemsUseCase = getMissedItemsUseCase,
        super(ShadowTrackerInitial());

  final ShadowTrackerRepositoryInterface _shadowTrackerRepository;
  final GetMissedItemsUseCase _getMissedItemsUseCase;

  DocumentSnapshot? _lastDoc;
  static const int _pageSize = 20;

  Future<void> loadShadowData() async {
    emit(ShadowTrackerLoading());
    try {
      final totalImpact = await _shadowTrackerRepository.getTotalShadowImpact();
      final (logs, lastDoc) = await _shadowTrackerRepository.getShadowLogs(limit: _pageSize);
      _lastDoc = lastDoc;

      final missedItems = await _getMissedItemsUseCase(null, 30);
      final missedFrequencies = missedItems
          .map((e) => MissedItemFrequency(
                title: e.title,
                missCount: e.missCount,
                lastMissed: e.lastMissed,
              ))
          .toList();
      missedFrequencies.sort((a, b) => b.missCount.compareTo(a.missCount));

      emit(ShadowTrackerLoaded(
        totalImpact: totalImpact,
        logs: logs,
        missedItems: missedFrequencies,
        hasMore: logs.length >= _pageSize,
      ));
    } catch (e) {
      emit(ShadowTrackerError(e.toString(), loadShadowData));
    }
  }

  Future<void> loadMore() async {
    final currentState = state;
    if (currentState is! ShadowTrackerLoaded || !currentState.hasMore) return;

    emit(ShadowTrackerLoadingMore(currentState));
    try {
      final (moreLogs, lastDoc) = await _shadowTrackerRepository.getShadowLogs(
        limit: _pageSize,
        startAfter: _lastDoc,
      );
      _lastDoc = lastDoc;

      final updatedLogs = [...currentState.logs, ...moreLogs];
      emit(ShadowTrackerLoaded(
        totalImpact: currentState.totalImpact,
        logs: updatedLogs,
        missedItems: currentState.missedItems,
        hasMore: moreLogs.length >= _pageSize,
      ));
    } catch (e) {
      emit(ShadowTrackerError(e.toString(), loadMore));
    }
  }
}
