import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../cubit/domain_logs_cubit.dart';
import 'domain_tracker_view.dart';
import '../../data/domain_catalog.dart';

class CookingTrackerPage extends StatelessWidget {
  const CookingTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DomainLogsCubit()..loadDomainSummary('cooking'),
      child: DomainTrackerView(domain: DomainInfo(id: LifeDomain.cooking, name: 'Cooking & Nutrition', subtitle: 'Meals, macros, and hydration', icon: PhosphorIconsBold.cookingPot, color: Color(0xFFFB923C), weeklyHours: 5.0, streak: 6, progress: 0.55, metricLabel: 'meals cooked')),
    );
  }
}
