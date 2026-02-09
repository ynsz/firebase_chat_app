import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomRepository {
  final _firestore = FirebaseFirestore.instance;
  late final _chatRoomCol = _firestore.collection('chatRooms');

  Future<void> createChatRoom({
    required String myUid,
    required String partnerId,
  }) async {
    await _chatRoomCol.add({
      'participantIds': [myUid, partnerId],
      'unreadCounts': {myUid: 0, partnerId: 0},
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'lastMessage': '',
    });
  }
}
