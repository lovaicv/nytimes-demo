import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nytimes/api/home_respository.dart';
import 'package:nytimes/api/urls.dart';
import 'package:nytimes/controllers/connection_controller.dart';
import 'package:nytimes/core/app_string.dart';
import 'package:nytimes/database/articles_db.dart';
import 'package:nytimes/models/search_article_response_model.dart';
import 'package:nytimes/utils/utils.dart';

/// The controller for the `SearchPage` widget.
class SearchPageController extends GetxController {
  SearchPageController({required this.repository, required this.connectionController, required this.hive});

  final HomeRepository repository;
  final ConnectionController connectionController;
  final HiveInterface hive;
  final _pageSize = 10;
  RxBool isListEmpty = true.obs;
  String searchText = '';
  Timer? debounce;
  RxBool isLoading = false.obs;
  RxBool isReload = false.obs;
  PagingController<int, Article> pagingController = PagingController(firstPageKey: 0);
  ScrollController scrollController = ScrollController();
  FocusNode focusNode = FocusNode();
  RxString text = AppString.beginSearch.tr.obs;
  List<Article> results = [];

  @override
  onClose() {
    debounce?.cancel();
    scrollController.dispose();
    pagingController.dispose();
  }

  @override
  onInit() {
    super.onInit();
    scrollController.addListener(() {
      focusNode.unfocus();
    });
    pagingController.addPageRequestListener((pageKey) {
      if (searchText.isNotEmpty) {
        isReload.value = true;
        searchArticle(pageKey);
      }
    });
  }

  /// Resets the paging controller, clearing the search results.
  reset() {
    pagingController.refresh();
  }

  /// Performs a search for articles with condition
  /// [pageKey] to indicate which page to load
  searchArticle(int pageKey) async {
    if (searchText.isEmpty) {
      pagingController.refresh();
    } else {
      if (!await connectionController.getConnection()) {
        searchArticleApi(pageKey);
      } else {
        searchArticleLocal(pageKey);
      }
    }
  }

  /// Performs a search for articles using the API.
  /// [pageKey] to indicate which page to load
  searchArticleApi(int pageKey) async {
    int tempPageKey = pageKey;
    if (!isReload.value) isLoading.value = true;
    SearchArticleResponseModel responseModel = await repository.searchArticle(searchText, tempPageKey);
    if (!isReload.value) isLoading.value = false;
    if (responseModel.status == Urls.statusOk) {
      if (responseModel.response != null && responseModel.response?.docs != null) {
        if (responseModel.response!.docs!.isNotEmpty) {
          // ================== save to db ==================
          ArticleBox box = ArticleBox(hive: hive);
          List<Article> articles = await box.getAllItems();
          results.clear();
          isListEmpty.value = responseModel.response!.docs!.isEmpty;
          for (var element in responseModel.response!.docs!) {
            String? multimediaUrl = '';
            if (element.multimedia != null && element.multimedia!.isNotEmpty) {
              multimediaUrl = element.multimedia![0].url;
            }
            String? keywords = '';
            if (element.keywords != null && element.keywords!.isNotEmpty) {
              for (var element in element.keywords!) {
                keywords = '$keywords,${element.value}';
              }
            }
            Article article = Article(
              element.webUrl,
              multimediaUrl,
              element.headline!.main,
              element.abstract,
              keywords,
              AppString.searchC,
              convertDateFormat(element.pubDate!),
            );
            Iterable<Article> isArticleExist = articles.where((article) => element.webUrl == article.url);
            if (isArticleExist.isEmpty) {
              await box.addItem(article);
            }
            results.add(article);
            // ================== save to db ==================
          }
          // ======================== pagination add item to the list ========================
          final isLastPage = responseModel.response!.docs!.isEmpty;
          if (isLastPage) {
            pagingController.appendLastPage(results);
          } else {
            final nextPageKey = tempPageKey + 1;
            pagingController.appendPage(results, nextPageKey);
          }
          // ======================== pagination add item to the list ========================
        }
      }
    }
  }

  /// Performs a local search for articles.
  /// Only happen when device is in offline mode.
  /// [pageKey] to indicate which page to load
  searchArticleLocal(int pageKey) async {
    int tempPageKey = pageKey + 1;
    ArticleBox box = ArticleBox(hive: hive);
    // ======================== get all item from DB and filter, only run time which is page 1 ========================
    List<Article> articles = await box.getAllItems();
    List<Article> alteredList = articles.where((element) => element.keywords!.toLowerCase().contains(searchText.toLowerCase())).toList();
    alteredList.sort((a, b) => myDateFormat().parse(b.date!).compareTo(myDateFormat().parse(a.date!)));
    results.clear();
    results.addAll(alteredList);
    isListEmpty.value = results.isEmpty;
    List<Article> sublist = [];
    // ======================== get all item from DB and filter, only run time which is page 1 ========================
    // ======================== get item from DB in chuck size of 10 ========================
    if (tempPageKey == 1) {
      if (tempPageKey * _pageSize < results.length) {
        int start = 0;
        int end = tempPageKey * _pageSize;
        sublist = results.sublist(start, end);
      } else if (tempPageKey * _pageSize > results.length) {
        sublist = results.sublist(0, results.length);
      } else {
        sublist = results.sublist(tempPageKey * _pageSize, results.length);
      }
    } else {
      if (tempPageKey * _pageSize < results.length) {
        int start = (tempPageKey - 1) * _pageSize;
        int end = tempPageKey * _pageSize;
        sublist = results.sublist(start, end);
      } else {
        sublist = results.sublist((tempPageKey - 1) * _pageSize, results.length);
      }
    }
    // ======================== get item from DB in chuck size of 10 ========================
    // ======================== pagination add item to the list ========================
    final isLastPage = sublist.length < _pageSize;
    if (isLastPage) {
      pagingController.appendLastPage(sublist);
    } else {
      pagingController.appendPage(sublist, tempPageKey);
    }
    // ======================== pagination add item ========================
  }
}
