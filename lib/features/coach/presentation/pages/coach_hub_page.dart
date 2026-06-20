import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/nav_glass_tile.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/rizen_scaffold.dart';

class CoachHubPage extends StatelessWidget {
  const CoachHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      extendBody: true,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
      body: ListView(
        children: [
          const PageHeader(
            title: 'AI Coach',
            subtitle: 'Your cognitive guide powered by Gemini 2.0 Flash.',
          ),
          const SizedBox(height: 20),
          GlassCard(
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.accent, AppColors.shadow],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    PhosphorIconsFill.robot,
                    color: AppColors.textPrimary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Coach Rizen',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        'Active · Online',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => context.push(AppRoutes.coachChat),
                  icon: Icon(PhosphorIconsBold.chatCircle),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          NavGlassTile(
            title: 'Daily AI Briefing',
            subtitle: 'Morning roadmap and evening diagnostic.',
            icon: PhosphorIconsBold.sun,
            iconColor: AppColors.warning,
            onTap: () => context.push(AppRoutes.coachBriefing),
          ),
          const SizedBox(height: 10),
          NavGlassTile(
            title: 'Free Chat with AI Coach',
            subtitle: 'Conversational workspace for guidance.',
            icon: PhosphorIconsBold.chatCircleDots,
            iconColor: Color(0xFF60A5FA),
            onTap: () => context.push(AppRoutes.coachChat),
          ),
          const SizedBox(height: 10),
          NavGlassTile(
            title: 'Weekly Analytical Synthesis',
            subtitle: 'End-of-week master psychological report.',
            icon: PhosphorIconsBold.calendarCheck,
            iconColor: AppColors.success,
            onTap: () => context.push(AppRoutes.coachWeekly),
          ),
          const SizedBox(height: 10),
          NavGlassTile(
            title: 'AI Suggestions & Corrections',
            subtitle: 'Actionable checklist items for today.',
            icon: PhosphorIconsBold.listChecks,
            iconColor: AppColors.accent,
            onTap: () => context.push(AppRoutes.coachSuggestions),
          ),
          const SizedBox(height: 10),
          NavGlassTile(
            title: 'Micro-Goal Adjustment',
            subtitle: 'Dynamic goal shifting based on patterns.',
            icon: PhosphorIconsBold.target,
            iconColor: AppColors.shadow,
            onTap: () => context.push(AppRoutes.coachMicroGoals),
          ),
          const SizedBox(height: 10),
          NavGlassTile(
            title: 'Behavioral Insights',
            subtitle: 'Correlation reports and pattern recognition.',
            icon: PhosphorIconsBold.brain,
            iconColor: Color(0xFF818CF8),
            onTap: () => context.push(AppRoutes.coachInsights),
          ),
        ],
      ),
    );
  }
}
