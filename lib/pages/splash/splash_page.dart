import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nytimes/core/app_image.dart';
import 'package:nytimes/pages/splash/splash_page_controller.dart';

/// A widget which is displayed as the splash screen of the application
class SplashPage extends GetView<SplashPageController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment.center,
        child: Image.asset(
          AppImage.splashImage,
        ),
      ),
    );
  }
}
