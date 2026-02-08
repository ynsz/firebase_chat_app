import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  final String id;
  final List<String> participantIds;
  final Map<String, int> unreadCounts;
  final Timestamp createdAt;
  final Timestamp updatedAt;
  final String lastMessage;

  const ChatRoom({
    required this.id,
    required this.participantIds,
    required this.unreadCounts,
    required this.createdAt,
    required this.updatedAt,
    this.lastMessage = '',
  });
}
