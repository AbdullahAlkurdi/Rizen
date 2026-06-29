import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class RizenTutorial {
  static const colorShadow = Color(0xFF000000);
  static const opacityShadow = 0.85;

  static TextStyle get _titleStyle => const TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
  );

  static TextStyle get _bodyStyle => const TextStyle(
    color: Color(0xFFD1D5DB),
    fontSize: 14,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
  );

  static List<TargetFocus> dailyScore(Map<String, GlobalKey> keys) {
    return [
      TargetFocus(
        identify: keys['score']!,
        keyTarget: keys['score']!,
        shape: ShapeLightFocus.Circle,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: _content(
              title: 'Your Score',
              body: 'This is your daily discipline score. Watch it grow as you complete habits and routines.',
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: keys['breakdown']!,
        keyTarget: keys['breakdown']!,
        shape: ShapeLightFocus.RRect,
        radius: 12,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: _content(
              title: 'Score Breakdown',
              body: 'See exactly which life areas are helping or hurting your score today.',
            ),
          ),
        ],
      ),
    ];
  }

  static List<TargetFocus> homeDashboard(Map<String, GlobalKey> keys) {
    return [
      TargetFocus(
        identify: keys['timeblock']!,
        keyTarget: keys['timeblock']!,
        shape: ShapeLightFocus.RRect,
        radius: 12,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: _content(
              title: 'Your Active Block',
              body: 'This shows what you should be doing right now.',
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: keys['checklists']!,
        keyTarget: keys['checklists']!,
        shape: ShapeLightFocus.RRect,
        radius: 12,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: _content(
              title: 'Open Checklists',
              body: 'Your pending checklist items across all habits live here.',
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: keys['quickactions']!,
        keyTarget: keys['quickactions']!,
        shape: ShapeLightFocus.RRect,
        radius: 12,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: _content(
              title: 'Quick Actions',
              body: 'Log anything instantly without opening separate screens.',
            ),
          ),
        ],
      ),
    ];
  }

  static List<TargetFocus> habitDetail(Map<String, GlobalKey> keys) {
    return [
      TargetFocus(
        identify: keys['streak']!,
        keyTarget: keys['streak']!,
        shape: ShapeLightFocus.RRect,
        radius: 12,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: _content(
              title: 'Your Streak',
              body: 'Every completed day builds your streak. Missing one day is not the end.',
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: keys['checklist']!,
        keyTarget: keys['checklist']!,
        shape: ShapeLightFocus.RRect,
        radius: 12,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: _content(
              title: 'Habit Checklist',
              body: 'Break your habit into small steps. Check them off as you go.',
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: keys['manage']!,
        keyTarget: keys['manage']!,
        shape: ShapeLightFocus.RRect,
        radius: 12,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: _content(
              title: 'Manage Checklist',
              body: 'Add, reorder, or remove steps anytime your routine changes.',
            ),
          ),
        ],
      ),
    ];
  }

  static List<TargetFocus> shadowTracker(Map<String, GlobalKey> keys) {
    return [
      TargetFocus(
        identify: keys['score']!,
        keyTarget: keys['score']!,
        shape: ShapeLightFocus.RRect,
        radius: 12,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: _content(
              title: 'Shadow Score',
              body: 'This shows the cost of skipped checklist items — not to shame, but to make it visible.',
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: keys['missed']!,
        keyTarget: keys['missed']!,
        shape: ShapeLightFocus.RRect,
        radius: 12,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: _content(
              title: 'Missed Items',
              body: 'The most frequently skipped steps show here so you can decide what to adjust.',
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: keys['recovery']!,
        keyTarget: keys['recovery']!,
        shape: ShapeLightFocus.RRect,
        radius: 12,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: _content(
              title: 'Recovery Mode',
              body: 'Feeling overwhelmed? One tap reduces today\'s load to the bare minimum.',
            ),
          ),
        ],
      ),
    ];
  }

  static List<TargetFocus> rewardStore(Map<String, GlobalKey> keys) {
    return [
      TargetFocus(
        identify: keys['points']!,
        keyTarget: keys['points']!,
        shape: ShapeLightFocus.RRect,
        radius: 12,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: _content(
              title: 'Discipline Points',
              body: 'You earn points by completing your daily score. They unlock your locked rewards.',
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: keys['rewards']!,
        keyTarget: keys['rewards']!,
        shape: ShapeLightFocus.RRect,
        radius: 12,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: _content(
              title: 'Your Rewards',
              body: 'Add anything you enjoy and lock it behind your discipline. You decide the price.',
            ),
          ),
        ],
      ),
    ];
  }

  static List<TargetFocus> routineDetail(Map<String, GlobalKey> keys) {
    return [
      TargetFocus(
        identify: keys['blocks']!,
        keyTarget: keys['blocks']!,
        shape: ShapeLightFocus.RRect,
        radius: 12,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: _content(
              title: 'Time Blocks',
              body: 'Each block is a focused task anchored to your day\'s schedule.',
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: keys['checklist']!,
        keyTarget: keys['checklist']!,
        shape: ShapeLightFocus.RRect,
        radius: 12,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: _content(
              title: 'Block Checklist',
              body: 'Some blocks have checklists. Complete them to mark the block as done.',
            ),
          ),
        ],
      ),
    ];
  }

  static List<TargetFocus> domainSummary(Map<String, GlobalKey> keys) {
    return [
      TargetFocus(
        identify: keys['chart']!,
        keyTarget: keys['chart']!,
        shape: ShapeLightFocus.RRect,
        radius: 12,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: _content(
              title: 'Domain Progress',
              body: 'This tracks how consistently you show up in this life area.',
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: keys['log']!,
        keyTarget: keys['log']!,
        shape: ShapeLightFocus.RRect,
        radius: 12,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: _content(
              title: 'Log a Session',
              body: 'Tap to record what you did today in this domain.',
            ),
          ),
        ],
      ),
    ];
  }

  static List<TargetFocus> coachBriefing(Map<String, GlobalKey> keys) {
    return [
      TargetFocus(
        identify: keys['morning']!,
        keyTarget: keys['morning']!,
        shape: ShapeLightFocus.RRect,
        radius: 12,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: _content(
              title: 'Your Daily Briefing',
              body: 'Your AI coach reviews your plan and highlights what matters most today.',
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: keys['checklist_intel']!,
        keyTarget: keys['checklist_intel']!,
        shape: ShapeLightFocus.RRect,
        radius: 12,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: _content(
              title: 'Checklist Intelligence',
              body: 'See which habits are on track and which need a small adjustment.',
            ),
          ),
        ],
      ),
    ];
  }

  static List<TargetFocus> todoEditor(Map<String, GlobalKey> keys) {
    return [
      TargetFocus(
        identify: keys['items']!,
        keyTarget: keys['items']!,
        shape: ShapeLightFocus.RRect,
        radius: 12,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: _content(
              title: 'Checklist Items',
              body: 'Add the small steps that make up this habit. You can reorder them anytime.',
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: keys['threshold']!,
        keyTarget: keys['threshold']!,
        shape: ShapeLightFocus.RRect,
        radius: 12,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: _content(
              title: 'Completion Threshold',
              body: 'Set how many steps count as \'done\'. 70% is the default.',
            ),
          ),
        ],
      ),
    ];
  }

  static List<TargetFocus> notesHub(Map<String, GlobalKey> keys) {
    return [
      TargetFocus(
        identify: keys['grid']!,
        keyTarget: keys['grid']!,
        shape: ShapeLightFocus.RRect,
        radius: 12,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: _content(
              title: 'Your Notes',
              body: 'Capture thoughts, reflections, or anything on your mind.',
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: keys['create']!,
        keyTarget: keys['create']!,
        shape: ShapeLightFocus.RRect,
        radius: 12,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: _content(
              title: 'New Note',
              body: 'Tap to write or record a voice note. Gemini will help you organize it.',
            ),
          ),
        ],
      ),
    ];
  }

  static Widget _content({required String title, required String body}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: _titleStyle),
        const SizedBox(height: 6),
        Text(body, style: _bodyStyle),
      ],
    );
  }
}
