import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../services/tutorial_service.dart';

mixin TutorialMixin<T extends StatefulWidget> on State<T> {
  TutorialService get tutorialService => GetIt.instance<TutorialService>();
  String get tutorialKey;
  List<TargetFocus> buildTargets();

  void maybeShowTutorial() async {
    final seen = await tutorialService.isSeen(tutorialKey);
    if (seen) return;
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showTutorial();
    });
  }

  void showTutorialNow() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showTutorial();
    });
  }

  void _showTutorial() {
    TutorialCoachMark(
      targets: buildTargets(),
      colorShadow: const Color(0xFF000000),
      opacityShadow: 0.85,
      textSkip: 'Skip',
      textStyleSkip: const TextStyle(
        color: Color(0xFF9CA3AF),
        fontFamily: 'Inter',
        fontSize: 14,
      ),
      paddingFocus: 12,
      focusAnimationDuration: const Duration(milliseconds: 400),
      pulseAnimationDuration: const Duration(milliseconds: 800),
      onFinish: () {
        tutorialService.markSeen(tutorialKey);
      },
      onSkip: () {
        tutorialService.markSeen(tutorialKey);
        return true;
      },
    ).show(context: context);
  }
}
