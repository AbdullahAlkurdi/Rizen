abstract final class AppRoutes {
  static const splash = '/';
  static const welcome = '/welcome';
  static const signIn = '/sign-in';
  static const signUp = '/sign-up';
  static const forgotPassword = '/forgot-password';
  static const onboardingLanguage = '/onboarding/language';
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
  static const routineEdit = '/routines/edit';
  static const routineDetail = '/routines/detail';
  static const routineTimeBlocks = '/routines/time-blocks';
  static const routineAiGenerator = '/routines/ai-generator';
  static const routineTemplates = '/routines/templates';
  static const routineHistory = '/routines/history';

  static const more = '/more';

  static const domainsHub = '/domains';
  static String domainDashboard(String id) => '/domains/dashboard/$id';
  static String domainLog(String id) => '/domains/log/$id';

  static const habits = '/habits';
  static const habitAdd = '/habits/add';
  static const habitEdit = '/habits/edit';
  static const habitDetail = '/habits/detail';
  static const shadowTracker = '/habits/shadow';
  static const shadowScore = '/habits/shadow-score';
  static const habitCheckin = '/habits/checkin';
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
  static const noteEdit = '/notes/edit';
  static const noteDetail = '/notes/detail';
  static const dailyReflection = '/notes/reflection';
  static const notesSearch = '/notes/search';

  static const analytics = '/analytics';
  static const domainCorrelation = '/analytics/correlation';
  static const habitTrends = '/analytics/habit-trends';
  static const growthIndex = '/analytics/growth';
  static const dataExport = '/analytics/export';

  static const profile = '/settings/profile';
  static const editProfile = '/settings/profile/edit';
  static const appSettings = '/settings/app';
  static const notificationSettings = '/settings/notifications';
  static const languageSettings = '/settings/language';
  static const spiritualSettings = '/settings/spiritual';
  static const privacySettings = '/settings/privacy';
  static const cliAccess = '/settings/cli';
  static const support = '/settings/support';

  static const mainTabRoutes = {
    home,
    dailyScore,
    weeklyOverview,
    routines,
    more,
  };
}
