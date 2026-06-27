import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../cubit/domain_logs_cubit.dart';
import 'domain_tracker_view.dart';
import '../../data/domain_catalog.dart';

class StudyTrackerPage extends StatelessWidget {
  const StudyTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DomainLogsCubit()..loadDomainSummary('study'),
      child: DomainTrackerView(domain: DomainInfo(id: LifeDomain.study, name: 'Study', subtitle: 'Reading, courses, and deep learning', icon: PhosphorIconsBold.bookOpen, color: Color(0xFF60A5FA), weeklyHours: 6.0, streak: 5, progress: 0.40, metricLabel: 'pages read')),
    );
  }
}
