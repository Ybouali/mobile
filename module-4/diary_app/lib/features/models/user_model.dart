class UserModel {
  final String email;
  final String name;
  final DateTime expiresAt;

  UserModel({required this.email, required this.name, required this.expiresAt});

  bool checkExp() {
    final DateTime timestamp = DateTime.now();

    if (timestamp != expiresAt) {
      return false;
    }

    return true;
  }
}
