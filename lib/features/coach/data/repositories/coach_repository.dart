import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/constants/app_config.dart';
import '../../../../core/interfaces/habit_service_interface.dart';
import '../../../../core/interfaces/finance_service_interface.dart';
import '../../../../core/interfaces/note_service_interface.dart';
import '../../../../core/interfaces/domain_service_interface.dart';
import '../../../../core/interfaces/islamic_service_interface.dart';
import '../models/coach_message_model.dart';

class CoachRepository {
  CoachRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
    Dio? dio,
    required HabitServiceInterface habitsRepository,
    required FinanceServiceInterface financeRepository,
    required NoteServiceInterface notesRepository,
    required DomainServiceInterface domainLogsRepository,
    required IslamicServiceInterface prayerTimesRepository,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance,
        _dio = dio ?? Dio(),
        _habitsRepository = habitsRepository,
        _financeRepository = financeRepository,
        _notesRepository = notesRepository,
        _domainLogsRepository = domainLogsRepository,
        _prayerTimesRepository = prayerTimesRepository;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final Dio _dio;
  final HabitServiceInterface _habitsRepository;
  final FinanceServiceInterface _financeRepository;
  final NoteServiceInterface _notesRepository;
  final DomainServiceInterface _domainLogsRepository;
  final IslamicServiceInterface _prayerTimesRepository;

  CollectionReference get _sessionsCollection =>
      _firestore.collection('coach_sessions');

  String get userId {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');
    return user.uid;
  }

  String get _uid {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');
    return user.uid;
  }

  Future<String> _getOrCreateSessionId() async {
    final uid = _uid;
    final snapshot = await _sessionsCollection
        .where('uid', isEqualTo: uid)
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();
    if (snapshot.docs.isNotEmpty) {
      final data = snapshot.docs.first.data()! as Map<String, dynamic>;
      final sessionId = data['sessionId'] as String?;
      if (sessionId != null && sessionId.isNotEmpty) {
        return sessionId;
      }
    }
    return 'session_${uid}_${DateTime.now().millisecondsSinceEpoch}';
  }

  Future<String> buildWeeklyContext() async {
    final now = DateTime.now();
    final weekAgo = now.subtract(const Duration(days: 7));

    final habits = await _habitsRepository.getAllHabits();
    final activeHabits = habits.where((h) => h.isActive).toList();
    final positiveCount =
        activeHabits.where((h) => h.type == HabitType.positive).length;
    final shadowCount =
        activeHabits.where((h) => h.type == HabitType.shadow).length;

    final habitMap = {for (final h in habits) h.id: h};
    final allLogs = await _habitsRepository.getAllHabitLogs();
    final weekLogs =
        allLogs.where((l) => l.completedAt.isAfter(weekAgo)).toList();
    final positiveLogs = weekLogs.where((l) {
      final habit = habitMap[l.habitId];
      return habit != null && habit.type == HabitType.positive;
    }).toList();

    String financeSummary = 'No finance data';
    try {
      final transactions = await _financeRepository.getTransactions();
      final recentTx =
          transactions.where((t) => t.loggedAt.isAfter(weekAgo)).toList();
      final spent = recentTx
          .where((t) => t.type == TransactionType.expense)
          .fold<double>(0, (total, t) => total + t.amount);
      final income = recentTx
          .where((t) => t.type == TransactionType.income)
          .fold<double>(0, (total, t) => total + t.amount);
      financeSummary =
          'Spent: $spent, Income: $income, Transactions: ${recentTx.length}';
    } catch (e) {
      financeSummary = 'Finance data unavailable';
    }

    String notesSummary = 'No recent notes';
    try {
      final notes = await _notesRepository.getAllNotes();
      final recentNotes =
          notes.where((n) => n.loggedAt.isAfter(weekAgo)).toList();
      notesSummary = '${recentNotes.length} notes created this week';
    } catch (e) {
      notesSummary = 'Notes data unavailable';
    }

    String domainSummary = 'No domain logs';
    try {
      final allDomainLogs = <DomainLog>[];
      for (final domainId
          in ['coding', 'study', 'sports', 'spiritual', 'projects']) {
        try {
          final logs = await _domainLogsRepository.getLogsByDomain(domainId);
          allDomainLogs.addAll(logs);
        } catch (_) {}
      }
      final weekDomainLogs =
          allDomainLogs.where((l) => l.loggedAt.isAfter(weekAgo)).toList();
      final totalMinutes = weekDomainLogs.fold<int>(
        0,
        (total, l) => total + l.duration,
      );
      domainSummary =
          '$totalMinutes minutes across ${weekDomainLogs.length} sessions';
    } catch (e) {
      domainSummary = 'Domain data unavailable';
    }

    String prayerSummary = 'Prayer data unavailable';
    try {
      final cache = await _prayerTimesRepository.getTodayPrayerTimes(
        lat: 21.4225,
        lng: 39.8262,
      );
      prayerSummary = 'Prayer times available for today (${cache.validForDate})';
    } catch (e) {
      prayerSummary = 'Prayer data unavailable';
    }

    return '''
Weekly Context (last 7 days):
- Active habits: $activeHabits.length ($positiveCount positive, $shadowCount shadow)
- Habit completions: $positiveLogs.length positive logs this week
- Finance: $financeSummary
- Notes: $notesSummary
- Domains: $domainSummary
- Prayer: $prayerSummary
''';
  }

