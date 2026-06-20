import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';

class DomainCorrelationPage extends StatelessWidget {
  const DomainCorrelationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FeatureScaffold(
      title: 'Domain Correlation',
      subtitle: 'Evaluating intersections between life pillars.',
      body: ListView(
        children: [
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Strong Correlations',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                ...List.generate(3, (i) {
                  final corr = [
                    (
                      'Spiritual ↔ Coding',
                      '+18%',
                      Color(0xFFFBBF24),
                      Color(0xFF60A5FA),
                    ),
                    (
                      'Sports ↔ Sleep',
                      '+12%',
                      Color(0xFF4ADE80),
                      AppColors.warning,
                    ),
                    (
                      'Study ↔ Work',
                      '+9%',
                      Color(0xFF818CF8),
                      Color(0xFF38BDF8),
                    ),
                  ][i];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: corr.$3.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            corr.$1,
                            style: Theme.of(
                              context,
                            ).textTheme.labelMedium?.copyWith(color: corr.$3),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(PhosphorIconsBold.arrowRight, color: corr.$4),
                        const Spacer(),
                        Text(
                          corr.$2,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: AppColors.success),
                        ),
                      ],
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
