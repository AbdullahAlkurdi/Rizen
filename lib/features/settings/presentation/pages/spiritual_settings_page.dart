import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_scaffold.dart';

class SpiritualSettingsPage extends StatelessWidget {
  const SpiritualSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(PhosphorIconsBold.arrowLeft),
          onPressed: () => context.pop(),
        ),
        title: const Text('Spiritual Framework'),
      ),
      body: ListView(
        children: [
          GlassCard(
            child: SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Enable Spiritual Layer',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                'Anchor routines to prayer times.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              value: true,
              activeTrackColor: AppColors.accent.withValues(alpha: 0.5),
              activeThumbColor: AppColors.accent,
              onChanged: (v) {},
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Calculation Method',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          ...List.generate(4, (i) {
            final methods = [
              ('Muslim World League', true),
              ('Umm Al-Qura', false),
              ('Egyptian General Authority', false),
              ('ISNA', false),
            ][i];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GlassCard(
                onTap: () {},
                borderColor: methods.$2 ? AppColors.accent : null,
                child: Row(
                  children: [
                    Icon(
                      methods.$2
                          ? PhosphorIconsFill.checkCircle
                          : PhosphorIconsBold.circle,
                      color: methods.$2
                          ? AppColors.accent
                          : AppColors.textMuted,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        methods.$1,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
