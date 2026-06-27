import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/adhkar_session.dart';
import '../../data/models/dua_item_model.dart';
import '../../data/models/quran_log_model.dart';
import '../../data/repositories/spiritual_repository.dart';

sealed class SpiritualState {}

final class SpiritualInitial extends SpiritualState {}

final class SpiritualLoading extends SpiritualState {}

final class SpiritualQuranLoaded extends SpiritualState {
  SpiritualQuranLoaded({
    required this.todayLog,
    required this.cumulativePages,
    required this.streak,
    required this.weeklyPages,
  });

  final QuranLog? todayLog;
  final int cumulativePages;
  final int streak;
  final int weeklyPages;
}

final class SpiritualAdhkarLoaded extends SpiritualState {
  SpiritualAdhkarLoaded({
    required this.adhkarItems,
    required this.completedIds,
    required this.session,
  });

  final List<AdhkarItem> adhkarItems;
  final List<String> completedIds;
  final AdhkarSession session;
}

final class SpiritualDuaLoaded extends SpiritualState {
  SpiritualDuaLoaded({
    required this.duas,
    required this.favoriteIds,
    required this.occasionFilter,
  });

  final List<DuaItem> duas;
  final List<String> favoriteIds;
  final String? occasionFilter;
}

final class SpiritualSummaryLoaded extends SpiritualState {
  SpiritualSummaryLoaded({
    required this.weeklyQuranPages,
    required this.adhkarCompletionRate,
    required this.consistencyMetric,
    required this.quranStreak,
  });

  final int weeklyQuranPages;
  final double adhkarCompletionRate;
  final String consistencyMetric;
  final int quranStreak;
}

final class SpiritualError extends SpiritualState {
  SpiritualError(this.message);
  final String message;
}

class AdhkarItem {
  const AdhkarItem({
    required this.id,
    required this.arabicText,
    required this.transliteration,
    required this.translationAr,
    required this.translationEn,
    required this.count,
  });

  final String id;
  final String arabicText;
  final String transliteration;
  final String translationAr;
  final String translationEn;
  final int count;
}

class SpiritualCubit extends Cubit<SpiritualState> {
  SpiritualCubit({SpiritualRepository? repository})
      : _repository = repository ?? SpiritualRepository(),
        super(SpiritualInitial());

  final SpiritualRepository _repository;

  Future<void> loadQuranTracker() async {
    emit(SpiritualLoading());
    try {
      final todayLog = await _repository.getTodayQuranLog();
      final allLogs = await _fetchAllQuranLogs();
      final cumulativePages = allLogs.fold<int>(0, (sum, log) => sum + log.pagesRead);
      final streak = await _calculateStreak(allLogs);
      final weeklyPages = _calculateWeeklyPages(allLogs);

      emit(SpiritualQuranLoaded(
        todayLog: todayLog,
        cumulativePages: cumulativePages,
        streak: streak,
        weeklyPages: weeklyPages,
      ));
    } catch (e) {
      emit(SpiritualError(e.toString()));
    }
  }

  Future<void> logQuranPages(int pages) async {
    try {
      await _repository.logQuranPages(pages: pages);
      await loadQuranTracker();
    } catch (e) {
      emit(SpiritualError(e.toString()));
    }
  }

  Future<void> loadAdhkarChecklist(AdhkarSession session) async {
    emit(SpiritualLoading());
    try {
      final adhkarData = await _loadAdhkarForSession(session);
      final completedIds = await _repository.getTodayAdhkarLog(session) ?? [];

      emit(SpiritualAdhkarLoaded(
        adhkarItems: adhkarData,
        completedIds: completedIds,
        session: session,
      ));
    } catch (e) {
      emit(SpiritualError(e.toString()));
    }
  }

  Future<void> logAdhkarCompletion({
    required AdhkarSession session,
    required List<String> completedIds,
  }) async {
    try {
      await _repository.logAdhkarCompletion(
        session: session,
        completedIds: completedIds,
      );
      await loadAdhkarChecklist(session);
    } catch (e) {
      emit(SpiritualError(e.toString()));
    }
  }

  Future<void> loadDuaLibrary({String? occasionFilter}) async {
    emit(SpiritualLoading());
    try {
      final duas = await _repository.getDuaLibrary(occasionFilter: occasionFilter);
      final favoriteIds = await _repository.getFavoriteIds();

      emit(SpiritualDuaLoaded(
        duas: duas,
        favoriteIds: favoriteIds,
        occasionFilter: occasionFilter,
      ));
    } catch (e) {
      emit(SpiritualError(e.toString()));
    }
  }

