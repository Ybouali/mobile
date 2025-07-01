import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:diary_app/features/controllers/entry_controller.dart';
import 'package:diary_app/features/models/user_model.dart';
import 'package:diary_app/navigation/bottom_nav_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  final EntryController _entryController = Get.put(EntryController());

  Future<void> login() async {
    try {
      if (_entryController.user.value != null &&
          _entryController.user.value!.email.isNotEmpty &&
          _entryController.user.value!.checkExp()) {
        await _entryController.getAllEntrybyEmail();
        Get.offAll(() => BottomNavMenu());
        Get.snackbar(
          'Login Required',
          'You need to login to continue',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      _entryController.user.value = UserModel.empty();

      final (domain, clientId) = getAuth0();
      final auth0 = Auth0(domain, clientId);
      final credentials = await auth0.webAuthentication().login();

      // final String provider = credentials.user.sub.split("|")[0];
      // print('provider');
      // print(provider);
      // print(credentials.user.email);
      // print('provider');

      if (credentials.user.email == null) {
        throw Exception('User not logged in');
      }

      final storage = FlutterSecureStorage();

      await storage.deleteAll();
      _entryController.user.value = UserModel.empty();

      if (credentials.user.email!.isEmpty) {
        _entryController.user.value = UserModel.empty();
        Get.snackbar(
          'Login Required',
          'You need to login to continue',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      _entryController.user.value = UserModel(
        email: credentials.user.email!,
        name: credentials.user.name!,
        expiresAt: credentials.expiresAt,
      );

      // Store the user in secure_storage

      await storage.write(key: "email", value: credentials.user.email!);
      await storage.write(key: "name", value: credentials.user.name!);
      await storage.write(
        key: "expiresAt",
        value: credentials.expiresAt.toString(),
      );
      Get.snackbar(
        'User Logged in',
        'Welcome Back ${credentials.user.name} :)',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.shade200,
        colorText: Colors.black87,
      );
      await _entryController.getAllEntrybyEmail();
    } catch (e) {
      Get.snackbar(
        'There is a problem',
        'Please Try agin :)',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
      debugPrint(e.toString());
    }
  }

  (String, String) getAuth0() {
    final String domain = dotenv.get('DOMAIN_AUTH0');
    final String clientId = dotenv.get('CLIENT_ID_AUTH0');
    return (domain, clientId);
  }

  Future<bool> logoutAuth() async {
    final (domain, clientId) = getAuth0();

    final auth0 = Auth0(domain, clientId);
    try {
      await auth0.webAuthentication().logout();

      final storage = FlutterSecureStorage();
      await storage.deleteAll();
      _entryController.user.value = UserModel.empty();
      Get.snackbar(
        'User Logout',
        'See you next time',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.greenAccent,
        colorText: Colors.red,
      );
      return true;
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar(
        'User can not logout',
        'See you next time',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }
}
