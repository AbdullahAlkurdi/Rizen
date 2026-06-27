abstract final class AppRoutes {
  static const splash = '/';
  static const welcome = '/welcome';
  static const signIn = '/sign-in';
  static const signUp = '/sign-up';
  static const forgotPassword = '/forgot-password';
  static const onboardingLanguage = '/onboarding/language';
  static const onboardingFinance = '/onboarding/finance';
  static const onboardingSpiritual = '/onboarding/spiritual';
  static const onboardingAiPrompt = '/onboarding/ai-prompt';

  static const home = '/home';
  static const dailyScore = '/home/score';
  static const weeklyOverview = '/home/weekly';
  static const monthlyCalendar = '/home/calendar';
  static const notifications = '/home/notifications';
  static const sleepAnalytics = '/home/sleep';

  static const routines = '/routines';
  static const routineCreate = '/routines/create';
  static const routineEdit = '/routines/edit/:routineId';
  static const routineDetail = '/routines/detail/:routineId';
  static const routineTimeBlocks = '/routines/time-blocks/:routineId';
  static const routineAiGenerator = '/routines/ai-generator';
  static const routineTemplates = '/routines/templates';
  static const routineHistory = '/routines/history';

  static const more = '/more';

  static const finance = '/finance';
  static const financeQuickEntry = '/finance/quick-entry';
  static const financeManual = '/finance/manual';
  static const financeCommitments = '/finance/commitments';
  static const financeDailyReview = '/finance/daily-review';
  static const financeMonthlyReport = '/finance/monthly-report';
  static const financeEmergencyExpense = '/finance/emergency-expense';
  static const financeSettings = '/finance/settings';

  static const domainsHub = '/domains';
  static const domains = '/domains';
  static const habitsRecovery = '/habits/recovery';
  static const coachHome = '/coach';
  static String domainDashboard(String id) => '/domains/dashboard/$id';
  static String domainLog(String id) => '/domains/log/$id';

  static const habits = '/habits';
  static const habitAdd = '/habits/add';
  static const habitEdit = '/habits/edit/:habitId';
  static const habitDetail = '/habits/detail/:habitId';
  static const shadowTracker = '/habits/shadow';
  static const shadowScore = '/habits/shadow-score';
  static const habitCheckin = '/habits/checkin';
  static const habitCheckinDetail = '/habits/checkin/:habitId';
  static String habitEditPath(String habitId) => '/habits/edit/$habitId';
  static String habitDetailPath(String habitId) => '/habits/detail/$habitId';
  static String habitCheckinPath(String habitId) => '/habits/checkin/$habitId';
  static const habitAnalytics = '/habits/analytics';
  static const emergencyRecovery = '/habits/recovery';
  static const rewardStore = '/habits/rewards';

  static const coach = '/coach';
  static const coachBriefing = '/coach/briefing';
  static const coachChat = '/coach/chat';
  static const coachWeekly = '/coach/weekly';
  static const coachSuggestions = '/coach/suggestions';
  static const coachMicroGoals = '/coach/micro-goals';
  static const coachInsights = '/coach/insights';

  static const notes = '/notes';
  static const noteCreate = '/notes/create';
  static String noteEdit(String noteId) => '/notes/edit/$noteId';
  static String noteDetail(String noteId) => '/notes/detail/$noteId';
  static const dailyReflection = '/notes/reflection';
  static const notesSearch = '/notes/search';

  static const analytics = '/analytics';
  static const domainCorrelation = '/analytics/correlation';
  static const habitTrends = '/analytics/habit-trends';
  static const growthIndex = '/analytics/growth';
  static const dataExport = '/analytics/export';

  static const islamicHub = '/islamic';
  static const qibla = '/islamic/qibla';
  static const prayerDetail = '/islamic/prayer';
  static const prayerSettings = '/islamic/settings';
  static const hijriCalendar = '/islamic/calendar';
  static const quranTracker = '/islamic/quran';
  static const adhkarChecklist = '/islamic/adhkar';
  static const duaLibrary = '/islamic/dua';
  static const spiritualSummary = '/islamic/summary';

  static const profile = '/settings/profile';
  static const editProfile = '/settings/profile/edit';
  static const appSettings = '/settings/app';
  static const notificationSettings = '/settings/notifications';
  static const languageSettings = '/settings/language';
  static const spiritualSettings = '/settings/spiritual';
  static const privacySettings = '/settings/privacy';
  static const cliAccess = '/settings/cli';
  static const support = '/settings/support';
  static const settings = '/settings';

  static const mainTabRoutes = {
    home,
    dailyScore,
    weeklyOverview,
    routines,
    more,
  };
}
