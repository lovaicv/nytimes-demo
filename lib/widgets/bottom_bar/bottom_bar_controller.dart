import 'package:get/get.dart';
import 'package:nytimes/controllers/connection_controller.dart';
import 'package:nytimes/controllers/location_controller.dart';

/// The controller for the `BottomBar` widget.
class BottomBarController extends GetxController {
  BottomBarController({
    required this.locationController,
    required this.connectionController,
  });

  final ConnectionController connectionController;
  final LocationController locationController;
}
