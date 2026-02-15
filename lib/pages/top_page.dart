import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_app/modules/user.dart';
import 'package:firebase_chat_app/pages/chat_room_page.dart';
import 'package:firebase_chat_app/pages/profile_setting_page.dart';
import 'package:firebase_chat_app/pages/widgets/chat_room_tile.dart';
import 'package:firebase_chat_app/repositories/chat_room_repository.dart';
import 'package:firebase_chat_app/repositories/user_repository.dart';
import 'package:firebase_chat_app/services/shared_pref_service.dart';
import 'package:flutter/material.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key});

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  final myUid = SharedPrefService.instance.getUid();
  final userMap = <String, User>{};

  Future<void> updateUserMap(Set<String> userIds) async {
    final missingIds = userIds.difference(userMap.keys.toSet());
    if (missingIds.isEmpty) {
      return;
    }

    final fetchedUsers = await Future.wait(
      missingIds.map((uid) => UserRepository.instance.fetchUser(uid)),
    );

    for (final user in fetchedUsers) {
      if (user == null) {
        continue;
      }

      userMap[user.id] = user;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('チャット一覧'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileSettingPage(),
                ),
              );
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: ChatRoomRepository.instance.joinedChatRoomSnapshot(myUid),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (asyncSnapshot.hasError) {
            return Center(
              child: Text('チャットルーム取得中にエラーが発生しました。: ${asyncSnapshot.error}'),
            );
          }

          final chatRooms = asyncSnapshot.data ?? [];
          final userIds =
              chatRooms
                  .map((chatRoom) => chatRoom.participantIds)
                  .expand((inner) => inner)
                  .toSet()
                ..remove(myUid);

          updateUserMap(userIds);

          return ListView.builder(
            itemCount: chatRooms.length,
            itemBuilder: (context, index) {
              final chatRoom = chatRooms[index];
              final partnerUid = chatRoom.participantIds.firstWhere(
                (id) => id != myUid,
              );
              final partnerUser = userMap[partnerUid];

              if (partnerUser == null) {
                return const SizedBox();
              }

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatRoomPage(
                        roomId: chatRoom.id,
                        partnerId: partnerUid,
                        userName: partnerUser.name,
                      ),
                    ),
                  );
                },
                child: ChatRoomTile(
                  name: partnerUser.name,
                  lastMessage: chatRoom.lastMessage,
                  imagePath: partnerUser.imagePath,
                  unreadCount: chatRoom.unreadCounts[myUid] ?? 0,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
