import 'package:flutter/material.dart';

import '../entities/note_category.dart';

class ReflectionPromptsService {
  static const _weekdayPrompts = {
    1: "What went well today?",
    2: "What challenged you?",
    3: "What did you learn?",
    4: "What are you grateful for?",
    5: "What drained your energy?",
    6: "What energized you?",
    7: "What will you focus on next week?",
  };

  static const _categoryPrompts = {
    NoteCategory.reflection: [
      "Describe your day in three sentences.",
      "What emotions were most present today?",
      "How did you show up for yourself today?",
    ],
    NoteCategory.gratitude: [
      "List three things you're grateful for right now.",
      "Who made a positive impact on you today?",
      "What simple pleasure brought you joy today?",
    ],
    NoteCategory.brainDump: [
      "Write down everything on your mind.",
      "What thoughts keep circling?",
      "What do you need to unload?",
    ],
    NoteCategory.insight: [
      "What pattern did you notice today?",
      "What wisdom emerged from your experience?",
      "How did you grow today?",
    ],
    NoteCategory.custom: [
      "What's on your mind?",
      "Share your thoughts freely.",
      "What do you want to capture?",
    ],
  };

  String getDailyPrompt() {
    final weekday = DateTime.now().weekday;
    return _weekdayPrompts[weekday] ?? "What went well today?";
  }

  List<String> getCategoryPrompts(NoteCategory category) {
    return _categoryPrompts[category] ?? _categoryPrompts[NoteCategory.custom]!;
  }

  Color categoryColor(NoteCategory category) {
    switch (category) {
      case NoteCategory.reflection:
        return const Color(0xFF4CAF50);
      case NoteCategory.gratitude:
        return const Color(0xFFFFB300);
      case NoteCategory.brainDump:
        return const Color(0xFF42A5F5);
      case NoteCategory.insight:
        return const Color(0xFFAB47BC);
      case NoteCategory.custom:
        return const Color(0xFF78909C);
    }
  }
}