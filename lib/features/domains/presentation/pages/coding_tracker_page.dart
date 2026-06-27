import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../cubit/domain_logs_cubit.dart';
import 'domain_tracker_view.dart';
import '../../data/domain_catalog.dart';

class CodingTrackerPage extends StatelessWidget {
  const CodingTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DomainLogsCubit()..loadDomainSummary('coding'),
      child: DomainTrackerView(domain: DomainInfo(id: LifeDomain.coding, name: 'Coding', subtitle: 'Projects, commits, and skill building', icon: PhosphorIconsBold.code, color: Color(0xFF818CF8), weeklyHours: 12.0, streak: 11, progress: 0.85, metricLabel: 'commits')),
    );
  }
}
