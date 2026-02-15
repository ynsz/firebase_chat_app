import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final _storage = FirebaseStorage.instance;

  Future<String> uploadImage({required String imagePath, required File file}) async {
    final ref = _storage.ref(imagePath);
    final storedImage = await ref.putFile(file);
    final storedUrl = await storedImage.ref.getDownloadURL();
    return storedUrl;
  }
}
