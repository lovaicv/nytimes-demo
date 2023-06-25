import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:location/location.dart' hide LocationAccuracy;

/// The `LocationController` class is a GetX controller for managing device location information.
class LocationController extends GetxController {
  StreamSubscription<Position>? streamSubscription;
  RxDouble longitude = 0.0.obs;
  RxDouble latitude = 0.0.obs;
  RxBool isGpsEnabled = false.obs;
  RxBool isLocationPermitted = false.obs;

  @override
  onClose() {
    streamSubscription?.cancel();
  }

  @override
  void onInit() {
    checkLocationService();
    checkLocationPermission();
    super.onInit();
  }

  /// Requests the user to enable location services on the device.
  /// Only works on Android devices.
  void requestLocationService() async {
    isGpsEnabled.value = await Location().requestService();
  }

  /// Checks whether location services are enabled on the device.
  void checkLocationService() async {
    isGpsEnabled.value = await Geolocator.isLocationServiceEnabled();
  }

  /// Requests location permission from the user.
  void requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      isLocationPermitted.value = true;
      determinePosition();
    } else {
      isLocationPermitted.value = false;
    }
  }

  /// Checks whether location permission is granted.
  void checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      isLocationPermitted.value = true;
      determinePosition();
    } else {
      isLocationPermitted.value = false;
    }
  }

  /// Determines the current device position and updates the latitude and longitude values.
  determinePosition() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      await Location().requestService();
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      const LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
      );
      // this is device's location stream where coordinate will be constantly updated
      streamSubscription = Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position? position) {
        if (position != null) {
          latitude.value = position.latitude;
          longitude.value = position.longitude;
        }
      });
      // This is an alternate solution for getting device's coordinate
      // Location location = Location();
      // location.enableBackgroundMode(enable: true);
      // location.onLocationChanged.listen((LocationData currentLocation) {
      //   latitude.value = currentLocation.latitude!;
      //   longitude.value = currentLocation.longitude!;
      // });
    }
  }
}
