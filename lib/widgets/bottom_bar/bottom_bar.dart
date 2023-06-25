import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nytimes/core/app_string.dart';
import 'package:nytimes/widgets/bottom_bar/bottom_bar_controller.dart';

class BottomBar extends GetView<BottomBarController> {
  const BottomBar({
    Key? key,
    this.callback,
    this.left,
    required this.right,
  }) : super(key: key);

  final Function? callback;
  final double? left;
  final double? right;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!controller.connectionController.isOffline.value && callback != null) callback!();
      String bottomMessage = '';
      if (controller.connectionController.isOffline.value) {
        bottomMessage = AppString.offline.tr;
      } else if (!controller.locationController.isGpsEnabled.value) {
        bottomMessage = GetPlatform.isAndroid ? AppString.enableLocationServiceAndroid.tr : AppString.enableLocationServiceiOS.tr;
      } else if (!controller.locationController.isLocationPermitted.value) {
        bottomMessage = AppString.enableLocationPermission.tr;
      } else {
        bottomMessage =
            '${controller.locationController.latitude.value.toStringAsFixed(3)}, ${controller.locationController.longitude.value.toStringAsFixed(3)}';
      }
      return Positioned(
        left: left ?? 0,
        right: right ?? 0,
        bottom: 15,
        child: Container(
          height: 40,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.grey),
            color: controller.connectionController.isOffline.value ? Colors.red : Colors.black,
          ),
          child: Row(
            children: [
              Visibility(
                visible: controller.connectionController.isOffline.value,
                child: Container(margin: const EdgeInsets.only(right: 10), child: const Icon(Icons.wifi_off, color: Colors.white)),
              ),
              // Text(
              //   controller.locationController.isGpsEnabled.value.toString(),
              //   style: TextStyle(color: Colors.white),
              // ),
              // Obx(() => Text(controller.locationController.isGpsEnabled.value.toString(), style: TextStyle(color: Colors.white),)),
              InkWell(
                onTap: () {
                  if (GetPlatform.isAndroid && !controller.locationController.isGpsEnabled.value) {
                    controller.locationController.requestLocationService();
                  } else if (!controller.locationController.isLocationPermitted.value) {
                    controller.locationController.requestLocationPermission();
                  }
                },
                child: Text(
                  bottomMessage,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
