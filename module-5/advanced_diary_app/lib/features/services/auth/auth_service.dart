import 'package:advanced_diary_app/features/controllers/entry_controller.dart';
import 'package:advanced_diary_app/features/models/user_model.dart';
import 'package:advanced_diary_app/navigation/bottom_nav_menu.dart';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AuthService {
  final EntryController _entryController = Get.put(EntryController());

  Future<void> login() async {
    try {
      if (_entryController.user.value != null &&
          _entryController.user.value!.checkExp()) {
        Get.to(() => BottomNavMenu());
        return;
      }

      _entryController.user.value = UserModel.empty();

      final (domain, clientId) = getAuth0();
      final auth0 = Auth0(domain, clientId);
      final credentials = await auth0.webAuthentication().login();

      _entryController.user.value = UserModel(
        email: credentials.user.email!,
        name: credentials.user.name!,
        expiresAt: credentials.expiresAt,
      );

      // Store the user in secure_storage

      final storage = FlutterSecureStorage();

      await storage.write(key: "email", value: credentials.user.email!);
      await storage.write(key: "name", value: credentials.user.name!);
      await storage.write(
        key: "expiresAt",
        value: credentials.expiresAt.toString(),
      );
    } catch (e) {
      debugPrint("FROM LOGIN");
      debugPrint(e.toString());
    }
  }

  (String, String) getAuth0() {
    final String domain = dotenv.get('DOMAIN_AUTH0');
    final String clientId = dotenv.get('CLIENT_ID_AUTH0');
    return (domain, clientId);
  }

  Future<void> logoutAuth() async {
    final (domain, clientId) = getAuth0();

    final auth0 = Auth0(domain, clientId);
    try {
      await auth0.webAuthentication().logout();
      final storage = FlutterSecureStorage();
      await storage.write(key: "email", value: "");
      await storage.write(key: "name", value: "");
      await storage.write(key: "expiresAt", value: DateTime(0).toString());
      _entryController.user.value = UserModel.empty();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
