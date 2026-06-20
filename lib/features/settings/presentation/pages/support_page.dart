import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/nav_glass_tile.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/rizen_scaffold.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(PhosphorIconsBold.arrowLeft),
          onPressed: () => context.pop(),
        ),
        title: const Text('Support & Feedback'),
      ),
      body: ListView(
        children: [
          const PageHeader(
            title: 'Help & Community',
            subtitle: 'We\'re here to help you master your Life OS.',
          ),
          const SizedBox(height: 20),
          NavGlassTile(
            title: 'FAQs & Documentation',
            subtitle: 'Common questions and setup guides.',
            icon: PhosphorIconsBold.bookOpen,
            iconColor: Color(0xFF60A5FA),
            onTap: () {},
          ),
          const SizedBox(height: 10),
          NavGlassTile(
            title: 'Send Feedback',
            subtitle: 'Report bugs, request features, or share ideas.',
            icon: PhosphorIconsBold.chatCircleText,
            iconColor: AppColors.success,
            onTap: () {},
          ),
          const SizedBox(height: 10),
          NavGlassTile(
            title: 'Open Source Attributions',
            subtitle: 'Licenses and third-party acknowledgments.',
            icon: PhosphorIconsBold.code,
            iconColor: AppColors.shadow,
            onTap: () {},
          ),
          const SizedBox(height: 20),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(PhosphorIconsBold.info, color: AppColors.accent),
                    const SizedBox(width: 10),
                    Text(
                      'RizenOS v1.0.0',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Built with Flutter, Firebase, and Google Gemini.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Discipline without burnout. Growth without imbalance.',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
