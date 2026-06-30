import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/skeleton_loader.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/tutorials/tutorial_mixin.dart';
import '../../../../core/services/tutorial_service.dart';
import '../../../../core/tutorials/rizen_tutorial.dart';
import '../../domain/models/todo_coach_summary.dart';
import '../../domain/entities/sleep_insight.dart';
import '../cubit/coach_cubit.dart';

class CoachBriefingPage extends StatefulWidget {
  const CoachBriefingPage({super.key});

  @override
  State<CoachBriefingPage> createState() => _CoachBriefingPageState();
}

class _CoachBriefingPageState extends State<CoachBriefingPage> with TutorialMixin {
  @override
  String get tutorialKey => TutorialService.keys['coach_briefing']!;

  @override
  List<TargetFocus> buildTargets() => RizenTutorial.coachBriefing(_tutorialKeys);

  final Map<String, GlobalKey> _tutorialKeys = {
    'morning': GlobalKey(),
    'checklist_intel': GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    context.read<CoachCubit>().loadTodoSummary();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (mounted) maybeShowTutorial();
  }

  void _navigateToCoachChat(String prefilledMessage) {
    context.push(AppRoutes.coachChat, extra: prefilledMessage);
  }

  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;
    final isMorning = hour < 12;

    return FeatureScaffold(
      title: 'AI Briefing',
      subtitle: isMorning
          ? 'Your adaptive roadmap for today.'
          : 'Evening diagnostic and reflection.',
actions: [
         IconButton(
           onPressed: showTutorialNow,
           icon: const Icon(PhosphorIconsBold.question),
           color: const Color(0xFF9CA3AF),
           tooltip: 'Help',
         ),
         IconButton(
           onPressed: () => context.push(AppRoutes.coachVoiceLog),
           icon: const Icon(PhosphorIconsBold.microphone),
           color: const Color(0xFFE94560),
           tooltip: 'Voice Log',
         ),
       ],
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
          Container(
            key: _tutorialKeys['checklist_intel'] as Key,
            child: BlocSelector<CoachCubit, CoachState, TodoCoachSummary?>(
              selector: (state) {
                if (state is CoachTodoSummaryLoaded) return state.summary;
                if (state is CoachTodoSummaryError) return null;
                return null;
              },
              builder: (context, summary) {
                if (summary == null) {
                  return _buildTodoLoadingState();
                }
                return _buildTodoChecklistSection(context, summary);
                },
              ),
            ),
            const SizedBox(height: 20),
          BlocSelector<CoachCubit, CoachState, SleepInsight?>(
              selector: (state) {
                if (state is CoachSleepInsightLoaded) return state.insight;
                return null;
              },
              builder: (context, insight) {
                if (insight == null) {
                  return GlassCard(
                    child: Row(
                      children: [
                        Icon(PhosphorIconsBold.moon, color: const Color(0xFF0F3460)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Start tracking your sleep to unlock personalized sleep coaching.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(PhosphorIconsBold.moon, color: const Color(0xFF0F3460)),
                          const SizedBox(width: 10),
                          Text(
                            'Sleep Insight',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        insight.insight,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        insight.recommendation,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textMuted,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                         'Tracked sleep: ${insight.bedResistanceMetric.toStringAsFixed(0)} of last 7 days',
                         style: Theme.of(context).textTheme.labelSmall,
                       ),
                     ],
                   ),
                 );
               },
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

  Widget _buildTodoLoadingState() {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Checklist Intelligence",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          const SkeletonLine(height: 16),
          const SizedBox(height: 12),
          const SkeletonLine(height: 16),
          const SizedBox(height: 12),
          const SkeletonLine(height: 16),
        ],
      ),
    );
  }

  Widget _buildTodoChecklistSection(
    BuildContext context,
    TodoCoachSummary summary,
  ) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(PhosphorIconsBold.listChecks, color: const Color(0xFF0F3460)),
              const SizedBox(width: 8),
              Text(
                "Today's Checklist Intelligence",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildStatChip(context, '${summary.totalItems}', 'tasks', const Color(0xFF0F3460)),
              _buildStatChip(context, '${summary.completedItems}', 'done', const Color(0xFF0F3460)),
              summary.missedRequiredItems > 0
                  ? _buildStatChip(
                      context,
                      '${summary.missedRequiredItems}',
                      'missed',
                      const Color(0xFFE94560),
                    )
                  : _buildStatChip(context, '${summary.missedRequiredItems}', 'missed', const Color(0xFF0F3460)),
            ],
          ),
          if (summary.perfectHabits.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              'Perfect today',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textMuted,
                  ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: summary.perfectHabits
                  .map((habit) => _buildPill(context, habit))
                  .toList(),
            ),
          ],
          if (summary.chronicallyMissed.isNotEmpty) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(PhosphorIconsBold.warningCircle, color: const Color(0xFFFFB300), size: 18),
                const SizedBox(width: 6),
                Text(
                  'Needs attention',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFFFFB300),
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...summary.chronicallyMissed.map((item) => _buildMissedItemRow(context, item)),
          ],
        ],
      ),
    );
  }

  Widget _buildStatChip(BuildContext context, String value, String label, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$value $label',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildPill(BuildContext context, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF4CAF50).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF4CAF50),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildMissedItemRow(BuildContext context, String itemName) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(PhosphorIconsBold.arrowRight, color: const Color(0xFFFFB300), size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  itemName,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Text(
              'Missed 3+ days in a row',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textMuted,
                  ),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              _buildActionChip(context, 'Reschedule', itemName),
              _buildActionChip(context, 'Simplify', itemName),
              _buildActionChip(context, 'Remove', itemName),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionChip(BuildContext context, String action, String itemName) {
    return InkWell(
      onTap: () => _navigateToCoachChat("Help me $action '$itemName' from my checklist"),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          action,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}