import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/constants/app_config.dart';
import '../models/coach_message_model.dart';

class CoachRepository {
  CoachRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
    Dio? dio,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance,
        _dio = dio ?? Dio();

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final Dio _dio;

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

    final responseText = await _callGemini([
      {'role': 'user', 'parts': [{'text': message}]}
    ]);

    final assistantMessage = CoachMessage(
      id: '${DateTime.now().millisecondsSinceEpoch}_assistant',
      uid: uid,
      content: responseText,
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
