import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../cubit/prayer_times_cubit.dart';

class PrayerDetailPage extends StatelessWidget {
  final String prayerName;

  const PrayerDetailPage({super.key, required this.prayerName});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
      builder: (context, state) {
        if (state is! PrayerTimesLoaded) {
          return RizenScaffold(
            appBar: AppBar(title: Text('Prayer Detail')),
            body: const Center(child: Text('Loading...')),
          );
        }

        final cache = state.cache;
        final time = switch (prayerName) {
          'Fajr' => cache.timings.Fajr,
          'Sunrise' => cache.timings.Sunrise,
          'Dhuhr' => cache.timings.Dhuhr,
          'Asr' => cache.timings.Asr,
          'Maghrib' => cache.timings.Maghrib,
          'Isha' => cache.timings.Isha,
          _ => '—',
        };

        return RizenScaffold(
          appBar: AppBar(title: Text(prayerName)),
          body: ListView(
            children: [
              const SizedBox(height: 20),
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Time: $time',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: const Text('Adhan Notification'),
                      subtitle: const Text('Alert before prayer time'),
                      value: true,
                      onChanged: (v) {},
                    ),
                    SwitchListTile(
                      title: const Text('Relative Time Blocking'),
                      subtitle: const Text('Link to routine tasks'),
                      value: false,
                      onChanged: (v) {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
