import 'package:flutter/material.dart';

class ChatRoomTile extends StatelessWidget {
  const ChatRoomTile({
    required this.name,
    required this.imagePath,
    required this.lastMessage,
    super.key,
  });

  final String name;
  final String imagePath;
  final String lastMessage;

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
        ],
      ),
    );
  }
}
