// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:nytimes/controllers/connection_controller.dart';
// import 'package:nytimes/controllers/location_controller.dart';
// import 'package:nytimes/core/app_string.dart';
//
// Future<Widget> bottomBar({left = 0, required double right, Function? callback}) async {
//   LocationController locationController = Get.find();
//   ConnectionController connectionController = Get.find();
//   locationController.determinePosition();
//   connectionController.getConnection();
//   if (!connectionController.isOffline.value && callback != null) callback();
//   String bottomMessage = '';
//   if (connectionController.isOffline.value) {
//     bottomMessage = AppString.offline.tr;
//   } else if (!await locationController.isGpsEnabled()) {
//     bottomMessage = GetPlatform.isAndroid ? 'Click here to enable GPS' : 'Please enable GPS';
//   } else if (!await locationController.isLocationPermitted()) {
//     bottomMessage = 'Click here to enable location permission';
//   } else {
//     bottomMessage = '${locationController.latitude.toStringAsFixed(3)}, ${locationController.longitude.toStringAsFixed(3)}';
//   }
//   return Positioned(
//     left: left,
//     right: right,
//     bottom: 15,
//     child: Container(
//       height: 40,
//       margin: const EdgeInsets.all(10),
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         borderRadius: const BorderRadius.all(Radius.circular(10)),
//         border: Border.all(color: Colors.grey),
//         color: connectionController.isOffline.value ? Colors.red : Colors.black,
//       ),
//       child: Row(
//         children: [
//           Visibility(
//             visible: connectionController.isOffline.value,
//             child: Container(margin: const EdgeInsets.only(right: 10), child: const Icon(Icons.wifi_off, color: Colors.white)),
//           ),
//           Text(
//             bottomMessage,
//             style: const TextStyle(color: Colors.white),
//           ),
//         ],
//       ),
//     ),
//   );
// }
