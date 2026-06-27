import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../data/models/coach_message_model.dart';
import '../cubit/coach_cubit.dart';

class CoachWeeklyPage extends StatelessWidget {
  const CoachWeeklyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FeatureScaffold(
      title: 'Weekly AI Synthesis',
      subtitle: 'End-of-week master psychological report.',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (context.mounted) {
            context.read<CoachCubit>().generateWeeklySynthesis();
          }
        },
        icon: Icon(PhosphorIconsBold.download),
        label: const Text('Export PDF'),
      ),
      body: BlocBuilder<CoachCubit, CoachState>(
        builder: (context, state) {
          List<CoachMessage> messages;
          if (state is CoachLoaded) {
            messages = state.messages;
          } else if (state is CoachError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(PhosphorIconsBold.warningCircle, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(state.message, textAlign: TextAlign.center),
                ],
              ),
            );
          } else {
            messages = const <CoachMessage>[];
          }

          return ListView(
            children: [
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(PhosphorIconsFill.robot, color: AppColors.accent),
                        const SizedBox(width: 10),
                        Text(
                          'Week of June 14 – June 20',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Discipline Score: 76 / 100',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    if (messages.isNotEmpty)
                      Text(
                        messages.last.content,
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    else
                      Text(
                        'Up from 68 last week. Momentum building in Coding and Spiritual pillars.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text('Key Insights', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              ...List.generate(4, (i) {
                final insights = [
                  (
                    'Coding peaked mid-week',
                    'Wednesday block was highest quality.',
                  ),
                  (
                    'Saturday dip pattern',
                    'Consistent recovery need — consider lighter Saturday routine.',
                  ),
                  (
                    'Shadow score improving',
                    '-8% vs last week. Doom scrolling decreased.',
                  ),
                  ('Sleep window stabilizing', 'Average wake shifted 15m earlier.'),
                ][i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: GlassCard(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          PhosphorIconsBold.sparkle,
                          color: AppColors.accent,
                          size: 18,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                insights.$1,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                insights.$2,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 20),
              RizenButton(
                label: 'Schedule Review Session',
                variant: RizenButtonVariant.secondary,
                onPressed: () {},
              ),
            ],
          );
        },
      ),
    );
  }
}
