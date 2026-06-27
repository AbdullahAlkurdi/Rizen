import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/reward_item_model.dart';

class RewardStoreRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  RewardStoreRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  String get _uid {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');
    return user.uid;
  }

  Future<List<RewardItem>> getAvailableRewards() async {
    final snapshot = await _firestore.collection('rewards').get();
    final uid = _uid;

    final rewards = snapshot.docs.map((doc) {
      final data = doc.data();
      return RewardItem(
        id: doc.id,
        name: data['name'] as String? ?? '',
        description: data['description'] as String? ?? '',
        cost: (data['cost'] as int?) ?? 0,
        icon: data['icon'] as String? ?? '🎁',
        unlocked: data['unlockedBy']?.contains(uid) ?? false,
      );
    }).toList();

    return rewards;
  }

  Future<void> unlockReward(String rewardId) async {
    final uid = _uid;
    final docRef = _firestore.collection('rewards').doc(rewardId);

    await docRef.update({
      'unlockedBy': FieldValue.arrayUnion([uid]),
    });
  }

  Future<int> getUserPoints() async {
    final uid = _uid;
    final userDoc = await _firestore.collection('users').doc(uid).get();
    if (!userDoc.exists) return 0;

    final data = userDoc.data()!;
    return (data['rewardPoints'] as int?) ?? 0;
  }
}
