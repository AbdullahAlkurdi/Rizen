import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_button.dart';

class CoachBriefingPage extends StatelessWidget {
  const CoachBriefingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;
    final isMorning = hour < 12;

    return FeatureScaffold(
      title: 'AI Briefing',
      subtitle: isMorning
          ? 'Your adaptive roadmap for today.'
          : 'Evening diagnostic and reflection.',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(PhosphorIconsBold.arrowClockwise),
        label: Text('Regenerate'),
      ),
      body: ListView(
        children: [
          GlassCard(
            child: Row(
              children: [
                Icon(
                  isMorning ? PhosphorIconsBold.sun : PhosphorIconsFill.moon,
                  color: isMorning ? AppColors.warning : AppColors.shadow,
                ),
                const SizedBox(width: 12),
                Text(
                  isMorning ? 'Morning Briefing' : 'Evening Briefing',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          GlassCard(
            gradient: LinearGradient(
              colors: [
                AppColors.accent.withValues(alpha: 0.12),
                AppColors.cardBackground.withValues(alpha: 0.7),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Strategic Roadmap',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                ...List.generate(4, (i) {
                  final items = [
                    (
                      'Protect your 6:30 AM coding block',
                      'High-impact time already scheduled.',
                    ),
                    (
                      'Schedule workout after Dhuhr prayer',
                      'Matches your energy peak.',
                    ),
                    (
                      'Shorten evening work block by 30m',
                      'Sleep discipline flagged.',
                    ),
                    (
                      'Add reflection journal before sleep',
                      'Supports long-term alignment.',
                    ),
                  ][i];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 6),
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.accent,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                items.$1,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                items.$2,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 20),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Coach Note',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                Text(
                  'I see momentum this week. Saturday dip is normal — consider Recovery Mode proactively rather than waiting for burnout signals.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          RizenButton(
            label: isMorning ? 'Mark as Read' : 'Close Evening Briefing',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
