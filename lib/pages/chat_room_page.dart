import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_app/modules/message.dart';
import 'package:firebase_chat_app/repositories/message_repository.dart';
import 'package:firebase_chat_app/services/message_service.dart';
import 'package:firebase_chat_app/services/shared_pref_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;

class ChatRoomPage extends StatelessWidget {
  const ChatRoomPage({required this.roomId, required this.userName, super.key});

  final String roomId;
  final String userName;

  @override
  Widget build(BuildContext context) {
    final myUid = SharedPrefService.instance.getUid();
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text(userName)),
      body: SafeArea(
        child: StreamBuilder(
          stream: MessageRepository.instance.messageSnapshot(roomId),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (asyncSnapshot.hasError) {
              print(asyncSnapshot.error);
              return Center(child: Text('エラーが発生しました: ${asyncSnapshot.error}'));
            }

            final messages = asyncSnapshot.data ?? [];

            return ListView.builder(
              reverse: true,
              shrinkWrap: true,
              physics: RangeMaintainingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
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
                      Text(
                        DateFormat('HH:mm').format(message.createdAt.toDate()),
                      ),
                    ],
                  ),
                );
              },
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
                controller: controller,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            IconButton(
              onPressed: () {
                MessageService.instance.sendMessage(
                  roomId: roomId,
                  message: controller.text,
                  senderId: myUid,
                );
                controller.clear();
              },
              icon: Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }
}
