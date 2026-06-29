import 'package:shared_preferences/shared_preferences.dart';

class TutorialService {
  static const Map<String, String> keys = {
    'home':            'tutorial_home_dashboard',
    'daily_score':     'tutorial_daily_score',
    'habit_detail':    'tutorial_habit_detail',
    'habit_checkin':   'tutorial_habit_checkin',
    'shadow_tracker':  'tutorial_shadow_tracker',
    'reward_store':    'tutorial_reward_store',
    'burnout_mode':    'tutorial_burnout_mode',
    'routine_detail':  'tutorial_routine_detail',
    'domain_summary':  'tutorial_domain_summary',
    'domain_log':      'tutorial_domain_log',
    'coach_briefing':  'tutorial_coach_briefing',
    'coach_weekly':    'tutorial_coach_weekly',
    'coach_suggestions':'tutorial_coach_suggestions',
    'notes_hub':       'tutorial_notes_hub',
    'note_editor':     'tutorial_note_editor',
    'todo_editor':     'tutorial_todo_editor',
  };

  static const _prefKeySeen = 'tutorial_seen_';

  Future<bool> isSeen(String key) async {
    final sp = await SharedPreferences.getInstance();
    return sp.getBool('$_prefKeySeen$key') ?? false;
  }

  Future<void> markSeen(String key) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setBool('$_prefKeySeen$key', true);
  }

  Future<void> reset(String key) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setBool('$_prefKeySeen$key', false);
  }

  Future<void> resetAll() async {
    final sp = await SharedPreferences.getInstance();
    for (final key in keys.values) {
      await sp.setBool('$_prefKeySeen$key', false);
    }
  }
}
