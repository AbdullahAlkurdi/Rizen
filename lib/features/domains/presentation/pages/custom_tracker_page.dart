import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../cubit/domain_logs_cubit.dart';
import 'domain_tracker_view.dart';
import '../../data/domain_catalog.dart';

class CustomTrackerPage extends StatelessWidget {
  const CustomTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DomainLogsCubit()..loadDomainSummary('custom'),
      child: DomainTrackerView(domain: DomainInfo(id: LifeDomain.custom, name: 'Custom Domain', subtitle: 'Your personal life pillar', icon: PhosphorIconsBold.star, color: Color(0xFFE94560), weeklyHours: 3.0, streak: 3, progress: 0.30, metricLabel: 'custom unit')),
    );
  }
}
