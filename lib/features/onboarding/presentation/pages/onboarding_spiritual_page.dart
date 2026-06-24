import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../widgets/onboarding_step_indicator.dart';

class OnboardingSpiritualPage extends StatefulWidget {
  const OnboardingSpiritualPage({super.key});

  @override
  State<OnboardingSpiritualPage> createState() =>
      _OnboardingSpiritualPageState();
}

class _OnboardingSpiritualPageState extends State<OnboardingSpiritualPage> {
  bool _spiritualEnabled = true;
  String _calculationMethod = 'Muslim World League';
  String? _wakeTime;

  static const _methods = [
    'Muslim World League',
    'Umm Al-Qura',
    'Egyptian General Authority',
    'ISNA',
  ];

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(PhosphorIconsBold.arrowLeft),
          onPressed: () => context.go(AppRoutes.onboardingLanguage),
        ),
        title: const Text('Setup'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OnboardingStepIndicator(currentStep: 2, totalSteps: 3),
          const SizedBox(height: 24),
          Text(
            'Spiritual Layer',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Anchor your daily routine to prayer times with dynamic scheduling.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 28),
          GlassCard(
            child: SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Enable Spiritual Layer',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                'Schedule tasks relative to Fajr, Dhuhr, Asr, Maghrib, and Isha.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              value: _spiritualEnabled,
              activeTrackColor: AppColors.accent.withValues(alpha: 0.5),
              activeThumbColor: AppColors.accent,
              onChanged: (value) => setState(() => _spiritualEnabled = value),
            ),
          ),
          const SizedBox(height: 20),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      PhosphorIconsBold.mapPin,
                      color: AppColors.accent,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Location for Prayer Times',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Uses Aladhan API with your device location for accurate daily recalculation.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: Icon(PhosphorIconsBold.crosshair),
                  label: const Text('Enable Location Access'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          if (!_spiritualEnabled) ...[
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        PhosphorIconsBold.clock,
                        color: AppColors.warning,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Daily Start Time',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'What time does your day usually start? This anchors your time blocks.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: const TimeOfDay(hour: 6, minute: 0),
                      );
                      if (time != null) {
                        setState(() {
                          _wakeTime =
                              '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                        });
                      }
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                      child: Text(
                        _wakeTime ?? 'Select wake time',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (_spiritualEnabled) ...[
            const SizedBox(height: 24),
            Text(
              'Calculation Method',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            ..._methods.map((method) {
              final selected = _calculationMethod == method;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GlassCard(
                  onTap: () => setState(() => _calculationMethod = method),
                  borderColor: selected ? AppColors.accent : null,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          method,
                          style: Theme.of(context).textTheme.bodyLarge,
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
          ],
          const Spacer(),
          RizenButton(
            label: 'Continue',
            icon: PhosphorIconsBold.arrowRight,
            onPressed: () => context.go(AppRoutes.onboardingAiPrompt),
          ),
        ],
      ),
    );
  }
}
