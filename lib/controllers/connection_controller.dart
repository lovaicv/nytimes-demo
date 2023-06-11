import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

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

  Future<bool> getConnection() async {
    return checkConnection(await connectivity.checkConnectivity());
  }

  startStream() {
    streamSubscription = connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      checkConnection(result);
    });
  }

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
