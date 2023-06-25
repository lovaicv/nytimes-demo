import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

/// The `ConnectionController` class is a GetX controller for managing network connectivity status.
class ConnectionController extends GetxController {
  StreamSubscription<ConnectivityResult>? streamSubscription;
  RxBool isOffline = false.obs;
  Connectivity connectivity = Connectivity();

  @override
  void onInit() {
    startStream();
    super.onInit();
  }

  @override
  onClose() {
    streamSubscription?.cancel();
  }

  /// Returns a Future indicating whether the device has an active network connection.
  Future<bool> getConnection() async {
    return checkConnection(await connectivity.checkConnectivity());
  }

  /// Starts listening to network connectivity changes.
  startStream() {
    streamSubscription = connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      checkConnection(result);
    });
  }

  /// Checks the network connectivity result and updates the isOffline value accordingly.
  bool checkConnection(ConnectivityResult result) {
    if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
      isOffline.value = false;
      return false;
    } else if (result == ConnectivityResult.none) {
      isOffline.value = true;
      return true;
    }
    return false;
  }
}
