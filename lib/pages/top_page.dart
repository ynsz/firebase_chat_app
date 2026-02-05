import 'package:firebase_chat_app/modules/user.dart';
import 'package:firebase_chat_app/pages/widgets/chat_room_tile.dart';
import 'package:flutter/material.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key});

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  final user = User(
    id: 'abc123',
    name: '山田太郎',
    imagePath: 'http://example.com/image.jpg',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('チャット一覧'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ChatRoomTile(
            name: '山田太郎 $index',
            lastMessage: '今日はいい天気ですね',
            imagePath:
                'https://jp.unicharmpet.com/content/dam/sites/jp_unicharmpet_com/pet/magazine/cat/kitten/img/010029/010029_01_img.jpg',
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
