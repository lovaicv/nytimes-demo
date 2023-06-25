import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:location/location.dart' hide LocationAccuracy;
import 'package:nytimes/utils/utils.dart';

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

  void requestLocationService() async {
    isGpsEnabled.value = await Location().requestService();
  }

  void checkLocationService() async {
    isGpsEnabled.value = await Geolocator.isLocationServiceEnabled();
  }

  void requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      isLocationPermitted.value = true;
      determinePosition();
    } else {
      isLocationPermitted.value = false;
    }
  }

  void checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      isLocationPermitted.value = true;
      determinePosition();
    } else {
      isLocationPermitted.value = false;
    }
  }

  determinePosition() async {
    // bool serviceEnabled;
    // LocationPermission permission;

    // Test if location services are enabled.
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    showLog('isServiceEnabled $isServiceEnabled');
    if (!isServiceEnabled) {
      showLog('requestService');
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Location().requestService();
      // return Future.error('Location services are disabled.');
    }

    // permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.denied) {
    //     // Permissions are denied, next time you could try
    //     // requesting permissions again (this is also where
    //     // Android's shouldShowRequestPermissionRationale
    //     // returned true. According to Android guidelines
    //     // your App should show an explanatory UI now.
    //     // return Future.error('Location permissions are denied');
    //   }
    // }

    // if (permission == LocationPermission.deniedForever) {
    //   // Permissions are denied forever, handle appropriately.
    //   // return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    // }

    LocationPermission permission = await Geolocator.checkPermission();
    showLog('isPermit $permission');
    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      // Position position = await Geolocator.getCurrentPosition();
      const LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
      );
      streamSubscription = Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position? position) {
        showLog('Geolocator $position');
        if (position != null) {
          latitude.value = position.latitude;
          longitude.value = position.longitude;
        }
      });

      // Location location = Location();
      // location.enableBackgroundMode(enable: true);
      // location.onLocationChanged.listen((LocationData currentLocation) {
      //   latitude.value = currentLocation.latitude!;
      //   longitude.value = currentLocation.longitude!;
      // });

      // return position;
    }
  }
}
