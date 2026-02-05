class Message {
  final String id;
  final String text;
  final String senderId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Message({
    required this.id,
    required this.text,
    required this.senderId,
    required this.createdAt,
    required this.updatedAt,
  });
}