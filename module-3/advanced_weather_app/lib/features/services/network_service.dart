import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkService {
  static final InternetConnectionChecker _connectionChecker =
      InternetConnectionChecker.createInstance(
        checkTimeout: const Duration(seconds: 5),
        checkInterval: const Duration(seconds: 5),
      );

  static Future<bool> isConnected() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult.isEmpty) {
      return false;
    }
    return await _connectionChecker.hasConnection;
  }
}
