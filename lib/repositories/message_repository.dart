import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_app/modules/message.dart';

class MessageRepository {
  static final instance = MessageRepository();

  CollectionReference _messageCol(String roomId) => FirebaseFirestore.instance
      .collection('chatRooms')
      .doc(roomId)
      .collection('messages');

  Stream<List<Message>> messageSnapshot(String roomId) {
    return _messageCol(roomId)
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) {
                final data = doc.data() as Map<String, dynamic>?;
                if (data == null) {
                  return null;
                }
                final createdAt = (data['createdAt'] as Timestamp?) ?? Timestamp.now();
                final updatedAt = (data['updatedAt'] as Timestamp?) ?? Timestamp.now();
                return Message(
                  id: doc.id,
                  text: data['text'],
                  senderId: data['senderId'],
                  createdAt: createdAt,
                  updatedAt: updatedAt,
                );
              })
              .whereType<Message>()
              .toList(),
        );
  }

  Future<void> createMessage({
    required String roomId,
    required String message,
    required String senderId,
  }) async {
    try {
      await _messageCol(roomId).add({
        'text': message,
        'senderId': senderId,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('メッセージ作成時にエラーが発生: $e');
    }
  }
}
