import 'package:firebase_chat_app/modules/chat_room.dart';
import 'package:firebase_chat_app/modules/user.dart';
import 'package:firebase_chat_app/repositories/chat_room_repository.dart';

class ChatRoomService {
  static final instance = ChatRoomService();

  Future<(Map<String, User>, List<ChatRoom>)> fetchJoinedChatRooms(
    String uid,
  ) async {
    final chatRooms = await ChatRoomRepository.instance.fetchChatRooms(uid);
    final userIds = chatRooms
        .map((chatRoom) => chatRoom.participantIds)
        .expand((inner) => inner)
        .toSet();
  }
}
