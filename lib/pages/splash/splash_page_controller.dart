import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nytimes/core/routes.dart';
import 'package:nytimes/database/articles_db.dart';
import 'package:nytimes/utils/utils.dart';

class SplashPageController extends GetxController {
  @override
  onInit() {
    super.onInit();
    initHive();
  }

  initHive() async {
    try {
      await Hive.initFlutter();
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(ArticleAdapter(), override: true);
      }
      ArticleBox box = ArticleBox(hive: Hive);
      Box articlesBox = await box.openArticlesBox();
      if (articlesBox.isOpen) {
        countDown();
      }
    } catch (e) {
      showLog('initHive $e');
    }
  }

  countDown() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAndToNamed(Routes.landing);
    });
  }
}
