import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../cubit/domain_logs_cubit.dart';
import 'domain_tracker_view.dart';
import '../../data/domain_catalog.dart';

class WorkTrackerPage extends StatelessWidget {
  const WorkTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DomainLogsCubit()..loadDomainSummary('work'),
      child: DomainTrackerView(domain: DomainInfo(id: LifeDomain.work, name: 'Work', subtitle: 'Professional tasks and focus blocks', icon: PhosphorIconsBold.briefcase, color: Color(0xFF38BDF8), weeklyHours: 32.0, streak: 14, progress: 0.72, metricLabel: 'focus sessions')),
    );
  }
}