  Future<void> toggleDuaFavorite(String duaId) async {
    try {
      await _repository.toggleDuaFavorite(duaId);
      final current = state;
      if (current is SpiritualDuaLoaded) {
        final favorites = List<String>.from(current.favoriteIds);
        if (favorites.contains(duaId)) {
          favorites.remove(duaId);
        } else {
          favorites.add(duaId);
        }
        emit(SpiritualDuaLoaded(
          duas: current.duas,
          favoriteIds: favorites,
          occasionFilter: current.occasionFilter,
        ));
      }
    } catch (e) {
      emit(SpiritualError(e.toString()));
    }
  }

  Future<void> loadSpiritualSummary() async {
    emit(SpiritualLoading());
    try {
      final allQuranLogs = await _fetchAllQuranLogs();
      final weeklyQuranPages = _calculateWeeklyPages(allQuranLogs);
      final quranStreak = await _calculateStreak(allQuranLogs);

      final morningIds = await _repository.getTodayAdhkarLog(AdhkarSession.morning) ?? [];
      final eveningIds = await _repository.getTodayAdhkarLog(AdhkarSession.evening) ?? [];
      final morningTotal = (await _loadAdhkarForSession(AdhkarSession.morning)).length;
      final eveningTotal = (await _loadAdhkarForSession(AdhkarSession.evening)).length;
      final totalCompleted = morningIds.length + eveningIds.length;
      final totalItems = morningTotal + eveningTotal;
      final adhkarCompletionRate = totalItems == 0 ? 0.0 : totalCompleted / totalItems;

      String consistencyMetric;
      if (quranStreak >= 7 && adhkarCompletionRate >= 0.8) {
        consistencyMetric = 'Excellent';
      } else if (quranStreak >= 3 || adhkarCompletionRate >= 0.5) {
        consistencyMetric = 'Good';
      } else if (quranStreak >= 1 || adhkarCompletionRate > 0) {
        consistencyMetric = 'Building';
      } else {
        consistencyMetric = 'Start today';
      }

      emit(SpiritualSummaryLoaded(
        weeklyQuranPages: weeklyQuranPages,
        adhkarCompletionRate: adhkarCompletionRate,
        consistencyMetric: consistencyMetric,
        quranStreak: quranStreak,
      ));
    } catch (e) {
      emit(SpiritualError(e.toString()));
    }
  }

  Future<List<QuranLog>> _fetchAllQuranLogs() async {
    final snapshot = await _repository.firestore
        .collection('quran_logs')
        .where('uid', isEqualTo: _repository.userId)
        .get();

    return snapshot.docs.map(QuranLog.fromFirestore).toList();
  }

  Future<int> _calculateStreak(List<QuranLog> logs) async {
    if (logs.isEmpty) return 0;
    final dates = logs
        .map((l) => DateTime(l.loggedAt.year, l.loggedAt.month, l.loggedAt.day))
        .toSet()
        .toList()
      ..sort((a, b) => b.compareTo(a));

    int streak = 0;
    DateTime checkDate = DateTime.now();
    for (final date in dates) {
      final diff = checkDate.difference(date).inDays;
      if (diff == 0 || (diff == 1 && checkDate.day != date.day)) {
        streak++;
        checkDate = date;
      } else if (diff > 1) {
        break;
      }
    }
    return streak;
  }

  int _calculateWeeklyPages(List<QuranLog> logs) {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final startOfWeek = DateTime(weekStart.year, weekStart.month, weekStart.day);

    return logs
        .where((l) => l.loggedAt.isAfter(startOfWeek) || l.loggedAt.isAtSameMomentAs(startOfWeek))
        .fold(0, (sum, l) => sum + l.pagesRead);
  }

  Future<List<AdhkarItem>> _loadAdhkarForSession(AdhkarSession session) async {
    final jsonString = await rootBundle.loadString('assets/data/adhkar.json');
    final Map<String, dynamic> json = jsonDecode(jsonString);
    final List<dynamic> items = json[session.name] ?? [];
    return items
        .map((e) => AdhkarItem(
              id: e['id'] as String,
              arabicText: e['arabicText'] as String,
              transliteration: e['transliteration'] as String,
              translationAr: e['translationAr'] as String,
              translationEn: e['translationEn'] as String,
              count: e['count'] as int,
            ))
        .toList();
  }
}
