import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final _pageController = PageController();
  int _currentPage = 0;

  static const _slides = [
    _WelcomeSlide(
      icon: PhosphorIconsFill.target,
      title: 'Discipline without burnout',
      body:
          'Rizen adapts to your life — not the other way around. Sustainable growth, every day.',
    ),
    _WelcomeSlide(
      icon: PhosphorIconsFill.brain,
      title: 'Your Life Operating System',
      body:
          'Routines, habits, domains, and AI coaching — unified in one adaptive ecosystem.',
    ),
    _WelcomeSlide(
      icon: PhosphorIconsFill.moonStars,
      title: 'Balance & alignment',
      body:
          'Integrate spiritual rhythm, worldly productivity, and recovery when you need it most.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      padding: EdgeInsets.zero,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _slides.length,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemBuilder: (context, index) {
                final slide = _slides[index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(28, 48, 28, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GlassCard(
                        padding: const EdgeInsets.all(24),
                        child: Icon(
                          slide.icon,
                          size: 40,
                          color: AppColors.accent,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        slide.title,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        slide.body,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _slides.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentPage == index ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? AppColors.accent
                      : AppColors.textMuted.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                RizenButton(
                  label: 'Get Started',
                  icon: PhosphorIconsBold.arrowRight,
                  onPressed: () => context.go(AppRoutes.signUp),
                ),
                const SizedBox(height: 12),
                RizenButton(
                  label: 'I already have an account',
                  variant: RizenButtonVariant.ghost,
                  onPressed: () => context.go(AppRoutes.signIn),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WelcomeSlide {
  const _WelcomeSlide({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;
}
