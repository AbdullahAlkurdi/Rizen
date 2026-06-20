import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';

class RewardStorePage extends StatelessWidget {
  const RewardStorePage({super.key});

  static const _rewards = [
    _Reward('Morning Coffee at Café', 120, 'Unlocked', AppColors.success),
    _Reward('New Game Release', 450, 'Locked', AppColors.textMuted),
    _Reward('Movie Night Budget', 250, 'Locked', AppColors.accent),
    _Reward('Weekend Trip Fund', 800, 'Locked', AppColors.warning),
  ];

  @override
  Widget build(BuildContext context) {
    return FeatureScaffold(
      title: 'Reward Store',
      subtitle: 'Real-life pleasures unlocked through discipline.',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(PhosphorIconsBold.plus),
        label: Text('Create Reward'),
      ),
      body: ListView(
        children: [
          GlassCard(
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
          const SizedBox(height: 20),
          ..._rewards.map(
            (r) => Padding(
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
            ),
          ),
        ],
      ),
    );
  }
}

class _Reward {
  const _Reward(this.title, this.pointsNeeded, this.status, this.color);
  final String title;
  final int pointsNeeded;
  final String status;
  final Color color;
  String get price => '$pointsNeeded pts';
  bool get isUnlocked => status == 'Unlocked';
}
