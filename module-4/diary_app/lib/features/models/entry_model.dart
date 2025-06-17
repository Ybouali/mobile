import 'package:cloud_firestore/cloud_firestore.dart';

enum Feeling { happy, sad, angry, anxious, excited, tired, neutral, grateful }

class EntryModel {
  final String? id;
  final String? userEmail;
  final DateTime? date;
  final String title;
  final String content;
  final Feeling feeling;

  EntryModel({
    this.id,
    this.userEmail,
    this.date,
    required this.title,
    required this.content,
    required this.feeling,
  });

  factory EntryModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data();

    if (data == null) throw Exception("No DATA");

    final map = data as Map<String, dynamic>;

    return EntryModel(
      id: doc.id,
      title: map['title'] ?? "",
      content: map['content'] ?? "",
      feeling: Feeling.values[map['feeling'] ?? 0],
      date: map['created_at'].toDate() ?? DateTime.now(),
      userEmail: map["userEmail"] ?? "",
    );
  }
}
