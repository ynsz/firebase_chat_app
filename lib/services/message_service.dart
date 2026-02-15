import 'package:firebase_chat_app/repositories/chat_room_repository.dart';
import 'package:firebase_chat_app/repositories/message_repository.dart';

class MessageService {
  static final instance = MessageService();

  Future<void> sendMessage({
    required String roomId,
    required String message,
    required String senderId,
    required String partnerId,
  }) async {
    await MessageRepository.instance.createMessage(
      roomId: roomId,
      message: message,
      senderId: senderId,
    );
    await ChatRoomRepository.instance.updateRoom(
      roomId: roomId,
      lastMessage: message,
      partnerId: partnerId,
    );
  }
}
