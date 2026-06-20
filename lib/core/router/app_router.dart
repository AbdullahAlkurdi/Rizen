import 'package:go_router/go_router.dart';

import '../../features/analytics/presentation/pages/analytics_hub_page.dart';
import '../../features/analytics/presentation/pages/data_export_page.dart';
import '../../features/analytics/presentation/pages/domain_correlation_page.dart';
import '../../features/analytics/presentation/pages/growth_index_page.dart';
import '../../features/analytics/presentation/pages/habit_trends_page.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/sign_in_page.dart';
import '../../features/auth/presentation/pages/sign_up_page.dart';
import '../../features/auth/presentation/pages/welcome_page.dart';
import '../../features/coach/presentation/pages/coach_briefing_page.dart';
import '../../features/coach/presentation/pages/coach_chat_page.dart';
import '../../features/coach/presentation/pages/coach_hub_page.dart';
import '../../features/coach/presentation/pages/coach_insights_page.dart';
import '../../features/coach/presentation/pages/coach_micro_goals_page.dart';
import '../../features/coach/presentation/pages/coach_suggestions_page.dart';
import '../../features/coach/presentation/pages/coach_weekly_page.dart';
import '../../features/domains/presentation/pages/domains_hub_page.dart';
import '../../features/habits/presentation/pages/add_habit_page.dart';
import '../../features/habits/presentation/pages/emergency_recovery_page.dart';
import '../../features/habits/presentation/pages/habit_analytics_page.dart';
import '../../features/habits/presentation/pages/habit_checkin_page.dart';
import '../../features/habits/presentation/pages/habit_detail_page.dart';
import '../../features/habits/presentation/pages/habits_hub_page.dart';
import '../../features/habits/presentation/pages/reward_store_page.dart';
import '../../features/habits/presentation/pages/shadow_score_page.dart';
import '../../features/habits/presentation/pages/shadow_tracker_page.dart';
import '../../features/home/presentation/pages/daily_score_page.dart';
import '../../features/home/presentation/pages/home_dashboard_page.dart';
import '../../features/home/presentation/pages/monthly_calendar_page.dart';
import '../../features/home/presentation/pages/notifications_page.dart';
import '../../features/home/presentation/pages/sleep_analytics_page.dart';
import '../../features/home/presentation/pages/weekly_overview_page.dart';
import '../../features/more/presentation/pages/more_hub_page.dart';
import '../../features/notes/presentation/pages/create_note_page.dart';
import '../../features/notes/presentation/pages/daily_reflection_page.dart';
import '../../features/notes/presentation/pages/edit_note_page.dart';
import '../../features/notes/presentation/pages/note_detail_page.dart';
import '../../features/notes/presentation/pages/notes_hub_page.dart';
import '../../features/notes/presentation/pages/notes_search_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_ai_prompt_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_language_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_spiritual_page.dart';
import '../../features/routines/presentation/pages/ai_routine_generator_page.dart';
import '../../features/routines/presentation/pages/create_routine_page.dart';
import '../../features/routines/presentation/pages/edit_routine_page.dart';
import '../../features/routines/presentation/pages/routine_detail_page.dart';
import '../../features/routines/presentation/pages/routine_history_page.dart';
import '../../features/routines/presentation/pages/routine_templates_page.dart';
import '../../features/routines/presentation/pages/routine_time_block_editor_page.dart';
import '../../features/routines/presentation/pages/routines_hub_page.dart';
import '../../features/settings/presentation/pages/app_settings_page.dart';
import '../../features/settings/presentation/pages/cli_access_page.dart';
import '../../features/settings/presentation/pages/edit_profile_page.dart';
import '../../features/settings/presentation/pages/language_settings_page.dart';
import '../../features/settings/presentation/pages/notification_settings_page.dart';
import '../../features/settings/presentation/pages/privacy_settings_page.dart';
import '../../features/settings/presentation/pages/profile_page.dart';
import '../../features/settings/presentation/pages/spiritual_settings_page.dart';
import '../../features/settings/presentation/pages/support_page.dart';
import '../../features/shell/presentation/pages/main_shell_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import 'app_routes.dart';

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
        GoRoute(
          path: AppRoutes.monthlyCalendar,
          builder: (context, state) => const MonthlyCalendarPage(),
        ),
        GoRoute(
          path: AppRoutes.notifications,
          builder: (context, state) => const NotificationsPage(),
        ),
        GoRoute(
          path: AppRoutes.sleepAnalytics,
          builder: (context, state) => const SleepAnalyticsPage(),
        ),
        GoRoute(
          path: AppRoutes.routines,
          builder: (context, state) => const RoutinesHubPage(),
        ),
        GoRoute(
          path: AppRoutes.routineCreate,
          builder: (context, state) => const CreateRoutinePage(),
        ),
        GoRoute(
          path: AppRoutes.routineEdit,
          builder: (context, state) => const EditRoutinePage(),
        ),
        GoRoute(
          path: AppRoutes.routineDetail,
          builder: (context, state) => const RoutineDetailPage(),
        ),
        GoRoute(
          path: AppRoutes.routineTimeBlocks,
          builder: (context, state) => const RoutineTimeBlockEditorPage(),
        ),
        GoRoute(
          path: AppRoutes.routineAiGenerator,
          builder: (context, state) => const AiRoutineGeneratorPage(),
        ),
        GoRoute(
          path: AppRoutes.routineTemplates,
          builder: (context, state) => const RoutineTemplatesPage(),
        ),
        GoRoute(
          path: AppRoutes.routineHistory,
          builder: (context, state) => const RoutineHistoryPage(),
        ),
        GoRoute(
          path: AppRoutes.more,
          builder: (context, state) => const MoreHubPage(),
        ),
        GoRoute(
          path: AppRoutes.domainsHub,
          builder: (context, state) => const DomainsHubPage(),
        ),
        GoRoute(
          path: AppRoutes.profile,
          builder: (context, state) => const ProfilePage(),
        ),
        GoRoute(
          path: AppRoutes.editProfile,
          builder: (context, state) => const EditProfilePage(),
        ),
        GoRoute(
          path: AppRoutes.appSettings,
          builder: (context, state) => const AppSettingsPage(),
        ),
        GoRoute(
          path: AppRoutes.notificationSettings,
          builder: (context, state) => const NotificationSettingsPage(),
        ),
        GoRoute(
          path: AppRoutes.languageSettings,
          builder: (context, state) => const LanguageSettingsPage(),
        ),
        GoRoute(
          path: AppRoutes.spiritualSettings,
          builder: (context, state) => const SpiritualSettingsPage(),
        ),
        GoRoute(
          path: AppRoutes.privacySettings,
          builder: (context, state) => const PrivacySettingsPage(),
        ),
        GoRoute(
          path: AppRoutes.cliAccess,
          builder: (context, state) => const CliAccessPage(),
        ),
        GoRoute(
          path: AppRoutes.support,
          builder: (context, state) => const SupportPage(),
        ),
        GoRoute(
          path: AppRoutes.habits,
          builder: (context, state) => const HabitsHubPage(),
        ),
        GoRoute(
          path: AppRoutes.habitAdd,
          builder: (context, state) => const AddHabitPage(),
        ),
        GoRoute(
          path: AppRoutes.habitEdit,
          builder: (context, state) => const AddHabitPage(),
        ),
        GoRoute(
          path: AppRoutes.habitDetail,
          builder: (context, state) => const HabitDetailPage(),
        ),
        GoRoute(
          path: AppRoutes.habitAnalytics,
          builder: (context, state) => const HabitAnalyticsPage(),
        ),
        GoRoute(
          path: AppRoutes.habitCheckin,
          builder: (context, state) => const HabitCheckinPage(),
        ),
        GoRoute(
          path: AppRoutes.shadowTracker,
          builder: (context, state) => const ShadowTrackerPage(),
        ),
        GoRoute(
          path: AppRoutes.shadowScore,
          builder: (context, state) => const ShadowScorePage(),
        ),
        GoRoute(
          path: AppRoutes.emergencyRecovery,
          builder: (context, state) => const EmergencyRecoveryPage(),
        ),
        GoRoute(
          path: AppRoutes.rewardStore,
          builder: (context, state) => const RewardStorePage(),
        ),
        GoRoute(
          path: AppRoutes.coach,
          builder: (context, state) => const CoachHubPage(),
        ),
        GoRoute(
          path: AppRoutes.coachBriefing,
          builder: (context, state) => const CoachBriefingPage(),
        ),
        GoRoute(
          path: AppRoutes.coachChat,
          builder: (context, state) => const CoachChatPage(),
        ),
        GoRoute(
          path: AppRoutes.coachWeekly,
          builder: (context, state) => const CoachWeeklyPage(),
        ),
        GoRoute(
          path: AppRoutes.coachSuggestions,
          builder: (context, state) => const CoachSuggestionsPage(),
        ),
        GoRoute(
          path: AppRoutes.coachMicroGoals,
          builder: (context, state) => const CoachMicroGoalsPage(),
        ),
        GoRoute(
          path: AppRoutes.coachInsights,
          builder: (context, state) => const CoachInsightsPage(),
        ),
        GoRoute(
          path: AppRoutes.notes,
          builder: (context, state) => const NotesHubPage(),
        ),
        GoRoute(
          path: AppRoutes.noteCreate,
          builder: (context, state) => const CreateNotePage(),
        ),
        GoRoute(
          path: AppRoutes.noteEdit,
          builder: (context, state) => const EditNotePage(),
        ),
        GoRoute(
          path: AppRoutes.noteDetail,
          builder: (context, state) => const NoteDetailPage(),
        ),
        GoRoute(
          path: AppRoutes.dailyReflection,
          builder: (context, state) => const DailyReflectionPage(),
        ),
        GoRoute(
          path: AppRoutes.notesSearch,
          builder: (context, state) => const NotesSearchPage(),
        ),
        GoRoute(
          path: AppRoutes.analytics,
          builder: (context, state) => const AnalyticsHubPage(),
        ),
        GoRoute(
          path: AppRoutes.domainCorrelation,
          builder: (context, state) => const DomainCorrelationPage(),
        ),
        GoRoute(
          path: AppRoutes.habitTrends,
          builder: (context, state) => const HabitTrendsPage(),
        ),
        GoRoute(
          path: AppRoutes.growthIndex,
          builder: (context, state) => const GrowthIndexPage(),
        ),
        GoRoute(
          path: AppRoutes.dataExport,
          builder: (context, state) => const DataExportPage(),
        ),
      ],
    ),
  ],
);
