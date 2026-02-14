import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_app/modules/chat_room.dart';

class ChatRoomRepository {
  static final instance = ChatRoomRepository();
  final _firestore = FirebaseFirestore.instance;
  late final _chatRoomCol = _firestore.collection('chatRooms');

  Stream<List<ChatRoom>> joinedChatRoomSnapshot(String uid) {
    return _chatRoomCol
        .where('participantIds', arrayContains: uid)
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
          snapshot.docs.map((doc) {
            final data = doc.data();
            final participantIds = (data['participantIds'] as List).cast<
                String>();
            final unreadCounts = (data['unreadCounts'] as Map<String, dynamic>)
                .cast<String, int>();
            return ChatRoom(
                id: doc.id,
                participantIds: participantIds,
                unreadCounts: unreadCounts,
                createdAt: data['createdAt'],
                updatedAt: data['updatedAt'],
                lastMessage: data['lastMessage']
            );
          }).toList(),
    );
  }

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

  Future<List<ChatRoom>> fetchChatRooms(String uid) async {
    try {
      final snapshot = await _chatRoomCol
          .where('participantIds', arrayContains: uid)
          .orderBy('updatedAt', descending: true)
          .get();
      final docs = snapshot.docs;
      final chatRooms = docs.map((doc) {
        final data = doc.data();
        final participantIds = (data['participantIds'] as List).cast<String>();
        final unreadCounts = (data['unreadCounts'] as Map<String, dynamic>)
            .cast<String, int>();
        return ChatRoom(
          id: doc.id,
          participantIds: participantIds,
          unreadCounts: unreadCounts,
          lastMessage: data['lastMessage'],
          createdAt: data['createdAt'],
          updatedAt: data['updatedAt'],
        );
      });

      print(chatRooms.length);
      return chatRooms.toList();
    } catch (e) {
      print('参加しているチャットルームの情報取得失敗 $e');
      return [];
    }
  }

  Future<void> updateRoom({
    required String roomId,
    required String lastMessage,
  }) async {
    await _chatRoomCol.doc(roomId).update({
      'lastMessage': lastMessage,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
