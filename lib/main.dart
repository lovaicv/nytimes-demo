import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:nytimes/api/home_api_provider.dart';
import 'package:nytimes/api/home_respository.dart';
import 'package:nytimes/controllers/connection_controller.dart';
import 'package:nytimes/controllers/location_controller.dart';
import 'package:nytimes/core/routes.dart';
import 'package:nytimes/pages/landing/landing_page.dart';
import 'package:nytimes/pages/landing/landing_page_controller.dart';
import 'package:nytimes/pages/search/search_page.dart';
import 'package:nytimes/pages/search/search_page_controller.dart';
import 'package:nytimes/pages/splash/splash_page.dart';
import 'package:nytimes/pages/splash/splash_page_controller.dart';
import 'package:nytimes/pages/webview/app_webview.dart';
import 'package:nytimes/pages/webview/app_webview_controller.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      title: 'NY Times',
      debugShowCheckedModeBanner: false,
      defaultTransition: GetPlatform.isIOS ? Get.defaultTransition : Transition.cupertino,
      initialRoute: Routes.splash,
      initialBinding: BindingsBuilder(() {
        Get.put(HomeProvider());
        Get.put(HomeRepository(provider: Get.find()));
        Get.put(ConnectionController(), permanent: true);
        Get.put(LocationController(), permanent: true);
      }),
      getPages: [
        GetPage(
          name: Routes.splash,
          page: () => const SplashPage(),
          binding: BindingsBuilder(() {
            Get.put(SplashPageController());
          }),
        ),
        GetPage(
          name: Routes.landing,
          page: () => const LandingPage(),
          binding: BindingsBuilder(() {
            Get.put(LandingPageController(repository: Get.find(), connectionController: Get.find(), hive: Hive));
          }),
        ),
        GetPage(
          name: Routes.search,
          page: () => const SearchPage(),
          binding: BindingsBuilder(() {
            Get.put(SearchPageController(repository: Get.find()));
          }),
        ),
        GetPage(
          name: Routes.webView,
          page: () => const AppWebView(),
          binding: BindingsBuilder(() {
            Get.put(AppWebViewController());
          }),
        ),
      ],
    );
  }
}
