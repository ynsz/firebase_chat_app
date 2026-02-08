import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_app/modules/user.dart';

class UserRepository {
  static UserRepository instance = UserRepository();
  final _firestore = FirebaseFirestore.instance;
  late final _userCol = _firestore.collection('users');

  Future<void> createUser() async {
    try {
      await _userCol.add({
        'name': '',
        'imagePath': '',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      print('アカウント作成完了');
    } catch (e) {
      print('アカウント作成時にエラーが発生: $e');
    }
  }

  Future<List<User>> fetchUsers() async {
    try {
      final snapshot = await _userCol.get();
      final docs = snapshot.docs;
      final users = docs.map((doc) {
        final userId = doc.id;
        final data = doc.data();
        return User(
          id: userId,
          name: data['name'],
          imagePath: data['imagePath'],
          createdAt: data['createdAt'],
          updatedAt: data['updatedAt'],
        );
      });
      return users.toList();
    } catch (e) {
      print('ユーザー情報取得時にエラー発生: $e');
      return [];
    }
  }
}
