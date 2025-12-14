import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../contracts/contracts.dart';
import '../models/message.dart';

class ChatServices implements Contracts {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<Message>> getMessages() {
    return _firestore
        .collection('general_chat')
        .orderBy('timestamp', descending: true)
        .limit(50)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data();
            DateTime timestamp;

            if (data['timestamp'] != null) {
              timestamp = (data['timestamp'] as Timestamp).toDate();
            } else {
              timestamp = DateTime.now();
            }

            return Message(
              id: doc.id,
              text: data['text'] ?? '',
              senderEmail: data['senderEmail'] ?? '',
              timestamp: timestamp,
            );
          }).toList();
        });
  }

  @override
  Future<void> sendMessage(String text) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Not authenticated');

    await _firestore.collection('general_chat').add({
      'text': text,
      'senderEmail': user.email!,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
