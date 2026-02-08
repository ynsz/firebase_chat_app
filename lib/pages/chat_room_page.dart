import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_app/modules/message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;

class ChatRoomPage extends StatelessWidget {
  const ChatRoomPage({required this.userName, super.key});

  final String userName;

  @override
  Widget build(BuildContext context) {
    final messageList = [
      Message(
        id: '1',
        text: 'こんにちは',
        senderId: 'hoge',
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      ),
      Message(
        id: '2',
        text: 'どうもー！',
        senderId: 'fuga',
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      ),
      Message(
        id: '3',
        text: '元気にしてますか？',
        senderId: 'hoge',
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      ),
      Message(
        id: '4',
        text: 'こんにちはこんにちはこんにちはこんにちはこんにちはこんにちは',
        senderId: 'fuga',
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      ),
    ];
    final String myUid = 'hoge';

    return Scaffold(
      appBar: AppBar(title: Text(userName)),
      body: SafeArea(
        child: ListView.builder(
          reverse: true,
          shrinkWrap: true,
          physics: RangeMaintainingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16),
          itemCount: messageList.length,
          itemBuilder: (context, index) {
            final message = messageList[index];
            final isSendFromMe = message.senderId == myUid;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: 4,
                textDirection: isSendFromMe
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * .6,
                    ),
                    decoration: BoxDecoration(
                      color: isSendFromMe ? Colors.green : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(message.text),
                  ),
                  Text(DateFormat('HH:mm').format(message.createdAt.toDate())),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(
          16,
        ).copyWith(bottom: 16 + MediaQuery.of(context).padding.bottom),
        color: Colors.white,
        child: Row(
          children: [
            Flexible(
              child: TextField(
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.send)),
          ],
        ),
      ),
    );
  }
}
