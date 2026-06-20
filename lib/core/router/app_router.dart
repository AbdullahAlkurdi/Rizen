import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/app_routes.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/sign_in_page.dart';
import '../../features/auth/presentation/pages/sign_up_page.dart';
import '../../features/auth/presentation/pages/welcome_page.dart';
import '../../features/home/presentation/pages/daily_score_page.dart';
import '../../features/home/presentation/pages/home_dashboard_page.dart';
import '../../features/home/presentation/pages/weekly_overview_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_ai_prompt_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_language_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_spiritual_page.dart';
import '../../features/shell/presentation/pages/main_shell_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: AppRoutes.welcome,
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: AppRoutes.signIn,
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: AppRoutes.signUp,
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      path: AppRoutes.forgotPassword,
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    GoRoute(
      path: AppRoutes.onboardingLanguage,
      builder: (context, state) => const OnboardingLanguagePage(),
    ),
    GoRoute(
      path: AppRoutes.onboardingSpiritual,
      builder: (context, state) => const OnboardingSpiritualPage(),
    ),
    GoRoute(
      path: AppRoutes.onboardingAiPrompt,
      builder: (context, state) => const OnboardingAiPromptPage(),
    ),
    ShellRoute(
      builder: (context, state, child) => MainShellPage(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomeDashboardPage(),
        ),
        GoRoute(
          path: AppRoutes.dailyScore,
          builder: (context, state) => const DailyScorePage(),
        ),
        GoRoute(
          path: AppRoutes.weeklyOverview,
          builder: (context, state) => const WeeklyOverviewPage(),
        ),
      ],
    ),
  ],
);
