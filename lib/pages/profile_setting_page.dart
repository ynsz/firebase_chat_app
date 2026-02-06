import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSettingPage extends StatefulWidget {
  const ProfileSettingPage({super.key});

  @override
  State<ProfileSettingPage> createState() => _ProfileSettingPageState();
}

class _ProfileSettingPageState extends State<ProfileSettingPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('プロフィール設定'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.save))],
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
            TextField(),
          ],
        ),
      ),
    );
  }
}
