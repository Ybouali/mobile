import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkService {
  static final InternetConnectionChecker _connectionChecker =
      InternetConnectionChecker.createInstance(
        checkTimeout: const Duration(seconds: 5),
        checkInterval: const Duration(seconds: 5),
      );

  static Future<bool> isConnected() async {
    final connectivityRes = await Connectivity().checkConnectivity();

    if (connectivityRes.isEmpty ||
        connectivityRes.contains(ConnectivityResult.none)) {
      return false;
    }

    return await _connectionChecker.hasConnection;
  }

  static Stream<bool> get connectionStream {
    return Connectivity().onConnectivityChanged.asyncMap((results) async {
      if (results.isEmpty || results.contains(ConnectivityResult.none)) {
        return false;
      }
      return await _connectionChecker.hasConnection;
    });
  }
}