  Future<CoachMessage> sendMessage(String message) async {
    final sessionId = await _getOrCreateSessionId();
    final now = DateTime.now();
    final uid = _uid;

    final userMessage = CoachMessage(
      id: '${now.millisecondsSinceEpoch}_user',
      uid: uid,
      content: message,
      role: CoachRole.user,
      timestamp: now,
      sessionId: sessionId,
    );

    await _sessionsCollection.doc(userMessage.id).set({
      ...userMessage.toFirestore(),
      'createdAt': FieldValue.serverTimestamp(),
    });

    final context = await buildWeeklyContext();

    final fullPrompt = '''You are a life coach assistant called Rizen Coach. You have access to the user's weekly data below. Use it to personalize your responses. If the user asks you to take an action, respond with a JSON action block and a natural language message.

Weekly Context:
$context

User message: $message

Respond in one of two formats:
1. For normal conversation: just reply naturally.
2. If you want to trigger an action, include a JSON block at the end like:
{"action": "add_note", "data": {"title": "...", "body": "...", "tags": []}}
{"action": "log_habit", "data": {"habitId": "id", "note": "optional"}}
{"action": "add_transaction", "data": {"amount": 100, "description": "...", "type": "expense"|"income", "category": "optional"}}
{"action": "add_domain_log", "data": {"domainId": "coding", "duration": 60, "notes": "optional"}}

Always end with a conversational message to the user.''';

    final responseText = await _callGemini([
      {'role': 'user', 'parts': [{'text': fullPrompt}]}
    ]);

    String conversationalText = responseText;

    final jsonMatch = RegExp(r'\{[\s\S]*"action"[\s\S]*\}').firstMatch(
      responseText,
    );
    if (jsonMatch != null) {
      try {
        final jsonStr = jsonMatch.group(0)!;
        final json = jsonDecode(jsonStr) as Map<String, dynamic>;
        final action = json['action'] as String?;
        final data = json['data'] as Map<String, dynamic>? ?? {};

        if (action != null) {
          final actionResult = await _executeAction(action, data);
          conversationalText = responseText.replaceFirst(jsonStr, '').trim();
          if (conversationalText.isEmpty) {
            conversationalText = actionResult ?? 'Action completed.';
          }
        }
      } catch (e) {
        conversationalText = responseText;
      }
    }

    final assistantMessage = CoachMessage(
      id: '${DateTime.now().millisecondsSinceEpoch}_assistant',
      uid: uid,
      content: conversationalText,
      role: CoachRole.assistant,
      timestamp: DateTime.now(),
      sessionId: sessionId,
    );

    await _sessionsCollection.doc(assistantMessage.id).set({
      ...assistantMessage.toFirestore(),
      'createdAt': FieldValue.serverTimestamp(),
    });

    return assistantMessage;
  }

