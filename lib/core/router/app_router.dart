import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/islamic/presentation/cubit/prayer_times_cubit.dart';
import '../../features/islamic/presentation/cubit/spiritual_cubit.dart';
import '../../features/islamic/data/models/adhkar_session.dart';
import '../../features/islamic/presentation/pages/hijri_calendar_page.dart';
import '../../features/islamic/presentation/pages/islamic_hub_page.dart';
import '../../features/islamic/presentation/pages/adhkar_checklist_page.dart';
import '../../features/islamic/presentation/pages/dua_library_page.dart';
import '../../features/islamic/presentation/pages/prayer_detail_page.dart';
import '../../features/islamic/presentation/pages/prayer_settings_page.dart';
import '../../features/islamic/presentation/pages/qibla_page.dart';
import '../../features/islamic/presentation/pages/quran_tracker_page.dart';
import '../../features/islamic/presentation/pages/spiritual_summary_page.dart';
import '../../features/analytics/presentation/pages/analytics_hub_page.dart';
import '../../features/analytics/presentation/pages/data_export_page.dart';
import '../../features/analytics/presentation/pages/domain_correlation_page.dart';
import '../../features/analytics/presentation/pages/growth_index_page.dart';
import '../../features/analytics/presentation/pages/habit_trends_page.dart';
import '../../features/auth/data/repositories/auth_repository.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/welcome_page.dart';
import '../../features/coach/data/repositories/coach_repository.dart';
import '../../features/coach/presentation/cubit/coach_cubit.dart';
import '../../features/coach/presentation/pages/coach_briefing_page.dart';
import '../../features/coach/presentation/pages/coach_chat_page.dart';
import '../../features/coach/presentation/pages/coach_hub_page.dart';
import '../../features/coach/presentation/pages/coach_insights_page.dart';
import '../../features/coach/presentation/pages/coach_micro_goals_page.dart';
import '../../features/coach/presentation/pages/coach_suggestions_page.dart';
import '../../features/coach/presentation/pages/coach_weekly_page.dart';
import '../../features/domains/presentation/cubit/domain_logs_cubit.dart';
import '../../features/domains/presentation/pages/domain_dashboard_page.dart';
import '../../features/domains/presentation/pages/domain_log_page.dart';
import '../../features/domains/presentation/pages/domains_hub_page.dart';
import '../../features/finance/presentation/cubit/finance_cubit.dart';
import '../../features/finance/presentation/pages/commitments_page.dart';
import '../../features/finance/presentation/pages/daily_review_page.dart';
import '../../features/finance/presentation/pages/emergency_expense_page.dart';
import '../../features/finance/presentation/pages/finance_hub_page.dart';
import '../../features/finance/presentation/pages/finance_settings_page.dart';
import '../../features/finance/presentation/pages/manual_transaction_page.dart';
import '../../features/finance/presentation/pages/monthly_report_page.dart';
import '../../features/finance/presentation/pages/quick_expense_entry_page.dart';
import '../../features/habits/presentation/cubit/habits_cubit.dart';
import '../../features/habits/presentation/pages/add_habit_page.dart';
import '../../features/habits/presentation/pages/emergency_recovery_page.dart';
import '../../features/habits/presentation/pages/habit_analytics_page.dart';
import '../../features/habits/presentation/pages/habit_checkin_page.dart';
import '../../features/habits/presentation/pages/habit_detail_page.dart';
import '../../features/habits/presentation/pages/habits_hub_page.dart';
import '../../features/habits/presentation/pages/reward_store_page.dart';
import '../../features/habits/presentation/pages/shadow_score_page.dart';
import '../../features/habits/presentation/pages/shadow_tracker_page.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/home/presentation/pages/daily_score_page.dart';
import '../../features/home/presentation/pages/home_dashboard_page.dart';
import '../../features/home/presentation/pages/monthly_calendar_page.dart';
import '../../features/home/presentation/pages/notifications_page.dart';
import '../../features/home/presentation/pages/sleep_analytics_page.dart';
import '../../features/home/presentation/pages/weekly_overview_page.dart';
import '../../features/routines/data/repositories/routine_repository.dart';
import '../../features/habits/data/repositories/habits_repository.dart';
import '../../features/domains/data/repositories/domain_logs_repository.dart';
import '../../features/home/data/repositories/sleep_log_repository.dart';
import '../../features/notes/data/repositories/notes_repository.dart';
import '../../features/finance/data/repositories/finance_repository.dart';
import '../../features/islamic/data/repositories/prayer_times_repository.dart';
import '../../features/more/presentation/pages/more_hub_page.dart';
import '../../features/notes/presentation/cubit/notes_cubit.dart';
import '../../features/notes/presentation/pages/create_note_page.dart';
import '../../features/notes/presentation/pages/daily_reflection_page.dart';
import '../../features/notes/presentation/pages/edit_note_page.dart';
import '../../features/notes/presentation/pages/note_detail_page.dart';
import '../../features/notes/presentation/pages/notes_hub_page.dart';
import '../../features/notes/presentation/pages/notes_search_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_ai_prompt_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_finance_setup_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_language_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_spiritual_page.dart';
import '../../features/routines/presentation/bloc/routines_bloc.dart';
import '../../features/routines/presentation/pages/ai_routine_generator_page.dart';
import '../../features/routines/presentation/pages/create_routine_page.dart';
import '../../features/routines/presentation/pages/edit_routine_page.dart';
import '../../features/routines/presentation/pages/routine_detail_page.dart';
import '../../features/routines/presentation/pages/routine_history_page.dart';
import '../../features/routines/presentation/pages/routine_templates_page.dart';
import '../../features/routines/presentation/pages/routine_time_block_editor_page.dart';
import '../../features/routines/presentation/pages/routines_hub_page.dart';
import '../../features/settings/presentation/cubit/settings_cubit.dart';
import '../../features/settings/presentation/pages/app_settings_page.dart';
import '../../features/settings/presentation/pages/cli_access_page.dart';
import '../../features/settings/presentation/pages/edit_profile_page.dart';
import '../../features/settings/presentation/pages/language_settings_page.dart';
import '../../features/settings/presentation/pages/notification_settings_page.dart';
import '../../features/settings/presentation/pages/privacy_settings_page.dart';
import '../../features/settings/presentation/pages/profile_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/settings/presentation/pages/spiritual_settings_page.dart';
import '../../features/settings/presentation/pages/support_page.dart';
import '../../features/shell/presentation/pages/main_shell_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import 'app_routes.dart';

