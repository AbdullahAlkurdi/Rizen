import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../cubit/burnout_mode_cubit.dart';

class BurnoutModePage extends StatelessWidget {
  const BurnoutModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BurnoutModeCubit()..activateEmergencyMode(),
      child: const BurnoutModeView(),
    );
  }
}

class BurnoutModeView extends StatelessWidget {
  const BurnoutModeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BurnoutModeCubit, BurnoutModeState>(
      builder: (context, state) {
        return FeatureScaffold(
          title: 'Burnout Mode',
          subtitle: 'Emergency recovery and survival baseline.',
          body: ListView(
            children: [
              const PageHeader(
                title: 'Emergency Mode',
                subtitle: 'Collapse to survival baseline when overwhelmed.',
              ),
              const SizedBox(height: 20),
              if (state is BurnoutModeLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (state is BurnoutModeError)
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Error: ${state.message}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                )
              else if (state is BurnoutModeActive)
                Column(
                  children: [
                    GlassCard(
                      child: Row(
                        children: [
                          Icon(
                            PhosphorIconsFill.warning,
                            color: AppColors.warning,
                            size: 22,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              (state).message,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Survival Baseline Tasks',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    ...(state).survivalTasks.map((task) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: GlassCard(
                          child: ListTile(
                            leading: Icon(
                              PhosphorIconsBold.checkCircle,
                              color: task.isCritical
                                  ? AppColors.warning
                                  : AppColors.success,
                              size: 20,
                            ),
                            title: Text(task.title),
                            trailing: task.isCritical
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.warning.withValues(
                                        alpha: 0.15,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      'Critical',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: AppColors.warning,
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 24),
                    RizenButton(
                      label: 'Deactivate Emergency Mode',
                      variant: RizenButtonVariant.secondary,
                      onPressed: () =>
                          context.read<BurnoutModeCubit>().deactivateEmergencyMode(),
                    ),
                  ],
                )
              else
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        PhosphorIconsFill.checkCircle,
                        size: 64,
                        color: AppColors.success,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Normal Mode Active',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'You are not in emergency mode.',
                        style: Theme.of(context).textTheme.bodyMedium,
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
