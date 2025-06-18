import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:diary_app/features/controllers/entry_controller.dart';
import 'package:diary_app/features/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  final EntryController _entryController = Get.put(EntryController());

  Future<void> login() async {
    try {
      final (domain, clientId) = getAuth0();
      final auth0 = Auth0(domain, clientId);
      final credentials = await auth0.webAuthentication().login();

      _entryController.user.value = UserModel(
        email: credentials.user.email!,
        name: credentials.user.name!,
        expiresAt: credentials.expiresAt,
      );
    } catch (e) {
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
    print(domain);
    print(clientId);

    final auth0 = Auth0(domain, clientId);
    try {
      await auth0.webAuthentication().logout();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
