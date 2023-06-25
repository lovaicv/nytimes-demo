import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nytimes/api/home_respository.dart';
import 'package:nytimes/api/urls.dart';
import 'package:nytimes/controllers/connection_controller.dart';
import 'package:nytimes/controllers/location_controller.dart';
import 'package:nytimes/core/app_string.dart';
import 'package:nytimes/database/articles_db.dart';
import 'package:nytimes/models/most_popular_response_model.dart';
import 'package:nytimes/models/top_stories_response_model.dart';
import 'package:nytimes/utils/utils.dart';

/// The controller for the `LandingPage` widget.
class LandingPageController extends GetxController {
  LandingPageController({
    required this.repository,
    required this.locationController,
    required this.connectionController,
    required this.hive,
  });

  final HomeRepository repository;
  final LocationController locationController;
  final ConnectionController connectionController;
  final HiveInterface hive;
  final _pageSize = 10;
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  PagingController<int, Article> pagingController = PagingController(firstPageKey: 1);
  RxString title = AppString.topStories.obs;
  List<String> titles = [
    AppString.topStories,
    AppString.mostPopularEmailed,
    AppString.mostPopularShared,
    AppString.mostPopularViewed,
  ];
  RxList<Article> results = <Article>[].obs;
  RxBool isOffline = false.obs;
  bool isLoading = false;

  @override
  onInit() async {
    super.onInit();
    refreshList();
    pagingController.addPageRequestListener((pageKey) {
      showLog('addPageRequestListener $pageKey');
      getArticles(pageKey);
    });
  }

  @override
  onClose() {
    pagingController.dispose();
  }

  /// Resets the paging controller, clearing the results.
  void reset() {
    results.clear();
    pagingController.refresh();
  }

  /// Make an API call to fetch top stories articles and store it in the database
  /// [pageKey] to indicate which page to load
  Future<bool> callTopStoriesApi(int pageKey) async {
    ArticleBox box = ArticleBox(hive: hive);
    if (pageKey == 1) {
      if (!await connectionController.getConnection()) {
        TopStoriesResponseModel responseModel = await repository.getTopStories();
        if (responseModel.status == Urls.statusOk && responseModel.results != null) {
          // results.clear();
          showLog('total articles from api ${responseModel.results?.length}');
          List<Article> articles = await box.getAllItems();
          for (var element in responseModel.results!) {
            String? multimediaUrl = '';
            if (element.multimedia != null && element.multimedia!.isNotEmpty) {
              try {
                multimediaUrl = element.multimedia![1].url;
              } catch (e) {
                multimediaUrl = element.multimedia![0].url;
              }
            }
            String? keywords = '';
            if (element.desFacet != null && element.desFacet!.isNotEmpty) {
              keywords = element.desFacet!.join(',');
            }
            Article article = Article(
              element.url,
              multimediaUrl,
              element.title,
              element.abstract,
              keywords,
              AppString.topStories,
              convertDateFormat(element.publishedDate!),
            );
            // results.add(article);
            Iterable<Article> isArticleExist = articles.where((article) => element.url == article.url);
            if (isArticleExist.isEmpty) {
              await box.addItem(article);
            }
          }
          showLog('return api call 1');
          return Future.value(true);
        } else {
          showLog('return api call 2');
          return Future.value(true);
        }
      } else {
        showLog('return api call 3');
        return Future.value(true);
      }
    } else {
      showLog('return api call 4');
      return Future.value(true);
    }
  }

  /// Fetch top stories articles from the local database and populate the results list
  /// [pageKey] to indicate which page to load
  Future<void> getTopStories(int pageKey) async {
    ArticleBox box = ArticleBox(hive: hive);

    bool isFinish = await callTopStoriesApi(pageKey);
    showLog('isFinish $isFinish');

    if (isFinish) {
      if (pageKey == 1) {
        List<Article> articles = await box.getAllItems();
        showLog('total item in box ${articles.length}');
        List<Article> alteredList = articles.where((element) => element.tag == AppString.topStories).toList();
        alteredList.sort((a, b) => myDateFormat().parse(b.date!).compareTo(myDateFormat().parse(a.date!)));
        results.clear();
        results.addAll(alteredList);
      }

      // ================== pagination ==================
      List<Article> sublist = [];
      showLog('results ${results.length}');
      showLog('page $pageKey');
      if (pageKey == 1) {
        showLog('condition ${pageKey * _pageSize} < ${results.length}');
        if (pageKey * _pageSize < results.length) {
          int start = 0;
          int end = pageKey * _pageSize;
          showLog('start $start end $end');
          sublist = results.sublist(start, end);
        } else if (pageKey * _pageSize > results.length) {
          showLog('start 0 end ${results.length}');
          sublist = results.sublist(0, results.length);
        } else {
          sublist = results.sublist(pageKey * _pageSize, results.length);
        }
      } else {
        // int tempPageKey = pageKey-1;
        showLog('condition ${pageKey * _pageSize} < ${results.length}');
        if (pageKey * _pageSize < results.length) {
          int start = (pageKey - 1) * _pageSize;
          int end = pageKey * _pageSize;
          showLog('start $start end $end');
          sublist = results.sublist(start, end);
        } else {
          sublist = results.sublist((pageKey - 1) * _pageSize, results.length);
        }
      }

      showLog('sublist ${sublist.length}');
      final isLastPage = sublist.length < _pageSize;
      if (isLastPage) {
        showLog('last page $pageKey');
        pagingController.appendLastPage(sublist);
      } else {
        // final nextPageKey = pageKey + sublist.length;
        showLog('$pageKey next page ${pageKey + 1}');
        pagingController.appendPage(sublist, pageKey + 1);
      }
      // ================== pagination ==================
    }
    isLoading = false;
    showLog('list item ${pagingController.value.itemList?.length}');
    return;
  }

