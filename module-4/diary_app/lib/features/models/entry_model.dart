enum Feeling { happy, sad, angry, anxious, excited, tired, neutral, grateful }

class EntryModel {
  final String userEmail;
  final DateTime date;
  final String title;
  final String content;
  final Feeling feeling;

  EntryModel({
    required this.userEmail,
    required this.date,
    required this.title,
    required this.content,
    required this.feeling,
  });
}
