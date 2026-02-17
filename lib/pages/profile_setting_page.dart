import 'dart:io';
import 'package:firebase_chat_app/modules/user.dart';
import 'package:firebase_chat_app/repositories/user_repository.dart';
import 'package:firebase_chat_app/services/shared_pref_service.dart';
import 'package:firebase_chat_app/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSettingPage extends StatefulWidget {
  const ProfileSettingPage({super.key});

  @override
  State<ProfileSettingPage> createState() => _ProfileSettingPageState();
}

class _ProfileSettingPageState extends State<ProfileSettingPage> {
  late final User currentUser;
  final myUid = SharedPrefService.instance.getUid();
  final nameController = TextEditingController();
  final _picker = ImagePicker();
  File? image;

  Future<void> pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return; //処理を終了
    }

    image = File(pickedImage.path);
    setState(() {});
  }

  Future<void> fetchUser() async {
    final user = await UserRepository.instance.fetchUser(myUid);
    if (user == null) {
      throw Exception('ユーザー情報がありません。');
    }
    currentUser = user;
  }

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('プロフィール設定'),
        actions: [
          IconButton(
            onPressed: () async {
              final imagePath = image == null
                  ? currentUser.imagePath
                  : await StorageService.instance.uploadImage(
                      imagePath: '$myUid.png',
                      file: image!,
                    );

              await UserRepository.instance.updateUser(
                uid: myUid,
                name: nameController.text,
                imagePath: imagePath,
              );
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  pickImage();
                },
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                    image: image == null
                        ? null
                        : DecorationImage(
                            image: FileImage(image!),
                            fit: BoxFit.cover,
                          ),
                  ),
                  child: image == null
                      ? Icon(Icons.image_outlined, color: Colors.white)
                      : null,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text('プロフィール名'),
            TextField(controller: nameController),
          ],
        ),
      ),
    );
  }
}
