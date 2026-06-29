import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/nav_glass_tile.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../../../core/widgets/skeleton_loader.dart';
import '../cubit/spiritual_cubit.dart';

class QuranTrackerPage extends StatelessWidget {
  const QuranTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpiritualCubit, SpiritualState>(
      builder: (context, state) {
        return RizenScaffold(
          extendBody: true,
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
          body: switch (state) {
             SpiritualLoading() => const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    SkeletonCard(height: 100),
                    SizedBox(height: 12),
                    SkeletonChip(width: 120),
                    SizedBox(height: 12),
                    SkeletonChip(width: 120),
                    SizedBox(height: 12),
                    SkeletonChip(width: 120),
                  ],
                ),
              ),
            SpiritualError(:final message) => Center(
                child: Text(
                  'Error: $message',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            SpiritualQuranLoaded(
              :final todayLog,
              :final cumulativePages,
              :final streak,
              :final weeklyPages,
            ) =>
              ListView(
                children: [
                  const PageHeader(
                    title: 'Quran Tracker',
                    subtitle: 'Track your daily and weekly Quran reading.',
                  ),
                  const SizedBox(height: 20),
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Today\'s Reading',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${todayLog?.pagesRead ?? 0} pages',
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            Icon(
                              PhosphorIconsFill.bookOpenText,
                              size: 36,
                              color: AppColors.accent,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: GlassCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Cumulative',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '$cumulativePages pages',
                                style:
                                    Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GlassCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Streak',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '$streak days',
                                style:
                                    Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'This Week',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$weeklyPages pages',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  RizenButton(
                    label: 'Log Pages Read',
                    icon: PhosphorIconsBold.plus,
                    onPressed: () => _showLogPagesDialog(context),
                  ),
                  const SizedBox(height: 12),
                  NavGlassTile(
                    title: 'Spiritual Summary',
                    subtitle: 'Weekly spiritual overview',
                    icon: PhosphorIconsBold.chartBar,
                    iconColor: AppColors.success,
                    onTap: () => context.push(AppRoutes.spiritualSummary),
                  ),
                ],
              ),
            _ => const SizedBox.shrink(),
          },
        );
      },
    );
  }

  void _showLogPagesDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Quran Pages'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Pages read today',
            hintText: 'e.g. 5',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final pages = int.tryParse(controller.text) ?? 0;
              if (pages > 0 && pages <= 604) {
                context
                    .read<SpiritualCubit>()
                    .logQuranPages(pages);
                Navigator.pop(context);
              }
            },
            child: const Text('Log'),
          ),
        ],
      ),
    );
  }
}
