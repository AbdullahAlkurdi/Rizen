import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../cubit/domain_logs_cubit.dart';
import 'domain_tracker_view.dart';
import '../../data/domain_catalog.dart';

class SportsTrackerPage extends StatelessWidget {
  const SportsTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DomainLogsCubit()..loadDomainSummary('sports'),
      child: DomainTrackerView(domain: DomainInfo(id: LifeDomain.sports, name: 'Sports', subtitle: 'Training, cardio, and recovery', icon: PhosphorIconsBold.barbell, color: Color(0xFF4ADE80), weeklyHours: 4.5, streak: 8, progress: 0.65, metricLabel: 'km run')),
    );
  }
}
