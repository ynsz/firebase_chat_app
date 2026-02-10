import 'package:firebase_chat_app/repositories/chat_room_repository.dart';
import 'package:firebase_chat_app/repositories/user_repository.dart';

class UserService {
  static final instance = UserService();

  Future<void> createUser() async {
    try {
      final partners = await UserRepository.instance.fetchUsers();
      final uid = await UserRepository.instance.createUser();

      final createChatRoomFunctions = partners.map((partner) {
        return ChatRoomRepository.instance.createChatRoom(
          myUid: uid,
          partnerId: partner.id,
        );
      }).toList();

      await Future.wait(createChatRoomFunctions);
    } catch (e) {
      print('ユーザー作成に失敗しました: $e');
    }
  }
}
