import 'package:flutter/material.dart';

class ChatRoomTile extends StatelessWidget {
  const ChatRoomTile({
    required this.name,
    required this.imagePath,
    required this.lastMessage,
    required this.unreadCount,
    super.key,
  });

  final String name;
  final String imagePath;
  final String lastMessage;
  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        spacing: 8,
        children: [
          CircleAvatar(
            radius: 24,
            foregroundImage: imagePath.isEmpty ? null : NetworkImage(imagePath),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name),
              Text(lastMessage, style: TextStyle(color: Colors.grey)),
            ],
          ),
          if (unreadCount != 0) ...[
            Spacer(),
            Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                '$unreadCount',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
