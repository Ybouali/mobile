class UserModel {
  String email;
  String name;
  DateTime expiresAt;

  UserModel({required this.email, required this.name, required this.expiresAt});

  UserModel.empty() : email = "", name = "", expiresAt = DateTime(0);

  bool checkExp() {
    final DateTime timestamp = DateTime.now();

    if (email.isEmpty ||
        name.isEmpty ||
        expiresAt == DateTime(0) ||
        timestamp.isAfter(expiresAt)) {
      return false;
    }

    return true;
  }
}
