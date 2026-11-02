import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String title;
  final bool isDone;
  final DateTime? timestamp;
  Task({
    required this.id,
    required this.title,
    required this.isDone,
    this.timestamp,
  });

  factory Task.fromDoc(String id, Map<String, dynamic> data) {
    return Task(
      id: id,
      title: data['title'] ?? '',
      isDone: data['isDone'] ?? false,
      // timestamp bisa null sesaat setelah data ditambahkan
      timestamp: (data['timestamp'] as Timestamp?)?.toDate(),
    );
  }
}
