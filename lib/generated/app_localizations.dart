import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ar'),
  ];

  /// Application title shown in the app bar and system.
  ///
  /// In en, this message translates to:
   /// **'Rizen'**
  String get appTitle;

  /// Page title for the Settings screen.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Section label for appearance settings.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// Label for theme selection.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// Theme option label.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// Theme option label.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// Theme option label.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// Section label for language settings.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Label for app language selection.
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get appLanguage;

  /// Title for the language and prayer settings page.
  ///
  /// In en, this message translates to:
  /// **'Language & Prayer'**
  String get languageAndPrayer;

  /// Section title for prayer calculation settings.
  ///
  /// In en, this message translates to:
  /// **'Prayer Calculation'**
  String get prayerCalculation;

  /// Label for the location method used for prayer times.
  ///
  /// In en, this message translates to:
  /// **'Location Method'**
  String get locationMethod;

  /// Current GPS-based location display.
  ///
  /// In en, this message translates to:
  /// **'GPS-based · Riyadh, Saudi Arabia'**
  String get gpsBasedRiyadh;

  /// Button text to update location.
  ///
  /// In en, this message translates to:
  /// **'Update Location'**
  String get updateLocation;

  /// Section label for notification settings.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// Label for notification toggle.
  ///
  /// In en, this message translates to:
  /// **'Enable Notifications'**
  String get enableNotifications;

  /// Section label for currency settings.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// Label for currency selection.
  ///
  /// In en, this message translates to:
  /// **'Preferred Currency'**
  String get preferredCurrency;

  /// Label showing the current app version.
  ///
  /// In en, this message translates to:
  /// **'App Version'**
  String get appVersion;

  /// Title for the app settings page.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSettings;

  /// Title for the CLI access page.
  ///
  /// In en, this message translates to:
  /// **'CLI Access'**
  String get cliAccess;

  /// Section title for developer CLI.
  ///
  /// In en, this message translates to:
  /// **'Developer CLI'**
  String get developerCli;

  /// Description for API credentials generator.
  ///
  /// In en, this message translates to:
  /// **'Generate API credentials to build powerful automations.'**
  String get generateApiCredentials;

  /// Section title for CLI usage examples.
  ///
  /// In en, this message translates to:
  /// **'Usage Examples'**
  String get usageExamples;

  /// Button text to generate a new API token.
  ///
  /// In en, this message translates to:
  /// **'Generate New Token'**
  String get generateNewToken;

  /// Title for the edit profile page.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// Title for the profile page.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Title for the privacy and security settings page.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security'**
  String get privacyAndSecurity;

  /// Title for notification settings page.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationSettings;

  /// Title for spiritual framework settings.
  ///
  /// In en, this message translates to:
  /// **'Spiritual Framework'**
  String get spiritualFramework;

  /// Title for support and feedback page.
  ///
  /// In en, this message translates to:
  /// **'Support & Feedback'**
  String get supportAndFeedback;

  /// Page title for the login screen.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Greeting on the login screen.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// Subtitle on the login screen.
  ///
  /// In en, this message translates to:
   /// **'Continue your discipline journey with Rizen.'**
  String get continueDiscipline;

  /// Form field label for email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Form field label for password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Validation message for empty email.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterYourEmail;

  /// Validation message for invalid email format.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get enterValidEmail;

  /// Validation message for short password.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordMinLength;

  /// Link text for forgot password.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// Button label for sign in.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// Button label for Google sign-in.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// Button text for creating a new account.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get createAnAccount;

  /// Page title for the register screen.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// Form field label for full name.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// Validation message for empty name.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterYourName;

  /// Button label for account creation.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// Prompt text on register screen.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// Button text to return to sign in.
  ///
  /// In en, this message translates to:
  /// **'Back to Sign In'**
  String get backToSignIn;

  /// Page title for password reset.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// Button label for sending reset link.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get sendResetLink;

  /// Primary action button on the welcome/onboarding pages.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// Secondary action on welcome page.
  ///
  /// In en, this message translates to:
  /// **'I already have an account'**
  String get alreadyHaveAnAccount;

  /// App bar title for onboarding setup pages.
  ///
  /// In en, this message translates to:
  /// **'Setup'**
  String get setup;

  /// Button text to skip onboarding step.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @continueAction.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueAction;

  /// Section title on onboarding language page.
  ///
  /// In en, this message translates to:
  /// **'Language & Region'**
  String get languageAndRegion;

  /// Description text about Arabic support.
  ///
  /// In en, this message translates to:
   /// **'Rizen supports Arabic-first layouts with full RTL support.'**
  String get arabicFirstLayouts;

  /// Section title for region selection.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get region;

  /// Section title for spiritual layer onboarding.
  ///
  /// In en, this message translates to:
  /// **'Spiritual Layer'**
  String get spiritualLayer;

  /// Label to enable the spiritual layer.
  ///
  /// In en, this message translates to:
  /// **'Enable Spiritual Layer'**
  String get enableSpiritualLayer;

  /// Label for prayer time location setting.
  ///
  /// In en, this message translates to:
  /// **'Location for Prayer Times'**
  String get locationForPrayerTimes;

  /// Label for the daily start time setting.
  ///
  /// In en, this message translates to:
  /// **'Daily Start Time'**
  String get dailyStartTime;

  /// Label for prayer time calculation method.
  ///
  /// In en, this message translates to:
  /// **'Calculation Method'**
  String get calculationMethod;

  /// Snackbar message for enabling location access.
  ///
  /// In en, this message translates to:
  /// **'Location access enabled'**
  String get locationAccessEnabled;

  /// Section title for AI prompt onboarding.
  ///
  /// In en, this message translates to:
  /// **'The \"Aha!\" Moment'**
  String get theAhaMoment;

  /// Placeholder text for AI prompt input.
  ///
  /// In en, this message translates to:
  /// **'Describe your life, habits, and biggest struggles in a few sentences.'**
  String get describeYourLife;

  /// Section title for AI coach brief.
  ///
  /// In en, this message translates to:
  /// **'AI Coach Brief'**
  String get aiCoachBrief;

  /// AI coach intro text.
  ///
  /// In en, this message translates to:
  /// **'I hear you. Based on what you shared, here\'s your initial discipline blueprint.'**
  String get iHearYou;

  /// Button label to submit AI analysis.
  ///
  /// In en, this message translates to:
  /// **'Analyze'**
  String get analyze;

  /// Final onboarding button text.
  ///
  /// In en, this message translates to:
   /// **'Launch Rizen'**
   String get launchRizen;

  /// Title for the habits hub.
  ///
  /// In en, this message translates to:
  /// **'Habits'**
  String get habits;

  /// Section title for habit engine.
  ///
  /// In en, this message translates to:
  /// **'Habit Engine'**
  String get habitEngine;

  /// Label for positive habits section.
  ///
  /// In en, this message translates to:
  /// **'Positive Habits'**
  String get positiveHabits;

  /// Label for shadow habits section.
  ///
  /// In en, this message translates to:
  /// **'Shadow Habits'**
  String get shadowHabits;

  /// Label for shadow score feature.
  ///
  /// In en, this message translates to:
  /// **'Shadow Score'**
  String get shadowScore;

  /// Label for reward store feature.
  ///
  /// In en, this message translates to:
  /// **'Reward Store'**
  String get rewardStore;

  /// Label for habit analytics feature.
  ///
  /// In en, this message translates to:
  /// **'Habit Analytics'**
  String get habitAnalytics;

  /// Label for emergency recovery mode.
  ///
  /// In en, this message translates to:
  /// **'Emergency Recovery Mode'**
  String get emergencyRecoveryMode;

  /// Button text to add a new habit.
  ///
  /// In en, this message translates to:
  /// **'Add Habit'**
  String get addHabit;

  /// Button text for habit check-in.
  ///
  /// In en, this message translates to:
  /// **'Check In'**
  String get checkIn;

  /// Button text for logging shadow events.
  ///
  /// In en, this message translates to:
  /// **'Log Shadow Event'**
  String get logShadowEvent;

  /// Button text for creating a new reward.
  ///
  /// In en, this message translates to:
  /// **'Create Reward'**
  String get createReward;

  /// Page title for habit detail.
  ///
  /// In en, this message translates to:
  /// **'Habit Detail'**
  String get habitDetail;

  /// Page title for habit analytics.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get habitAnalyticsTitle;

  /// Button text for exporting data.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get export;

  /// Title for finance hub.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get finance;

  /// Section title for current finance cycle.
  ///
  /// In en, this message translates to:
  /// **'Current Cycle'**
  String get currentCycle;

  /// Button text to add a commitment.
  ///
  /// In en, this message translates to:
  /// **'Add Commitment'**
  String get addCommitment;

  /// Page title for editing a commitment.
  ///
  /// In en, this message translates to:
  /// **'Edit Commitment'**
  String get editCommitment;

  /// Page title for quick expense entry.
  ///
  /// In en, this message translates to:
  /// **'Quick Expense'**
  String get quickExpense;

  /// Button text for parsing expense text.
  ///
  /// In en, this message translates to:
  /// **'Parse'**
  String get parse;

  /// Button text for confirming an expense.
  ///
  /// In en, this message translates to:
  /// **'Confirm Expense'**
  String get confirmExpense;

  /// Hint text for expense input.
  ///
  /// In en, this message translates to:
  /// **'Expense text'**
  String get expenseText;

  /// Page title for manual transaction.
  ///
  /// In en, this message translates to:
  /// **'Manual Transaction'**
  String get manualTransaction;

  /// Button text for saving a transaction.
  ///
  /// In en, this message translates to:
  /// **'Save Transaction'**
  String get saveTransaction;

  /// Form field label for amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// Form field label for description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionField;

  /// Form field label for category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// Form field label for transaction type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// Button text for changing financial review time.
  ///
  /// In en, this message translates to:
  /// **'Change review time'**
  String get changeReviewTime;

  /// Title for routines hub.
  ///
  /// In en, this message translates to:
  /// **'Routines'**
  String get routines;

  /// Page title for creating a routine.
  ///
  /// In en, this message translates to:
  /// **'Create Routine'**
  String get createRoutine;

  /// Page title for editing a routine.
  ///
  /// In en, this message translates to:
  /// **'Edit Routine'**
  String get editRoutine;

  /// Button text to save routine changes.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// Page title for routine detail.
  ///
  /// In en, this message translates to:
  /// **'Routine Detail'**
  String get routineDetail;

  /// Button text to add a time block.
  ///
  /// In en, this message translates to:
  /// **'Add Time Block'**
  String get addTimeBlock;

  /// Page title for routine templates.
  ///
  /// In en, this message translates to:
  /// **'Routine Templates'**
  String get routineTemplates;

  /// Button text to apply a template.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// Page title for routine history.
  ///
  /// In en, this message translates to:
  /// **'Routine History'**
  String get routineHistory;

  /// Page title for AI routine generator.
  ///
  /// In en, this message translates to:
  /// **'AI Routine Generator'**
  String get aiRoutineGenerator;

  /// Form field label for routine name.
  ///
  /// In en, this message translates to:
  /// **'Routine Name'**
  String get routineName;

  /// Form field label for routine description.
  ///
  /// In en, this message translates to:
  /// **'Description (Optional)'**
  String get routineDescription;

  /// Placeholder text for routine description.
  ///
  /// In en, this message translates to:
  /// **'What is this routine for?'**
  String get whatIsThisRoutineFor;

  /// Form field label for time block title.
  ///
  /// In en, this message translates to:
  /// **'Block Title'**
  String get blockTitle;

  /// Form field label for time block domain.
  ///
  /// In en, this message translates to:
  /// **'Domain'**
  String get domain;

  /// Form field label for start time.
  ///
  /// In en, this message translates to:
  /// **'Start Time'**
  String get startTime;

  /// Form field label for end time.
  ///
  /// In en, this message translates to:
  /// **'End Time'**
  String get endTime;

  /// Label for time block anchor type.
  ///
  /// In en, this message translates to:
  /// **'Anchor Type'**
  String get anchorType;

  /// Form field label for optional description.
  ///
  /// In en, this message translates to:
  /// **'Description (optional)'**
  String get descriptionOptional;

  /// Title for notes hub.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// Page title for creating a note.
  ///
  /// In en, this message translates to:
  /// **'Create Note'**
  String get createNote;

  /// Page title for editing a note.
  ///
  /// In en, this message translates to:
  /// **'Edit Note'**
  String get editNote;

  /// Button text for saving a note.
  ///
  /// In en, this message translates to:
  /// **'Save Note'**
  String get saveNote;

  /// Page title for note detail.
  ///
  /// In en, this message translates to:
  /// **'Note Detail'**
  String get noteDetail;

  /// Page title for notes search.
  ///
  /// In en, this message translates to:
  /// **'Search Notes'**
  String get searchNotes;

  /// Page title for nightly reflection.
  ///
  /// In en, this message translates to:
  /// **'Nightly Reflection'**
  String get nightlyReflection;

  /// Snackbar message for saved reflection.
  ///
  /// In en, this message translates to:
  /// **'Reflection saved.'**
  String get reflectionSaved;

  /// Form field label for note title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get titleField;

  /// Form field label for note tags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tags;

  /// Hint text for note content input.
  ///
  /// In en, this message translates to:
  /// **'Start writing... Markdown supported.'**
  String get startWriting;

  /// Hint text for reflection input.
  ///
  /// In en, this message translates to:
  /// **'Your reflection...'**
  String get yourReflection;

  /// Navigation label for home tab.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Morning greeting.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get goodMorning;

  /// Evening greeting.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get goodEvening;

  /// Button text for weekly view.
  ///
  /// In en, this message translates to:
  /// **'Weekly view'**
  String get weeklyView;

  /// Focus mode button text.
  ///
  /// In en, this message translates to:
  /// **'Focus'**
  String get focus;

  /// Placeholder for empty active blocks list.
  ///
  /// In en, this message translates to:
  /// **'No active time blocks'**
  String get noActiveTimeBlocks;

  /// Section title for quick actions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// Quick action tile label.
  ///
  /// In en, this message translates to:
  /// **'Log Activity'**
  String get logActivity;

  /// Quick action tile label.
  ///
  /// In en, this message translates to:
  /// **'Check Habits'**
  String get checkHabits;

  /// Quick action tile label.
  ///
  /// In en, this message translates to:
  /// **'Burnout Mode'**
  String get burnoutMode;

  /// Quick action tile label.
  ///
  /// In en, this message translates to:
  /// **'AI Coach'**
  String get aiCoach;

  /// Section title for today's flow.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Flow'**
  String get todayFlow;

  /// Section title for evening wrap-up.
  ///
  /// In en, this message translates to:
  /// **'Evening Wrap-up'**
  String get eveningWrapUp;

  /// Placeholder for empty upcoming blocks.
  ///
  /// In en, this message translates to:
  /// **'No upcoming blocks today'**
  String get noUpcomingBlocksToday;

  /// Label for active time block card.
  ///
  /// In en, this message translates to:
  /// **'Active Time Block'**
  String get activeTimeBlock;

  /// Suffix for remaining minutes display.
  ///
  /// In en, this message translates to:
  /// **'mins remaining'**
  String get minsRemaining;

  /// Snackbar message for voice logging feature.
  ///
  /// In en, this message translates to:
  /// **'Voice logging — Gemini integration coming in Phase 4'**
  String get voiceLoggingComingSoon;

  /// Page title for daily score.
  ///
  /// In en, this message translates to:
  /// **'Daily Score'**
  String get dailyScore;

  /// Page title for weekly overview.
  ///
  /// In en, this message translates to:
  /// **'Weekly Overview'**
  String get weeklyOverview;

  /// Stat label in weekly overview.
  ///
  /// In en, this message translates to:
  /// **'Weekly Avg'**
  String get weeklyAvg;

  /// Stat label in weekly overview.
  ///
  /// In en, this message translates to:
  /// **'Best Streak'**
  String get bestStreak;

  /// Stat label in weekly overview.
  ///
  /// In en, this message translates to:
  /// **'Active Domains'**
  String get activeDomains;

  /// Stat label in weekly overview.
  ///
  /// In en, this message translates to:
  /// **'Shadow Trend'**
  String get shadowTrend;

  /// Page title for monthly calendar.
  ///
  /// In en, this message translates to:
  /// **'Monthly Calendar'**
  String get monthlyCalendar;

  /// Calendar label for completed occurrences.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// Calendar label for missed occurrences.
  ///
  /// In en, this message translates to:
  /// **'Missed'**
  String get missed;

  /// Calendar label for current day.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// Page title for sleep analytics.
  ///
  /// In en, this message translates to:
  /// **'Sleep Analytics'**
  String get sleepAnalytics;

  /// Label for sleep target.
  ///
  /// In en, this message translates to:
  /// **'Target'**
  String get target;

  /// Label for actual sleep duration.
  ///
  /// In en, this message translates to:
  /// **'Actual'**
  String get actual;

  /// Label for sleep delay.
  ///
  /// In en, this message translates to:
  /// **'Delay'**
  String get delay;

  /// Page title for notifications list.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsPage;

  /// Button text to mark all notifications as read.
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get markAllRead;

  /// Filter tab label.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// Filter tab label.
  ///
  /// In en, this message translates to:
  /// **'Important'**
  String get important;

  /// Filter tab label for AI coach notifications.
  ///
  /// In en, this message translates to:
  /// **'AI Coach'**
  String get aiCoachFilter;

  /// Filter tab label for spiritual notifications.
  ///
  /// In en, this message translates to:
  /// **'Spiritual'**
  String get spiritualFilter;

  /// Title for domains hub.
  ///
  /// In en, this message translates to:
  /// **'Domains'**
  String get domains;

  /// Page title for domains hub.
  ///
  /// In en, this message translates to:
  /// **'Domains Hub'**
  String get domainsHub;

  /// Page title for domain dashboard.
  ///
  /// In en, this message translates to:
  /// **'Domain Dashboard'**
  String get domainDashboard;

  /// Page title for domain log.
  ///
  /// In en, this message translates to:
  /// **'Domain Log'**
  String get domainLog;

  /// Button text for saving a domain log entry.
  ///
  /// In en, this message translates to:
  /// **'Save Entry'**
  String get saveEntry;

  /// Form field label for duration in minutes.
  ///
  /// In en, this message translates to:
  /// **'Duration (Minutes)'**
  String get durationMinutes;

  /// Form field label for session notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notesField;

  /// Validation message for domain log entry.
  ///
  /// In en, this message translates to:
  /// **'Please enter duration or metric value'**
  String get enterDurationOrMetric;

  /// Success message after logging a session.
  ///
  /// In en, this message translates to:
  /// **'Session logged!'**
  String get sessionLogged;

  /// Placeholder text for session notes.
  ///
  /// In en, this message translates to:
  /// **'How did the session go?'**
  String get howDidSessionGo;

  /// Navigation label for coach tab.
  ///
  /// In en, this message translates to:
  /// **'Coach'**
  String get coach;

  /// Page title for AI coach chat.
  ///
  /// In en, this message translates to:
  /// **'AI Coach Chat'**
  String get aiCoachChat;

  /// Page title for coach hub.
  ///
  /// In en, this message translates to:
  /// **'Coach Hub'**
  String get coachHub;

  /// Page title for coach briefing.
  ///
  /// In en, this message translates to:
  /// **'Briefing'**
  String get coachBriefing;

  /// Button text to regenerate briefing.
  ///
  /// In en, this message translates to:
  /// **'Regenerate'**
  String get regenerate;

  /// Page title for coach weekly insights.
  ///
  /// In en, this message translates to:
  /// **'Weekly Insights'**
  String get coachWeekly;

  /// Button text to export weekly insights as PDF.
  ///
  /// In en, this message translates to:
  /// **'Export PDF'**
  String get exportPdf;

  /// Section title for key insights.
  ///
  /// In en, this message translates to:
  /// **'Key Insights'**
  String get keyInsights;

  /// Page title for coach suggestions.
  ///
  /// In en, this message translates to:
  /// **'Suggestions'**
  String get coachSuggestions;

  /// Button text to refresh suggestions.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// Page title for coach micro goals.
  ///
  /// In en, this message translates to:
  /// **'Micro Goals'**
  String get coachMicroGoals;

  /// Button text to recalculate micro goals.
  ///
  /// In en, this message translates to:
  /// **'Recalculate'**
  String get recalculate;

  /// Page title for coach insights.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get coachInsights;

  /// Navigation label for more tab.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// Section title on more hub page.
  ///
  /// In en, this message translates to:
   /// **'Explore Rizen'**
   String get exploreRizen;

  /// Section title on support page.
  ///
  /// In en, this message translates to:
  /// **'Help & Community'**
  String get helpAndCommunity;

  /// Menu item label for FAQs.
  ///
  /// In en, this message translates to:
  /// **'FAQs & Documentation'**
  String get faqs;

  /// Menu item label for sending feedback.
  ///
  /// In en, this message translates to:
  /// **'Send Feedback'**
  String get sendFeedback;

  /// Menu item label for open source attributions.
  ///
  /// In en, this message translates to:
  /// **'Open Source Attributions'**
  String get openSourceAttributions;

  /// App version string.
  ///
  /// In en, this message translates to:
   /// **'Rizen v1.0.0'**
  String get rizenVersion;

  /// Credits text.
  ///
  /// In en, this message translates to:
  /// **'Built with Flutter ❤️'**
  String get builtWithFlutter;

  /// Header text for delete routine confirmation dialog.
  ///
  /// In en, this message translates to:
  /// **'Delete Routine'**
  String get deleteRoutine;

  /// Confirmation text for deleting a routine.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this routine?'**
  String get areYouSureDeleteRoutine;

  /// Header text for delete note confirmation dialog.
  ///
  /// In en, this message translates to:
  /// **'Delete Note'**
  String get deleteNote;

  /// Confirmation text for deleting a note.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this note?'**
  String get areYouSureDeleteNote;

  /// Dialog button text to cancel an action.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Dialog button text to confirm deletion.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Dialog button text to save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Affirmative response.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// Negative response.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// Accessibility label for loading state.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// Label for error state.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Label for failed operations.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// Page title for Islamic hub.
  ///
  /// In en, this message translates to:
  /// **'Islamic Hub'**
  String get islamicHub;

  /// Page title for Qibla compass.
  ///
  /// In en, this message translates to:
  /// **'Qibla Compass'**
  String get qibla;

  /// Page title for prayer detail.
  ///
  /// In en, this message translates to:
  /// **'Prayer Detail'**
  String get prayerDetail;

  /// Page title for prayer settings.
  ///
  /// In en, this message translates to:
  /// **'Prayer Settings'**
  String get prayerSettings;

  /// Page title for Hijri calendar.
  ///
  /// In en, this message translates to:
  /// **'Hijri Calendar'**
  String get hijriCalendar;

  /// Prayer name: Fajr.
  ///
  /// In en, this message translates to:
  /// **'Fajr'**
  String get fajr;

  /// Prayer name: Dhuhr.
  ///
  /// In en, this message translates to:
  /// **'Dhuhr'**
  String get dhuhr;

  /// Prayer name: Asr.
  ///
  /// In en, this message translates to:
  /// **'Asr'**
  String get asr;

  /// Prayer name: Maghrib.
  ///
  /// In en, this message translates to:
  /// **'Maghrib'**
  String get maghrib;

  /// Prayer name: Isha.
  ///
  /// In en, this message translates to:
  /// **'Isha'**
  String get isha;

  /// Prayer time calculation method.
  ///
  /// In en, this message translates to:
  /// **'Muslim World League'**
  String get muslimWorldLeague;

  /// Prayer time calculation method.
  ///
  /// In en, this message translates to:
  /// **'Umm Al-Qura'**
  String get ummAlQura;

  /// Prayer time calculation method.
  ///
  /// In en, this message translates to:
  /// **'Egyptian General Authority'**
  String get egyptianGeneralAuthority;

  /// Prayer time calculation method.
  ///
  /// In en, this message translates to:
  /// **'ISNA'**
  String get isna;

  /// Navigation label for analytics.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get analytics;

  /// Page title for analytics hub.
  ///
  /// In en, this message translates to:
  /// **'Analytics Hub'**
  String get analyticsHub;

  /// Page title for data export.
  ///
  /// In en, this message translates to:
  /// **'Data Export & Backup'**
  String get dataExportAndBackup;

  /// Page title for growth index.
  ///
  /// In en, this message translates to:
  /// **'Growth Index'**
  String get growthIndex;

  /// Page title for habit trends.
  ///
  /// In en, this message translates to:
  /// **'Habit Trends'**
  String get habitTrends;

  /// Page title for domain correlation.
  ///
  /// In en, this message translates to:
  /// **'Domain Correlation'**
  String get domainCorrelation;

  /// Domain option label.
  ///
  /// In en, this message translates to:
  /// **'Sports'**
  String get sports;

  /// Domain option label.
  ///
  /// In en, this message translates to:
  /// **'Study'**
  String get study;

  /// Domain option label.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get work;

  /// Domain option label.
  ///
  /// In en, this message translates to:
  /// **'Coding'**
  String get coding;

  /// Domain option label.
  ///
  /// In en, this message translates to:
  /// **'Cooking/Nutrition'**
  String get cookingNutrition;

  /// Domain option label.
  ///
  /// In en, this message translates to:
  /// **'Spiritual'**
  String get spiritual;

  /// Domain option label.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get custom;

  /// Currency code: Saudi Riyal.
  ///
  /// In en, this message translates to:
  /// **'SAR'**
  String get sar;

  /// Currency code: US Dollar.
  ///
  /// In en, this message translates to:
  /// **'USD'**
  String get usd;

  /// Currency code: Euro.
  ///
  /// In en, this message translates to:
  /// **'EUR'**
  String get eur;

  /// Currency code: UAE Dirham.
  ///
  /// In en, this message translates to:
  /// **'AED'**
  String get aed;

  /// Currency code: British Pound.
  ///
  /// In en, this message translates to:
  /// **'GBP'**
  String get gbp;

  /// Form field label for monthly income.
  ///
  /// In en, this message translates to:
  /// **'Monthly income'**
  String get monthlyIncome;

  /// Form field label for currency selection.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currencyField;

  /// Day label with number placeholder.
  ///
  /// In en, this message translates to:
  /// **'Day {day}'**
  String day(int day);

  /// Hint text for habit check-in context.
  ///
  /// In en, this message translates to:
  /// **'Optional context for this check-in'**
  String get optionalContextCheckIn;

  /// Confirmation text for applying a template.
  ///
  /// In en, this message translates to:
  /// **'Apply \"{template}\"?'**
  String confirmApplyTemplate(String template);

  /// Snackbar message for successful profile update.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully.'**
  String get profileUpdatedSuccess;

  /// Hint text for notes search.
  ///
  /// In en, this message translates to:
  /// **'Search notes by meaning or keyword...'**
  String get searchNotesPlaceholder;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
