import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../widgets/onboarding_step_indicator.dart';

class OnboardingAiPromptPage extends StatefulWidget {
  const OnboardingAiPromptPage({super.key});

  @override
  State<OnboardingAiPromptPage> createState() => _OnboardingAiPromptPageState();
}

class _OnboardingAiPromptPageState extends State<OnboardingAiPromptPage> {
  final _promptController = TextEditingController(
    text:
        'I feel distracted, gained weight, want to commit to my prayers and coding, but my day slips away.',
  );
  bool _isProcessing = false;
  bool _showAiResponse = false;

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  Future<void> _processWithAi() async {
    if (_promptController.text.trim().isEmpty) return;

    setState(() {
      _isProcessing = true;
      _showAiResponse = false;
    });

    await Future<void>.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    setState(() {
      _isProcessing = false;
      _showAiResponse = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(PhosphorIconsBold.arrowLeft),
          onPressed: () => context.go(AppRoutes.onboardingSpiritual),
        ),
        title: const Text('Setup'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OnboardingStepIndicator(currentStep: 3, totalSteps: 3),
          const SizedBox(height: 24),
          Row(
            children: [
              Icon(PhosphorIconsFill.sparkle, color: AppColors.accent),
              const SizedBox(width: 10),
              Text(
                'The "Aha!" Moment',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Describe your life in your own words. Gemini will build your initial RizenOS.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView(
              children: [
                TextField(
                  controller: _promptController,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    hintText:
                        'Tell Rizen what you struggle with and what you want to achieve...',
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    OutlinedButton.icon(
                      onPressed: _isProcessing ? null : () {},
                      icon: Icon(PhosphorIconsBold.microphone),
                      label: const Text('Voice Input'),
                    ),
                    const Spacer(),
                    RizenButton(
                      label: _isProcessing ? 'Analyzing...' : 'Analyze',
                      expand: false,
                      isLoading: _isProcessing,
                      icon: PhosphorIconsBold.magicWand,
                      onPressed: _processWithAi,
                    ),
                  ],
                ),
                if (_showAiResponse) ...[
                  const SizedBox(height: 24),
                  GlassCard(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.accent.withValues(alpha: 0.15),
                        AppColors.shadow.withValues(alpha: 0.1),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              PhosphorIconsFill.robot,
                              color: AppColors.accent,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'AI Coach Brief',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'I hear you. Let\'s start with balance — not perfection.',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 16),
                        _AiResultChip(
                          icon: PhosphorIconsBold.barbell,
                          label: 'Sports domain activated',
                        ),
                        _AiResultChip(
                          icon: PhosphorIconsBold.code,
                          label: 'Coding domain activated',
                        ),
                        _AiResultChip(
                          icon: PhosphorIconsBold.moonStars,
                          label: 'Spiritual layer linked to prayer times',
                        ),
                        _AiResultChip(
                          icon: PhosphorIconsBold.clockCountdown,
                          label: 'Morning routine with 3 time blocks created',
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          RizenButton(
            label: 'Launch RizenOS',
            icon: PhosphorIconsBold.rocketLaunch,
            onPressed: _showAiResponse
                ? () => context.go(AppRoutes.home)
                : _processWithAi,
          ),
        ],
      ),
    );
  }
}

class _AiResultChip extends StatelessWidget {
  const _AiResultChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.success),
          const SizedBox(width: 10),
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
