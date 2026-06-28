import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/skeleton_loader.dart';
import '../../../../core/router/app_routes.dart';
import '../../domain/models/todo_coach_summary.dart';
import '../cubit/coach_cubit.dart';

class CoachBriefingPage extends StatefulWidget {
  const CoachBriefingPage({super.key});

  @override
  State<CoachBriefingPage> createState() => _CoachBriefingPageState();
}

class _CoachBriefingPageState extends State<CoachBriefingPage> {
  @override
  void initState() {
    super.initState();
    context.read<CoachCubit>().loadTodoSummary();
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
                          margin: const EdgeInsetsDirectional.only(end: 12, top: 6),
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.accent,
                            shape: BoxShape.circle,
                          ),
                        ),
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
          BlocSelector<CoachCubit, CoachState, TodoCoachSummary?>(
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