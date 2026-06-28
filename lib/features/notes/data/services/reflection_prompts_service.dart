class ReflectionPromptsService {
  static const _dailyPrompts = [
    'What went well today?',
    'What challenged you?',
    'What would you do differently?',
    'How aligned was today with your long-term values?',
    'What are you grateful for today?',
    'What did you learn today?',
    'How did you take care of yourself today?',
  ];

  static const _moodPrompts = {
    'happy': [
      'What made you happy today?',
      'How can you spread this joy to others?',
      'What are you most excited about?',
    ],
    'sad': [
      'What is weighing on you?',
      'Who can support you right now?',
      'What small step can you take to feel better?',
    ],
    'anxious': [
      'What specifically is causing anxiety?',
      'What is within your control right now?',
      'How can you ground yourself in this moment?',
    ],
    'grateful': [
      'What are you most grateful for today?',
      'Who has made a positive impact on you recently?',
      'How can you express your gratitude?',
    ],
    'motivated': [
      'What are you ready to achieve?',
      'What obstacles might you face?',
      'How will you stay focused?',
    ],
  };

  static String getDailyPrompt() {
    return _dailyPrompts[DateTime.now().day % _dailyPrompts.length];
  }

  static String getCustomPrompt(String mood) {
    final lower = mood.toLowerCase();
    final prompts = _moodPrompts[lower] ?? _moodPrompts['happy'];
    if (prompts == null || prompts.isEmpty) return '';
    return prompts[DateTime.now().second % prompts.length];
  }

  static String generateReflection(String noteContent) {
    final lower = noteContent.toLowerCase();
    if (lower.contains('work') || lower.contains('task')) {
      return 'How did your work contribute to your larger goals today?';
    }
    if (lower.contains('family') || lower.contains('friend')) {
      return 'How can you nurture these relationships this week?';
    }
    if (lower.contains('health') || lower.contains('exercise')) {
      return 'How did your body feel after today\'s activities?';
    }
    if (lower.contains('learn') || lower.contains('read')) {
      return 'What is one insight you want to remember from today?';
    }
    return 'What is the most important thing you learned about yourself today?';
  }
}
