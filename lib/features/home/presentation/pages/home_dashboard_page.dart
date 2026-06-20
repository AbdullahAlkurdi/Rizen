import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../data/dashboard_mock_data.dart';

class HomeDashboardPage extends StatelessWidget {
  const HomeDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;
    final greeting = DashboardData.greetingForHour(hour);
    final isMorning = hour < 17;

    return RizenScaffold(
      extendBody: true,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Voice logging — Gemini integration coming in Phase 4',
              ),
            ),
          );
        },
        child: Icon(PhosphorIconsFill.microphone, size: 28),
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      greeting,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                    Text(
                      'Abdul',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              ),
              IconButton(onPressed: () {}, icon: Icon(PhosphorIconsBold.bell)),
            ],
          ),
          const SizedBox(height: 20),
          _ActiveTimeBlockCard(block: DashboardData.activeBlock),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => context.go(AppRoutes.dailyScore),
            child: _DailyScorePreview(score: DashboardData.dailyScore),
          ),
          const SizedBox(height: 20),
          Text('Quick Actions', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.6,
            children: DashboardData.quickActions.map((action) {
              return GlassCard(
                onTap: () {},
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: action.color.withValues(alpha: 0.15),
                        borderRadius: AppTheme.cardRadius,
                      ),
                      child: Icon(action.icon, color: action.color, size: 22),
                    ),
                    const Spacer(),
                    Text(
                      action.label,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Text(
                  isMorning ? 'Today\'s Flow' : 'Evening Wrap-up',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              TextButton(
                onPressed: () => context.go(AppRoutes.weeklyOverview),
                child: const Text('Weekly view'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...DashboardData.upcomingBlocks.map((block) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GlassCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            block.$1,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            '${block.$2} · ${block.$3}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      PhosphorIconsBold.caretRight,
                      color: AppColors.textMuted,
                      size: 18,
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 16),
          _DomainProgressSection(),
          const SizedBox(height: 16),
          GlassCard(
            gradient: LinearGradient(
              colors: [
                AppColors.shadow.withValues(alpha: 0.2),
                AppColors.cardBackground.withValues(alpha: 0.6),
              ],
            ),
            child: Row(
              children: [
                Icon(PhosphorIconsFill.skull, color: AppColors.shadow),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shadow Score: ${DashboardData.shadowScore}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        'Doom scrolling stole 45 mins from Coding today.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActiveTimeBlockCard extends StatelessWidget {
  const _ActiveTimeBlockCard({required this.block});

  final TimeBlock block;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          block.color.withValues(alpha: 0.25),
          AppColors.cardBackground.withValues(alpha: 0.8),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: block.color.withValues(alpha: 0.2),
                  borderRadius: AppTheme.cardRadius,
                ),
                child: Icon(block.icon, color: block.color),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Active Time Block',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(
                      block.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${block.remainingMinutes}',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: block.color,
                  height: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8, left: 6),
                child: Text(
                  'mins remaining',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const Spacer(),
              FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: block.color,
                  foregroundColor: AppColors.primaryBackground,
                ),
                child: const Text('Focus'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: 0.55,
            backgroundColor: AppColors.glassFill,
            color: block.color,
            borderRadius: BorderRadius.circular(4),
            minHeight: 6,
          ),
        ],
      ),
    );
  }
}

class _DailyScorePreview extends StatelessWidget {
  const _DailyScorePreview({required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Row(
        children: [
          SizedBox(
            width: 72,
            height: 72,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 72,
                  height: 72,
                  child: CircularProgressIndicator(
                    value: score / 100,
                    strokeWidth: 6,
                    backgroundColor: AppColors.glassFill,
                    color: AppColors.accent,
                  ),
                ),
                Text(
                  '$score',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daily Score Card',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  '${DashboardData.streakDays}-day resilient streak',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColors.success),
                ),
                const SizedBox(height: 4),
                Text(
                  'Tap to view full breakdown',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Icon(PhosphorIconsBold.caretRight, color: AppColors.textMuted),
        ],
      ),
    );
  }
}

class _DomainProgressSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '7 Pillars Progress',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          ...DashboardData.domainProgress.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.$1,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        '${(item.$2 * 100).round()}%',
                        style: Theme.of(
                          context,
                        ).textTheme.labelMedium?.copyWith(color: item.$3),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  LinearProgressIndicator(
                    value: item.$2,
                    backgroundColor: AppColors.glassFill,
                    color: item.$3,
                    borderRadius: BorderRadius.circular(4),
                    minHeight: 5,
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