  Future<String?> _executeAction(
    String action,
    Map<String, dynamic> data,
  ) async {
    try {
      switch (action) {
        case 'add_note':
          final title = data['title'] as String? ?? 'Note from Coach';
          final body = data['body'] as String? ?? '';
          final tags = (data['tags'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
              const [];
          await _notesRepository.createNote(Note(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            uid: '',
            title: title,
            content: body,
            tags: tags,
            mood: 'neutral',
            loggedAt: DateTime.now(),
          ));
          return 'Note created: $title';

        case 'log_habit':
          final habitId = data['habitId'] as String?;
          final note = data['note'] as String?;
          if (habitId == null) return 'Missing habitId for habit log';
          await _habitsRepository.createHabitLog(habitId: habitId, note: note);
          return 'Habit logged successfully';

        case 'add_transaction':
          final amount = (data['amount'] as num?)?.toDouble();
          final description = data['description'] as String? ?? 'Transaction';
          final typeStr = data['type'] as String? ?? 'expense';
          final category = data['category'] as String?;
          if (amount == null) return 'Missing amount for transaction';
          final type = typeStr == 'income'
              ? TransactionType.income
              : TransactionType.expense;
          await _financeRepository.addTransaction(
            amount: amount,
            description: description,
            type: type,
            category: category,
          );
          return 'Transaction added: $description ($typeStr $amount)';

        case 'add_domain_log':
          final domainId = data['domainId'] as String?;
          final duration = (data['duration'] as num?)?.toInt();
          final notes = data['notes'] as String?;
          if (domainId == null || duration == null) {
            return 'Missing domainId or duration';
          }
          await _domainLogsRepository.addLog(
            domainId: domainId,
            duration: duration,
            notes: notes,
          );
          return 'Domain log added: $domainId for $duration minutes';

        default:
          return null;
      }
    } catch (e) {
      return 'Action failed: $e';
    }
  }

  Future<List<CoachMessage>> getChatHistory(String userId) async {
    final snapshot = await _sessionsCollection
        .where('uid', isEqualTo: userId)
        .orderBy('timestamp', descending: false)
        .get();

    return snapshot.docs.map(CoachMessage.fromFirestore).toList();
  }

  Future<void> saveMessage(CoachMessage message) async {
    await _sessionsCollection.doc(message.id).set({
      ...message.toFirestore(),
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<String> getWeeklySynthesis() async {
    final uid = _uid;
    final now = DateTime.now();
    final weekAgo = now.subtract(const Duration(days: 7));

    final weekSnapshot = await _sessionsCollection
        .where('uid', isEqualTo: uid)
        .where('timestamp', isGreaterThanOrEqualTo: weekAgo)
        .orderBy('timestamp', descending: true)
        .get();

    final weekMessages = weekSnapshot.docs
        .map(CoachMessage.fromFirestore)
        .toList();

    final summary =
        'User had ${weekMessages.length} coach interactions this week. '
        'Top themes: habit consistency, sleep discipline, domain balance.';

    final responseText = await _callGemini([
      {
        'role': 'user',
        'parts': [
          {
            'text':
                'You are a life coach. Provide a concise weekly synthesis report based on this data: $summary. '
                'Focus on: 1) Key wins, 2) Patterns, 3) One actionable focus for next week. '
                'Keep it under 200 words.',
          }
        ],
      }
    ]);

    return responseText;
  }

  Future<String> _callGemini(List<Map<String, dynamic>> contents) async {
    final key = AppConfig.geminiApiKey;
    if (key.trim().isEmpty) {
      throw Exception('Gemini API key is not configured');
    }

    final response = await _dio
        .post<Map<String, dynamic>>(
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent',
          queryParameters: {'key': key},
          data: {
            'contents': contents,
            'generationConfig': {
              'responseMimeType': 'text/plain',
              'temperature': 0.7,
            },
          },
          options: Options(
            sendTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        )
        .timeout(const Duration(seconds: 10));

    final candidates = response.data?['candidates'] as List<dynamic>?;
    if (candidates == null || candidates.isEmpty) {
      throw Exception('Gemini returned no candidates');
    }

    final content = (candidates.first as Map<String, dynamic>)['content']
        as Map<String, dynamic>?;
    final parts = content?['parts'] as List<dynamic>?;
    if (parts == null || parts.isEmpty) {
      throw Exception('Gemini returned no parts');
    }

    final text = (parts.first as Map<String, dynamic>)['text'] as String?;
    if (text == null || text.trim().isEmpty) {
      throw Exception('Gemini returned empty text');
    }

    return text.trim();
  }
}
