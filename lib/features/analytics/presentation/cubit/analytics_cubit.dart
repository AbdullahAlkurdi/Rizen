import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../data/models/analytics_period.dart';
import '../../data/models/correlation_insight.dart';
import '../../data/models/domain_score_point.dart';
import '../../data/models/growth_index.dart';
import '../../data/models/habit_trend_point.dart';
import '../../data/repositories/analytics_repository.dart';
import 'analytics_state.dart';

class AnalyticsCubit extends Cubit<AnalyticsState> {
  AnalyticsCubit({AnalyticsRepository? repository})
      : _repository = repository ??
            AnalyticsRepository(
              firestore: FirebaseFirestore.instance,
              uid: FirebaseAuth.instance.currentUser?.uid ?? '',
            ),
        super(const AnalyticsInitial());

  final AnalyticsRepository _repository;
  StreamSubscription? _sub;

  Future<void> loadAll(AnalyticsPeriod period) async {
    emit(const AnalyticsLoading());
    try {
      final results = await Future.wait([
        _repository.getDomainScores(period),
        _repository.getHabitTrends(period),
        _repository.getGrowthIndex(),
        _repository.getCorrelationInsights(),
      ]);

      emit(AnalyticsLoaded(
        domainScores: results[0] as List<DomainScorePoint>,
        habitTrends: results[1] as List<HabitTrendPoint>,
        growthIndex: results[2] as GrowthIndex,
        correlations: results[3] as List<CorrelationInsight>,
        selectedPeriod: period,
      ));
    } catch (e) {
      emit(AnalyticsError(e.toString(), () => loadAll(period)));
    }
  }

  Future<void> changePeriod(AnalyticsPeriod period) async {
    if (state is AnalyticsLoaded) {
      await loadAll(period);
    }
  }

  Future<void> exportData(String format) async {
    try {
      final data = await _repository.exportData(format);
      if (Platform.isAndroid || Platform.isIOS) {
        await SharePlus.instance.share(ShareParams(text: data, subject: 'Rizen Analytics Export'));
      } else {
        emit(AnalyticsError('Export generated. Share not supported on desktop.', () => exportData(format)));
      }
    } catch (e) {
      emit(AnalyticsError(e.toString(), () => exportData(format)));
    }
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    return super.close();
  }
}
