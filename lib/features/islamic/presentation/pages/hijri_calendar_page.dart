import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../cubit/prayer_times_cubit.dart';

class HijriCalendarPage extends StatelessWidget {
  const HijriCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
      builder: (context, state) {
        final hijriDate = state is PrayerTimesLoaded
            ? state.cache.hijriDate
            : null;

        return RizenScaffold(
          appBar: AppBar(title: const Text('Hijri Calendar')),
          body: ListView(
            children: [
              const SizedBox(height: 20),
              if (hijriDate != null)
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Today',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Text(
                        '${hijriDate.day} ${hijriDate.monthNameEn} ${hijriDate.year}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${hijriDate.day} ${hijriDate.monthNameAr} ${hijriDate.year}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 7,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(30, (i) {
                  final day = i + 1;
                  return GlassCard(
                    child: Center(
                      child: Text(
                        '$day',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
