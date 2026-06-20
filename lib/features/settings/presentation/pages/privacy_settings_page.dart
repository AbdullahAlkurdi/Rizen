import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_scaffold.dart';

class PrivacySettingsPage extends StatelessWidget {
  const PrivacySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(PhosphorIconsBold.arrowLeft),
          onPressed: () => context.pop(),
        ),
        title: const Text('Privacy & Security'),
      ),
      body: ListView(
        children: [
          GlassCard(
            child: Row(
              children: [
                Icon(PhosphorIconsBold.fingerprint, color: AppColors.accent),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Biometric Lock',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        'Require Face ID / Touch ID on launch.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: true,
                  activeThumbColor: AppColors.accent,
                  onChanged: (v) {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          GlassCard(
            child: Row(
              children: [
                Icon(PhosphorIconsBold.lockKey, color: AppColors.success),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Local-First Encryption',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        'Data encrypted on device before sync.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Icon(PhosphorIconsBold.checkCircle, color: AppColors.success),
              ],
            ),
          ),
          const SizedBox(height: 12),
          GlassCard(
            onTap: () => context.push(AppRoutes.dataExport),
            child: Row(
              children: [
                Icon(
                  PhosphorIconsBold.downloadSimple,
                  color: Color(0xFF60A5FA),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Export My Data',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Icon(PhosphorIconsBold.caretRight, color: AppColors.textMuted),
              ],
            ),
          ),
          const SizedBox(height: 12),
          GlassCard(
            onTap: () {},
            child: Row(
              children: [
                Icon(PhosphorIconsBold.trash, color: AppColors.accent),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Delete Account',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Icon(PhosphorIconsBold.caretRight, color: AppColors.textMuted),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