  /// Make an API call to fetch most popular articles and store it in the database
  /// [path] most popular url path, eg mostviewed, mostshared, mostemailed
  /// [period] period which the article is most popular
  /// [pageKey] to indicate which page to load
  /// [tag] to indicate the source of the article
  Future<bool> callMostPopularApi(String path, int period, int pageKey, String tag) async {
    ArticleBox box = ArticleBox(hive: hive);
    List<Article> articles = await box.getAllItems();
    showLog('total item in box ${articles.length}');

    if (pageKey == 1) {
      if (!await connectionController.getConnection()) {
        MostPopularResponseModel responseModel = await repository.getMostPopular(path, period);
        if (responseModel.status == Urls.statusOk) {
          showLog('total articles from api ${responseModel.results?.length}');
          for (var element in responseModel.results!) {
            String? multimediaUrl = '';
            if (element.media != null && element.media!.isNotEmpty) {
              Media media = element.media![0];
              if (media.mediaMetadata != null && media.mediaMetadata!.isNotEmpty) {
                try {
                  multimediaUrl = media.mediaMetadata![2].url;
                } catch (e) {
                  multimediaUrl = media.mediaMetadata![0].url;
                }
              }
            }
            String? keywords = '';
            if (element.desFacet != null && element.desFacet!.isNotEmpty) {
              keywords = element.desFacet!.join(',');
            }
            Article article = Article(
              element.url,
              multimediaUrl,
              element.title,
              element.abstract,
              keywords,
              tag,
              convertDateFormat(element.publishedDate!),
            );
            results.add(article);
            Iterable<Article> isArticleExist = articles.where((element) => element.url == article.url);
            if (isArticleExist.isEmpty) {
              await box.addItem(article);
            }
          }
          return Future.value(true);
        } else {
          return Future.value(true);
        }
      } else {
        return Future.value(true);
      }
    } else {
      return Future.value(true);
    }
  }

  /// Fetch most popular articles from the local database and populate the results list
  /// [pageKey] to indicate which page to load
  Future<void> getMostPopular(String path, int period, int pageKey, String tag) async {
    ArticleBox box = ArticleBox(hive: hive);
    bool isFinish = await callMostPopularApi(path, period, pageKey, tag);

    if (isFinish) {
      if (pageKey == 1) {
        List<Article> articles = await box.getAllItems();
        List<Article> alteredList = articles.where((element) => element.tag == tag).toList();
        alteredList.sort((a, b) => myDateFormat().parse(b.date!).compareTo(myDateFormat().parse(a.date!)));
        results.clear();
        results.addAll(alteredList);
      }

      // ================== pagination ==================
      List<Article> sublist = [];

      showLog('results ${results.length}');
      showLog('page $pageKey');
      if (pageKey == 1) {
        showLog('condition ${pageKey * _pageSize} < ${results.length}');
        if (pageKey * _pageSize < results.length) {
          int start = 0;
          int end = pageKey * _pageSize;
          showLog('start $start end $end');
          sublist = results.sublist(start, end);
        } else if (pageKey * _pageSize > results.length) {
          showLog('start 0 end ${results.length}');
          sublist = results.sublist(0, results.length);
        } else {
          showLog('start ${pageKey * _pageSize} end ${results.length}');
          sublist = results.sublist(pageKey * _pageSize, results.length);
        }
      } else {
        // int tempPageKey = pageKey-1;
        showLog('condition ${pageKey * _pageSize} < ${results.length}');
        if (pageKey * _pageSize < results.length) {
          int start = (pageKey - 1) * _pageSize;
          int end = pageKey * _pageSize;
          showLog('start $start end $end');
          sublist = results.sublist(start, end);
        } else {
          showLog('start ${(pageKey - 1) * _pageSize} end ${results.length}');
          sublist = results.sublist((pageKey - 1) * _pageSize, results.length);
        }
      }
      showLog('sublist ${sublist.length}');
      final isLastPage = sublist.length < _pageSize;
      if (isLastPage) {
        showLog('last page $pageKey');
        pagingController.appendLastPage(sublist);
      } else {
        // final nextPageKey = pageKey + sublist.length;
        showLog('$pageKey next page ${pageKey + 1}');
        pagingController.appendPage(sublist, pageKey + 1);
      }
    }
    isLoading = false;
    showLog('list item ${pagingController.value.itemList?.length}');
    return;
  }

  /// Get which articles' source
  /// [pageKey] to indicate which page to load
  Future getArticles(int pageKey) async {
    if (!isLoading) {
      showLog('getArticles');
      isLoading = true;
      switch (title.value) {
        case AppString.topStories:
          return await getTopStories(pageKey);
        case AppString.mostPopularEmailed:
          return await getMostPopular(Urls.mostPopularEmailed, 1, pageKey, AppString.mostPopularEmailed);
        case AppString.mostPopularShared:
          return await getMostPopular(Urls.mostPopularShared, 1, pageKey, AppString.mostPopularShared);
        case AppString.mostPopularViewed:
          return await getMostPopular(Urls.mostPopularViewed, 1, pageKey, AppString.mostPopularViewed);
      }
    }
    return;
  }

  /// Set the dropdown [value] to switch between article's source
  void setTitle(String? value) {
    title.value = value ?? titles[0];
  }

  /// Refresh the article list
  void refreshList() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshIndicatorKey.currentState?.show();
    });
  }
}
