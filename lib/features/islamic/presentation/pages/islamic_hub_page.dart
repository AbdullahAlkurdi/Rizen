import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/nav_glass_tile.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../cubit/prayer_times_cubit.dart';

class IslamicHubPage extends StatelessWidget {
  const IslamicHubPage({super.key});

  String _formatDuration(Duration d) {
    if (d.isNegative) return 'Now';
    final h = d.inHours;
    final m = d.inMinutes % 60;
    return '${h}h ${m}m';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
      builder: (context, state) {
        return RizenScaffold(
          extendBody: true,
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
          body: switch (state) {
            PrayerTimesLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            PrayerTimesError(:final message) => Center(
              child: Text(
                'Error: $message',
                style: TextStyle(color: Colors.red),
              ),
            ),
            PrayerTimesLoaded(
              :final cache,
              :final nextPrayer,
              :final countdown,
            ) =>
              ListView(
                children: [
                  const PageHeader(
                    title: 'Islamic Hub',
                    subtitle: 'Prayer times, Qibla, and spiritual tracking.',
                  ),
                  const SizedBox(height: 20),
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Next Prayer: $nextPrayer',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          'In ${_formatDuration(countdown)}',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppColors.accent),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  _PrayerTimeTile(
                    prayer: 'Fajr',
                    time: cache.timings.Fajr,
                    icon: PhosphorIconsBold.sunHorizon,
                  ),
                  _PrayerTimeTile(
                    prayer: 'Sunrise',
                    time: cache.timings.Sunrise,
                    icon: PhosphorIconsBold.sun,
                  ),
                  _PrayerTimeTile(
                    prayer: 'Dhuhr',
                    time: cache.timings.Dhuhr,
                    icon: PhosphorIconsBold.sunDim,
                  ),
                  _PrayerTimeTile(
                    prayer: 'Asr',
                    time: cache.timings.Asr,
                    icon: PhosphorIconsBold.cloudSun,
                  ),
                  _PrayerTimeTile(
                    prayer: 'Maghrib',
                    time: cache.timings.Maghrib,
                    icon: PhosphorIconsBold.sunHorizon,
                  ),
                  _PrayerTimeTile(
                    prayer: 'Isha',
                    time: cache.timings.Isha,
                    icon: PhosphorIconsBold.moonStars,
                  ),
                  const SizedBox(height: 20),
                  GlassCard(
                    child: Row(
                      children: [
                        Icon(
                          PhosphorIconsBold.calendar,
                          color: AppColors.accent,
                          size: 28,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hijri Date',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                '${cache.hijriDate.day} ${cache.hijriDate.monthNameEn} ${cache.hijriDate.year}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  NavGlassTile(
                    title: 'Qibla Compass',
                    subtitle: 'Find bearing to Kaaba',
                    icon: PhosphorIconsBold.compass,
                    iconColor: AppColors.accent,
                    onTap: () => context.push(AppRoutes.qibla),
                  ),
                  const SizedBox(height: 10),
                  NavGlassTile(
                    title: 'Prayer Settings',
                    subtitle: 'Calculation method and notifications',
                    icon: PhosphorIconsBold.gear,
                    iconColor: Color(0xFF60A5FA),
                    onTap: () => context.push(AppRoutes.prayerSettings),
                  ),
                  const SizedBox(height: 10),
                  NavGlassTile(
                    title: 'Hijri Calendar',
                    subtitle: 'Monthly Hijri calendar',
                    icon: PhosphorIconsBold.calendar,
                    iconColor: AppColors.warning,
                    onTap: () => context.push(AppRoutes.hijriCalendar),
                  ),
                ],
              ),
            _ => const SizedBox.shrink(),
          },
        );
      },
    );
  }
}

class _PrayerTimeTile extends StatelessWidget {
  const _PrayerTimeTile({
    required this.prayer,
    required this.time,
    required this.icon,
  });

  final String prayer;
  final String time;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GlassCard(
        child: ListTile(
          leading: Icon(icon, color: AppColors.textMuted, size: 20),
          title: Text(prayer),
          trailing: Text(time, style: Theme.of(context).textTheme.bodyMedium),
        ),
      ),
    );
  }
}
