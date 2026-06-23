import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/prayer_times_cache_model.dart';
import '../../data/repositories/prayer_times_repository.dart';

sealed class PrayerTimesState {}

final class PrayerTimesInitial extends PrayerTimesState {}

final class PrayerTimesLoading extends PrayerTimesState {}

final class PrayerTimesLoaded extends PrayerTimesState {
  final PrayerTimesCache cache;
  final String nextPrayer;
  final Duration countdown;
  PrayerTimesLoaded({
    required this.cache,
    required this.nextPrayer,
    required this.countdown,
  });
}

final class PrayerTimesError extends PrayerTimesState {
  final String message;
  PrayerTimesError(this.message);
}

class PrayerTimesCubit extends Cubit<PrayerTimesState> {
  final PrayerTimesRepository repository;
  StreamSubscription? _ticker;

  PrayerTimesCubit({PrayerTimesRepository? repository})
    : repository = repository ?? PrayerTimesRepository(),
      super(PrayerTimesInitial());

  Future<void> loadPrayerTimes(double lat, double lng) async {
    emit(PrayerTimesLoading());
    try {
      final cache = await repository.getTodayPrayerTimes(lat: lat, lng: lng);
      _startTicker(cache);
    } catch (e) {
      emit(PrayerTimesError(e.toString()));
    }
  }

  void _startTicker(PrayerTimesCache cache) {
    _ticker?.cancel();

    final now = DateTime.now();
    final prayerTimes = {
      'Fajr': _parseTime(cache.timings.Fajr, now),
      'Sunrise': _parseTime(cache.timings.Sunrise, now),
      'Dhuhr': _parseTime(cache.timings.Dhuhr, now),
      'Asr': _parseTime(cache.timings.Asr, now),
      'Maghrib': _parseTime(cache.timings.Maghrib, now),
      'Isha': _parseTime(cache.timings.Isha, now),
    };

    String nextPrayer = 'Isha';
    Duration countdown = Duration.zero;

    for (final entry in prayerTimes.entries) {
      final diff = entry.value.difference(now);
      if (diff > Duration.zero &&
          (countdown == Duration.zero || diff < countdown)) {
        nextPrayer = entry.key;
        countdown = diff;
      }
    }

    emit(
      PrayerTimesLoaded(
        cache: cache,
        nextPrayer: nextPrayer,
        countdown: countdown,
      ),
    );

    _ticker =
        Stream.periodic(const Duration(seconds: 1), (_) {
          final currentState = state;
          if (currentState is PrayerTimesLoaded) {
            final newDiff = _calculateNextPrayer(
              prayerTimes,
              now.add(const Duration(seconds: 1)),
            );
            return PrayerTimesLoaded(
              cache: currentState.cache,
              nextPrayer: newDiff.$1,
              countdown: newDiff.$2,
            );
          }
          return currentState;
        }).listen((state) {
          if (state is PrayerTimesLoaded) {
            emit(state);
          }
        });
  }

  DateTime _parseTime(String timeStr, DateTime date) {
    final parts = timeStr.split(':');
    return DateTime(
      date.year,
      date.month,
      date.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );
  }

  (String, Duration) _calculateNextPrayer(
    Map<String, DateTime> prayerTimes,
    DateTime now,
  ) {
    String nextPrayer = 'Isha';
    Duration countdown = Duration.zero;

    for (final entry in prayerTimes.entries) {
      final diff = entry.value.difference(now);
      if (diff > Duration.zero &&
          (countdown == Duration.zero || diff < countdown)) {
        nextPrayer = entry.key;
        countdown = diff;
      }
    }

    return (nextPrayer, countdown);
  }

  @override
  Future<void> close() {
    _ticker?.cancel();
    return super.close();
  }
}
