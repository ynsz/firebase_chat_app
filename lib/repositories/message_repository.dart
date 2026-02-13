import 'package:cloud_firestore/cloud_firestore.dart';

class MessageRepository {
  static final instance = MessageRepository();

  CollectionReference _messageCol(String roomId) => FirebaseFirestore.instance
      .collection('chatRooms')
      .doc(roomId)
      .collection('messages');

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
