import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../widgets/onboarding_step_indicator.dart';

class OnboardingLanguagePage extends StatefulWidget {
  const OnboardingLanguagePage({super.key});

  @override
  State<OnboardingLanguagePage> createState() => _OnboardingLanguagePageState();
}

class _OnboardingLanguagePageState extends State<OnboardingLanguagePage> {
  String _language = 'English';
  String _region = 'United States';

  static const _languages = [
    'English',
    'Arabic',
    'French',
    'German',
    'Spanish',
    'Turkish',
    'Urdu',
    'Indonesian',
    'Malay',
  ];

  static const _regions = [
    'United States',
    'United Kingdom',
    'Saudi Arabia',
    'UAE',
    'Egypt',
    'Morocco',
    'France',
    'Germany',
    'Spain',
    'Turkey',
    'Pakistan',
    'Indonesia',
    'Malaysia',
  ];

  static const Map<String, List<String>> _languageRegions = {
    'English': ['United States', 'United Kingdom', 'Pakistan'],
    'Arabic': ['Saudi Arabia', 'UAE', 'Egypt', 'Morocco'],
    'French': ['France'],
    'German': ['Germany'],
    'Spanish': ['Spain'],
    'Turkish': ['Turkey'],
    'Urdu': ['Pakistan'],
    'Indonesian': ['Indonesia'],
    'Malay': ['Malaysia'],
  };

  List<String> get _availableRegions => _languageRegions[_language] ?? _regions;

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      appBar: AppBar(
        title: Text('Setup', style: TextStyle(color: AppColors.textPrimary)),
        actions: [
          TextButton(
            onPressed: () => context.go(AppRoutes.onboardingSpiritual),
            child: Text('Skip', style: TextStyle(color: AppColors.textPrimary)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const OnboardingStepIndicator(currentStep: 1, totalSteps: 3),
            const SizedBox(height: 24),
            Text(
              'Language & Region',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppColors.textPrimary),
            ),
            const SizedBox(height: 8),
            Text(
              'RizenOS supports Arabic-first layouts with full RTL support.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 28),
            Text('Language', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.textPrimary)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _languages.map((language) {
                final selected = _language == language;
                return ChoiceChip(
                  label: Text(language),
                  selected: selected,
                  onSelected: (value) {
                    setState(() {
                      _language = language;
                      final available = _languageRegions[language];
                      if (available != null && !available.contains(_region)) {
                        _region = available.first;
                      }
                    });
                  },
                  selectedColor: AppColors.accent.withValues(alpha: 0.25),
                  labelStyle: TextStyle(
                    color: selected
                        ? AppColors.accent
                        : AppColors.textSecondary,
                  ),
                  side: BorderSide(
                    color: selected ? AppColors.accent : AppColors.glassBorder,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 28),
            Text('Region', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.textPrimary)),
            const SizedBox(height: 12),
            ..._availableRegions.map((region) {
              final selected = _region == region;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GlassCard(
                  onTap: () => setState(() => _region = region),
                  borderColor: selected ? AppColors.accent : null,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        PhosphorIconsBold.globeHemisphereWest,
                        color: selected
                            ? AppColors.accent
                            : AppColors.textMuted,
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          region,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.textPrimary),
                        ),
                      ),
                      if (selected)
                        Icon(
                          PhosphorIconsFill.checkCircle,
                          color: AppColors.accent,
                        ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 24),
            RizenButton(
              label: 'Continue',
              icon: PhosphorIconsBold.arrowRight,
              onPressed: () => context.go(AppRoutes.onboardingFinance),
            ),
          ],
        ),
      ),
    );
  }
}
