import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityUtils {
  ConnectivityUtils._();

  static Future<bool> get isConnected async {
    List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    }
    return true;
  }
}
