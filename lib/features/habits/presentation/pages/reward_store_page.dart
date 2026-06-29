import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/tutorials/tutorial_mixin.dart';
import '../../../../core/services/tutorial_service.dart';
import '../../../../core/tutorials/rizen_tutorial.dart';
import '../cubit/burnout_mode_cubit.dart';

class RewardStorePage extends StatelessWidget {
  const RewardStorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BurnoutModeCubit()..activateEmergencyMode(),
      child: const RewardStoreView(),
    );
  }
}

class RewardStoreView extends StatefulWidget {
  const RewardStoreView({super.key});

  @override
  State<RewardStoreView> createState() => _RewardStoreViewState();
}

class _RewardStoreViewState extends State<RewardStoreView> with TutorialMixin {
  @override
  String get tutorialKey => TutorialService.keys['reward_store']!;

  @override
  List<TargetFocus> buildTargets() => RizenTutorial.rewardStore(_tutorialKeys);

  final Map<String, GlobalKey> _tutorialKeys = {
    'points': GlobalKey(),
    'rewards': GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) maybeShowTutorial();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FeatureScaffold(
      title: 'Reward Store',
      subtitle: 'Real-life pleasures unlocked through discipline.',
      actions: [
        IconButton(
          onPressed: showTutorialNow,
          icon: const Icon(PhosphorIconsBold.question),
          color: const Color(0xFF9CA3AF),
          tooltip: 'Help',
        ),
      ],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(PhosphorIconsBold.plus),
        label: const Text('Create Reward'),
      ),
      body: ListView(
        children: [
          Container(
            key: _tutorialKeys['points'] as Key,
            child: GlassCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        PhosphorIconsFill.coins,
                        color: AppColors.warning,
                        size: 22,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Your Points',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  Text(
                    '340',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineSmall?.copyWith(color: AppColors.warning),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            key: _tutorialKeys['rewards'] as Key,
            child: Column(
              children: [
                ...List.generate(4, (index) {
                  final rewards = [
                    _Reward('Morning Coffee at Café', 120, true, AppColors.success),
                    _Reward('New Game Release', 450, false, AppColors.textMuted),
                    _Reward('Movie Night Budget', 250, false, AppColors.accent),
                    _Reward('Weekend Trip Fund', 800, false, AppColors.warning),
                  ];
                  final r = rewards[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: GlassCard(
                      onTap: () {},
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: r.isUnlocked
                                  ? AppColors.success.withValues(alpha: 0.15)
                                  : AppColors.glassFill,
                              borderRadius: AppTheme.cardRadius,
                            ),
                            child: Icon(
                              r.isUnlocked
                                  ? PhosphorIconsFill.gift
                                  : PhosphorIconsBold.lockSimple,
                              color: r.color,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  r.title,
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  r.price,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            r.isUnlocked ? 'Unlocked' : r.pointsNeeded.toString(),
                            style: Theme.of(
                              context,
                            ).textTheme.labelMedium?.copyWith(color: r.color),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Reward {
  const _Reward(this.title, this.pointsNeeded, this.isUnlocked, this.color);
  final String title;
  final int pointsNeeded;
  final bool isUnlocked;
  final Color color;
  String get price => '$pointsNeeded pts';
}
