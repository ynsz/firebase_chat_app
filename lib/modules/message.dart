import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String text;
  final String senderId;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  const Message({
    required this.id,
    required this.text,
    required this.senderId,
    required this.createdAt,
    required this.updatedAt,
  });
}