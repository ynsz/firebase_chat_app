import 'package:cloud_firestore/cloud_firestore.dart';

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
    } catch(e) {
      print('エラーが発生: $e');
    }
  }
}
