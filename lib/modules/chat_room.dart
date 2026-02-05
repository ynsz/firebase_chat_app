class ChatRoom {
  final String id;
  final List<String> participantIds;
  final Map<String, int> unreadCounts;
  final DateTime createdAt;
  final DateTime updatedAt;
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
