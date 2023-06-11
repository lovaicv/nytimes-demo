import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:nytimes/api/home_respository.dart';
import 'package:nytimes/controllers/connection_controller.dart';
import 'package:nytimes/database/articles_db.dart';
import 'package:nytimes/models/top_stories_response_model.dart';

class LandingPageController extends GetxController {
  LandingPageController({required this.repository, required this.connectionController, required this.hive});

  GlobalKey<RefreshIndicatorState> refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final HomeRepository repository;
  final ConnectionController connectionController;
  final HiveInterface hive;
  List<Results> results = <Results>[].obs;
  RxBool isOffline = false.obs;
  bool isLoading = false;

  @override
  onInit() {
    super.onInit();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshIndicatorKey.currentState?.show();
    });
  }

  // offline > no articles
  // offline > load from db
  // offline > no articles > online > load from api
  // online > refresh > load from api
  Future<void> getTopStories() async {
    ArticleBox box = ArticleBox(hive: hive);
    if (await connectionController.getConnection()) {
      List<Article> articles = await box.getAllItems();
      for (var element in articles) {
        results.add(
          Results(url: element.url, title: element.title, abstract: element.abstract, multimedia: [Multimedia(url: element.multimediaUrl)]),
        );
      }
      if (results.isNotEmpty) {
        Get.showSnackbar(GetSnackBar(
          duration: const Duration(seconds: 5),
          messageText: const Text(
            'Show articles from DB',
            style: TextStyle(color: Colors.white),
          ),
          mainButton: Container(
            margin: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Get.closeAllSnackbars();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ));
      }
    } else if (!isLoading) {
      isLoading = true;
      TopStoriesResponseModel responseModel = await repository.getTopStories();
      if (responseModel.status == 'OK') {
        isLoading = false;
        results.clear();
        results.addAll(responseModel.results!);
        box.addItems(responseModel.results!);
      }
    }
  }
}
