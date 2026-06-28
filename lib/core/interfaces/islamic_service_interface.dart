import '../../../features/islamic/data/models/prayer_times_cache_model.dart';

abstract class IslamicServiceInterface {
  Future<PrayerStatus> getTodayPrayerStatus();
  Future<QuranProgress> getQuranProgress();
  Future<PrayerTimesCache> getTodayPrayerTimes({
    required double lat,
    required double lng,
  });
}

class PrayerStatus {
  final bool isAvailable;
  final String? validForDate;
  final Timings? timings;

  PrayerStatus({
    required this.isAvailable,
    this.validForDate,
    this.timings,
  });
}

class QuranProgress {
  final int pagesReadToday;
  final int currentStreak;
  final int weeklyTotal;

  QuranProgress({
    required this.pagesReadToday,
    required this.currentStreak,
    required this.weeklyTotal,
  });
}