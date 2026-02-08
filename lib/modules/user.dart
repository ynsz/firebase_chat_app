import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String imagePath;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  const User({
    required this.id,
    required this.name,
    this.imagePath = '',
    required this.createdAt,
    required this.updatedAt,
  });
}
