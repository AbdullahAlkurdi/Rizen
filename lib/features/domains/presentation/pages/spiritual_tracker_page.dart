import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../cubit/domain_logs_cubit.dart';
import 'domain_tracker_view.dart';
import '../../data/domain_catalog.dart';

class SpiritualTrackerPage extends StatelessWidget {
  const SpiritualTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DomainLogsCubit()..loadDomainSummary('spiritual'),
      child: DomainTrackerView(domain: DomainInfo(id: LifeDomain.spiritual, name: 'Spiritual', subtitle: 'Prayer, Quran, and reflection', icon: PhosphorIconsBold.moonStars, color: Color(0xFFFBBF24), weeklyHours: 7.0, streak: 21, progress: 0.90, metricLabel: 'Quran pages')),
    );
  }
}