AuthState _getAuthState(BuildContext context) {
  try {
    return context.read<AuthCubit>().state;
  } catch (_) {
    return AuthInitial();
  }
}

String? _authRedirect(BuildContext context, GoRouterState state) {
  final authState = _getAuthState(context);
  final isUnauthenticated =
      authState is AuthUnauthenticated || authState is AuthInitial;
  final location = state.uri.path;
  final isOnboardingOrAuth =
      location == AppRoutes.splash ||
      location == AppRoutes.welcome ||
      location == AppRoutes.signIn ||
      location == AppRoutes.signUp ||
      location == AppRoutes.forgotPassword ||
      location.startsWith('/onboarding/');

  if (isUnauthenticated && !isOnboardingOrAuth) {
    return AppRoutes.signIn;
  }
  if (!isUnauthenticated && isOnboardingOrAuth) {
    return AppRoutes.home;
  }
  return null;
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  redirect: _authRedirect,
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
      builder: (context, state) => BlocProvider(
        create: (_) => AuthCubit(repository: AuthRepository()),
        child: const LoginPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.signUp,
      builder: (context, state) => BlocProvider(
        create: (_) => AuthCubit(repository: AuthRepository()),
        child: const RegisterPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.forgotPassword,
      builder: (context, state) => BlocProvider(
        create: (_) => AuthCubit(repository: AuthRepository()),
        child: const ForgotPasswordPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.onboardingLanguage,
      builder: (context, state) => const OnboardingLanguagePage(),
    ),
    GoRoute(
      path: AppRoutes.onboardingFinance,
      builder: (context, state) => BlocProvider(
        create: (_) => FinanceCubit(),
        child: const OnboardingFinanceSetupPage(),
      ),
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
          builder: (context, state) => BlocProvider(
            create: (_) => RoutineCubit(RoutineRepository()),
            child: const HomeDashboardPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.dailyScore,
          builder: (context, state) => BlocProvider(
            create: (_) => HomeCubit(
              routineRepository: RoutineRepository(),
              habitsRepository: HabitsRepository(),
              domainLogsRepository: DomainLogsRepository(),
              sleepLogRepository: SleepLogRepository(),
            )..loadHome(),
            child: const DailyScorePage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.weeklyOverview,
          builder: (context, state) => BlocProvider(
            create: (_) => HomeCubit(
              routineRepository: RoutineRepository(),
              habitsRepository: HabitsRepository(),
              domainLogsRepository: DomainLogsRepository(),
              sleepLogRepository: SleepLogRepository(),
            )..loadHome(),
            child: const WeeklyOverviewPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.monthlyCalendar,
          builder: (context, state) => BlocProvider(
            create: (_) => HomeCubit(
              routineRepository: RoutineRepository(),
              habitsRepository: HabitsRepository(),
              domainLogsRepository: DomainLogsRepository(),
              sleepLogRepository: SleepLogRepository(),
            )..loadHome(),
            child: const MonthlyCalendarPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.notifications,
          builder: (context, state) => BlocProvider(
            create: (_) => HomeCubit(
              routineRepository: RoutineRepository(),
              habitsRepository: HabitsRepository(),
              domainLogsRepository: DomainLogsRepository(),
              sleepLogRepository: SleepLogRepository(),
            )..loadHome(),
            child: const NotificationsPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.sleepAnalytics,
          builder: (context, state) => BlocProvider(
            create: (_) => HomeCubit(
              routineRepository: RoutineRepository(),
              habitsRepository: HabitsRepository(),
              domainLogsRepository: DomainLogsRepository(),
              sleepLogRepository: SleepLogRepository(),
            )..loadHome(),
            child: const SleepAnalyticsPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.routines,
          builder: (context, state) => BlocProvider(
            create: (_) => RoutineCubit(RoutineRepository()),
            child: const RoutinesHubPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.routineCreate,
          builder: (context, state) => BlocProvider(
            create: (_) => RoutineCubit(RoutineRepository()),
            child: const CreateRoutinePage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.routineEdit,
          builder: (context, state) => BlocProvider(
            create: (_) => RoutineCubit(RoutineRepository()),
            child: EditRoutinePage(
              routineId: state.pathParameters['routineId']!,
            ),
          ),
        ),
        GoRoute(
          path: AppRoutes.routineDetail,
          builder: (context, state) => BlocProvider(
            create: (_) => RoutineCubit(RoutineRepository()),
            child: RoutineDetailPage(
              routineId: state.pathParameters['routineId']!,
            ),
          ),
        ),
        GoRoute(
          path: AppRoutes.routineTimeBlocks,
          builder: (context, state) => BlocProvider(
            create: (_) => RoutineCubit(RoutineRepository()),
            child: RoutineTimeBlockEditorPage(
              routineId: state.pathParameters['routineId']!,
            ),
          ),
        ),
        GoRoute(
          path: AppRoutes.routineAiGenerator,
          builder: (context, state) => BlocProvider(
            create: (_) => RoutineCubit(RoutineRepository()),
            child: const AiRoutineGeneratorPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.routineTemplates,
          builder: (context, state) => BlocProvider(
            create: (_) => RoutineCubit(RoutineRepository()),
            child: const RoutineTemplatesPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.routineHistory,
          builder: (context, state) => BlocProvider(
            create: (_) => RoutineCubit(RoutineRepository()),
            child: const RoutineHistoryPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.more,
          builder: (context, state) => const MoreHubPage(),
        ),
        GoRoute(
          path: AppRoutes.finance,
          builder: (context, state) => BlocProvider(
            create: (_) => FinanceCubit(),
            child: const FinanceHubPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.financeQuickEntry,
          builder: (context, state) => BlocProvider(
            create: (_) => FinanceCubit(),
            child: const QuickExpenseEntryPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.financeManual,
          builder: (context, state) => BlocProvider(
            create: (_) => FinanceCubit(),
            child: ManualTransactionPage(
              initialDescription: state.extra as String?,
            ),
          ),
        ),
        GoRoute(
          path: AppRoutes.financeCommitments,
          builder: (context, state) => BlocProvider(
            create: (_) => FinanceCubit(),
            child: const CommitmentsPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.financeDailyReview,
          builder: (context, state) => BlocProvider(
            create: (_) => FinanceCubit(),
            child: const DailyReviewPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.financeMonthlyReport,
          builder: (context, state) => BlocProvider(
            create: (_) => FinanceCubit(),
            child: const MonthlyReportPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.financeEmergencyExpense,
          builder: (context, state) => BlocProvider(
            create: (_) => FinanceCubit(),
            child: const EmergencyExpensePage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.financeSettings,
          builder: (context, state) => BlocProvider(
            create: (_) => FinanceCubit(),
            child: const FinanceSettingsPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.domainsHub,
          builder: (context, state) => const DomainsHubPage(),
        ),
        GoRoute(
          path: '/domains/dashboard/:id',
          builder: (context, state) => BlocProvider(
            create: (_) =>
                DomainLogsCubit()..loadLogs(state.pathParameters['id']!),
            child: DomainDashboardPage(domainId: state.pathParameters['id']!),
          ),
        ),
        GoRoute(
          path: '/domains/log/:id',
          builder: (context, state) => BlocProvider(
            create: (_) => DomainLogsCubit(),
            child: DomainLogPage(domainId: state.pathParameters['id']!),
          ),
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
          path: AppRoutes.settings,
          builder: (context, state) => BlocProvider(
            create: (_) => SettingsCubit(),
            child: const SettingsPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.habits,
          builder: (context, state) => BlocProvider(
            create: (_) => HabitsCubit(),
            child: const HabitsHubPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.habitAdd,
          builder: (context, state) => BlocProvider(
            create: (_) => HabitsCubit(),
            child: const AddHabitPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.habitEdit,
          builder: (context, state) => BlocProvider(
            create: (_) => HabitsCubit(),
            child: AddHabitPage(habitId: state.pathParameters['habitId']!),
          ),
        ),
        GoRoute(
          path: AppRoutes.habitDetail,
          builder: (context, state) => BlocProvider(
            create: (_) => HabitsCubit(),
            child: HabitDetailPage(habitId: state.pathParameters['habitId']!),
          ),
        ),
        GoRoute(
          path: AppRoutes.habitAnalytics,
          builder: (context, state) => const HabitAnalyticsPage(),
        ),
        GoRoute(
          path: AppRoutes.habitCheckin,
          builder: (context, state) => BlocProvider(
            create: (_) => HabitsCubit(),
            child: const HabitCheckinPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.habitCheckinDetail,
          builder: (context, state) => BlocProvider(
            create: (_) => HabitsCubit(),
            child: HabitCheckinPage(habitId: state.pathParameters['habitId']!),
          ),
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
          builder: (context, state) => BlocProvider(
            create: (_) => CoachCubit(
              repository: CoachRepository(
                habitsRepository: HabitsRepository(),
                financeRepository: FinanceRepository(),
                notesRepository: NotesRepository(),
                domainLogsRepository: DomainLogsRepository(),
                prayerTimesRepository: PrayerTimesRepository(),
              ),
            )..loadHistory(),
            child: const CoachHubPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.coachBriefing,
          builder: (context, state) => BlocProvider(
            create: (_) => CoachCubit(
              repository: CoachRepository(
                habitsRepository: HabitsRepository(),
                financeRepository: FinanceRepository(),
                notesRepository: NotesRepository(),
                domainLogsRepository: DomainLogsRepository(),
                prayerTimesRepository: PrayerTimesRepository(),
              ),
            )..loadHistory(),
            child: const CoachBriefingPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.coachChat,
          builder: (context, state) => BlocProvider(
            create: (_) => CoachCubit(
              repository: CoachRepository(
                habitsRepository: HabitsRepository(),
                financeRepository: FinanceRepository(),
                notesRepository: NotesRepository(),
                domainLogsRepository: DomainLogsRepository(),
                prayerTimesRepository: PrayerTimesRepository(),
              ),
            )..loadHistory(),
            child: const CoachChatPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.coachWeekly,
          builder: (context, state) => BlocProvider(
            create: (_) => CoachCubit(
              repository: CoachRepository(
                habitsRepository: HabitsRepository(),
                financeRepository: FinanceRepository(),
                notesRepository: NotesRepository(),
                domainLogsRepository: DomainLogsRepository(),
                prayerTimesRepository: PrayerTimesRepository(),
              ),
            )..loadHistory(),
            child: const CoachWeeklyPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.coachSuggestions,
          builder: (context, state) => BlocProvider(
            create: (_) => CoachCubit(
              repository: CoachRepository(
                habitsRepository: HabitsRepository(),
                financeRepository: FinanceRepository(),
                notesRepository: NotesRepository(),
                domainLogsRepository: DomainLogsRepository(),
                prayerTimesRepository: PrayerTimesRepository(),
              ),
            )..loadHistory(),
            child: const CoachSuggestionsPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.coachMicroGoals,
          builder: (context, state) => BlocProvider(
            create: (_) => CoachCubit(
              repository: CoachRepository(
                habitsRepository: HabitsRepository(),
                financeRepository: FinanceRepository(),
                notesRepository: NotesRepository(),
                domainLogsRepository: DomainLogsRepository(),
                prayerTimesRepository: PrayerTimesRepository(),
              ),
            )..loadHistory(),
            child: const CoachMicroGoalsPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.coachInsights,
          builder: (context, state) => BlocProvider(
            create: (_) => CoachCubit(
              repository: CoachRepository(
                habitsRepository: HabitsRepository(),
                financeRepository: FinanceRepository(),
                notesRepository: NotesRepository(),
                domainLogsRepository: DomainLogsRepository(),
                prayerTimesRepository: PrayerTimesRepository(),
              ),
            )..loadHistory(),
            child: const CoachInsightsPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.notes,
          builder: (context, state) => BlocProvider(
            create: (_) => NotesCubit()..loadNotes(),
            child: const NotesHubPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.noteCreate,
          builder: (context, state) => BlocProvider(
            create: (_) => NotesCubit(),
            child: const CreateNotePage(),
          ),
        ),
        GoRoute(
          path: '/notes/edit/:noteId',
          builder: (context, state) => BlocProvider(
            create: (_) => NotesCubit(),
            child: EditNotePage(noteId: state.pathParameters['noteId']!),
          ),
        ),
        GoRoute(
          path: '/notes/detail/:noteId',
          builder: (context, state) => BlocProvider(
            create: (_) => NotesCubit(),
            child: NoteDetailPage(noteId: state.pathParameters['noteId']!),
          ),
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
          path: AppRoutes.islamicHub,
          builder: (context, state) => BlocProvider(
            create: (_) => PrayerTimesCubit(),
            child: const IslamicHubPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.qibla,
          builder: (context, state) => const QiblaPage(),
        ),
        GoRoute(
          path: AppRoutes.prayerDetail,
          builder: (context, state) => PrayerDetailPage(
            prayerName: state.uri.queryParameters['name'] ?? 'Fajr',
          ),
        ),
        GoRoute(
          path: AppRoutes.prayerSettings,
          builder: (context, state) => const PrayerSettingsPage(),
        ),
        GoRoute(
          path: AppRoutes.hijriCalendar,
          builder: (context, state) => const HijriCalendarPage(),
        ),
        GoRoute(
          path: AppRoutes.quranTracker,
          builder: (context, state) => BlocProvider(
            create: (_) => SpiritualCubit()..loadQuranTracker(),
            child: const QuranTrackerPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.adhkarChecklist,
          builder: (context, state) => BlocProvider(
            create: (_) => SpiritualCubit()..loadAdhkarChecklist(AdhkarSession.morning),
            child: const AdhkarChecklistPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.duaLibrary,
          builder: (context, state) => BlocProvider(
            create: (_) => SpiritualCubit()..loadDuaLibrary(),
            child: const DuaLibraryPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.spiritualSummary,
          builder: (context, state) => BlocProvider(
            create: (_) => SpiritualCubit()..loadSpiritualSummary(),
            child: const SpiritualSummaryPage(),
          ),
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
