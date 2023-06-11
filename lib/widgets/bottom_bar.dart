import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nytimes/controllers/connection_controller.dart';
import 'package:nytimes/controllers/location_controller.dart';

Widget bottomBar({required double right, Function? callback}) {
  LocationController location = Get.find();
  ConnectionController connection = Get.find();
  location.determinePosition();
  connection.getConnection();
  if (!connection.isOffline.value && callback != null) callback();
  return Positioned(
    left: 0,
    right: right,
    bottom: 15,
    child: Container(
      height: 40,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: connection.isOffline.value ? Colors.red : Colors.grey,
      ),
      child: Row(
        children: [
          Visibility(
            visible: connection.isOffline.value,
            child: Container(margin: EdgeInsets.only(right: 10), child: const Icon(Icons.wifi_off, color: Colors.white)),
          ),
          Text(
            connection.isOffline.value
                ? 'You are currently offline'
                : '${location.latitude.toStringAsFixed(3)}, ${location.longitude.toStringAsFixed(3)}',
            style: TextStyle(color: connection.isOffline.value ? Colors.white : Colors.white),
          ),
        ],
      ),
    ),
  );
}
