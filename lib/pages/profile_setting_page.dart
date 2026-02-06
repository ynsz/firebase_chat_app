import 'package:flutter/material.dart';

class ProfileSettingPage extends StatelessWidget {
  const ProfileSettingPage({super.key});

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
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.image_outlined, color: Colors.white,),
              ),
            ),
            SizedBox(height: 16,),
            Text('プロフィール名'),
            TextField(),
          ],
        ),
      ),
    );
  }
}
