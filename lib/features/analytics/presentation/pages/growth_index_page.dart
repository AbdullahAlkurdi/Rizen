import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../cubit/analytics_cubit.dart';

class GrowthIndexPage extends StatelessWidget {
  const GrowthIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalyticsCubit, AnalyticsState>(
      builder: (context, state) {
        final score = state is AnalyticsLoaded ? state.weeklyScore : 84;
        final streak = state is AnalyticsLoaded ? state.streakDays : 0;
        return FeatureScaffold(
          title: 'Growth Index',
          subtitle: 'Personal evolution and burnout risk indicators.',
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {},
            icon: Icon(PhosphorIconsBold.export),
            label: const Text('Export'),
          ),
          body: ListView(
            children: [
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          PhosphorIconsFill.plant,
                          color: AppColors.success,
                          size: 22,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Growth Index',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${score.round()} / 100',
                      style: Theme.of(
                        context,
                      ).textTheme.displaySmall?.copyWith(color: AppColors.success),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      streak >= 7
                          ? 'Strong trajectory. Keep protecting Saturday recovery time.'
                          : 'Build consistency to unlock strong trajectory insights.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GlassCard(
                gradient: LinearGradient(
                  colors: [
                    AppColors.warning.withValues(alpha: 0.15),
                    AppColors.cardBackground.withValues(alpha: 0.7),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(PhosphorIconsBold.warning, color: AppColors.warning),
                        const SizedBox(width: 10),
                        Text(
                          'Burnout Risk',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      streak >= 7 ? 'Low — 8%' : 'Medium — 18%',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(color: AppColors.warning),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      streak >= 7
                          ? 'Healthy patterns detected. Recovery mode not needed.'
                          : 'Sleep drift + Saturday dip pattern detected. Proactive Recovery Mode recommended.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: streak >= 7 ? 0.08 : 0.18,
                      backgroundColor: AppColors.glassFill,
                      color: AppColors.warning,
                      borderRadius: BorderRadius.circular(4),
                      minHeight: 8,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              RizenButton(
                label: 'Activate Recovery Mode',
                variant: RizenButtonVariant.secondary,
                onPressed: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}
