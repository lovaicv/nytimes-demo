import 'package:get/get.dart';
import 'package:nytimes/controllers/connection_controller.dart';
import 'package:nytimes/controllers/location_controller.dart';

class BottomBarController extends GetxController {
  BottomBarController({
    required this.locationController,
    required this.connectionController,
  });

  final ConnectionController connectionController;
  final LocationController locationController;

  @override
  void onInit() {
    // locationController.determinePosition();
    // connectionController.getConnection();
    // getBottomMessage();
    super.onInit();
  }

// getBottomMessage() async {
//   if (connectionController.isOffline.value) {
//     bottomMessage.value = AppString.offline.tr;
//   } else if (!locationController.isGpsEnabled.value) {
//     bottomMessage.value = GetPlatform.isAndroid ? 'Click here to enable GPS' : 'Please enable GPS';
//   } else if (!locationController.isLocationPermitted.value) {
//     bottomMessage.value = 'Click here to enable location permission';
//   } else {
//     bottomMessage.value =
//         '${locationController.latitude.value.toStringAsFixed(3)}, ${locationController.longitude.value.toStringAsFixed(3)}';
//   }
// }
}
