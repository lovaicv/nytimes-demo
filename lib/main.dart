import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:nytimes/api/home_api_provider.dart';
import 'package:nytimes/api/home_respository.dart';
import 'package:nytimes/controllers/connection_controller.dart';
import 'package:nytimes/controllers/location_controller.dart';
import 'package:nytimes/core/app_string.dart';
import 'package:nytimes/core/routes.dart';
import 'package:nytimes/lang/translation_service.dart';
import 'package:nytimes/pages/landing/landing_page.dart';
import 'package:nytimes/pages/landing/landing_page_controller.dart';
import 'package:nytimes/pages/search/search_page.dart';
import 'package:nytimes/pages/search/search_page_controller.dart';
import 'package:nytimes/pages/splash/splash_page.dart';
import 'package:nytimes/pages/splash/splash_page_controller.dart';
import 'package:nytimes/pages/webview/app_webview.dart';
import 'package:nytimes/pages/webview/app_webview_controller.dart';
import 'package:nytimes/widgets/bottom_bar/bottom_bar_controller.dart';

/// The entry point of the application.
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

/// The root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  /// GetX is used to provide state management, translation, dependency injection, and route management.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      translations: TranslationService(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      title: AppString.appName.tr,
      debugShowCheckedModeBanner: false,
      defaultTransition: GetPlatform.isIOS ? Get.defaultTransition : Transition.cupertino,
      initialRoute: Routes.splash,
      initialBinding: BindingsBuilder(() {
        Get.put(HomeProvider());
        Get.put(HomeRepository(provider: Get.find()));
        Get.put(ConnectionController(), permanent: true);
        Get.put(LocationController(), permanent: true);
        Get.put(BottomBarController(connectionController: Get.find(), locationController: Get.find()), permanent: true);
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
            Get.put(LandingPageController(
              repository: Get.find(),
              locationController: Get.find(),
              connectionController: Get.find(),
              hive: Hive,
            ));
          }),
        ),
        GetPage(
          name: Routes.search,
          page: () => const SearchPage(),
          binding: BindingsBuilder(() {
            Get.put(SearchPageController(
              repository: Get.find(),
              connectionController: Get.find(),
              hive: Hive,
            ));
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
