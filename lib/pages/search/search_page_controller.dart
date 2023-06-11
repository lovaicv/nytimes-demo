import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nytimes/api/home_respository.dart';
import 'package:nytimes/models/search_article_response_model.dart';

class SearchPageController extends GetxController {
  SearchPageController({required this.repository});

  String searchText = '';
  HomeRepository repository;
  List<Docs>? docs = <Docs>[].obs;
  Timer? debounce;
  RxBool isLoading = false.obs;
  RxBool isReload = false.obs;
  PagingController<int, Docs> pagingController = PagingController(firstPageKey: 0);
  ScrollController scrollController = ScrollController();
  FocusNode focusNode = FocusNode();
  RxString text = 'Type in the search box to begin search'.obs;

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

  reset() {
    docs?.clear();
    pagingController.refresh();
  }

  searchArticle(int page) async {
    if (!isReload.value) isLoading.value = true;
    SearchArticleResponseModel responseModel = await repository.searchArticle(searchText, page);
    if (!isReload.value) isLoading.value = false;
    if (responseModel.status == 'OK') {
      if (responseModel.response != null && responseModel.response?.docs != null) {
        if (responseModel.response!.docs!.isNotEmpty) {
          docs?.addAll(responseModel.response!.docs!);
          final isLastPage = responseModel.response!.docs!.isEmpty;
          if (isLastPage) {
            pagingController.appendLastPage(docs!);
          } else {
            final nextPageKey = page + 1;
            pagingController.appendPage(docs!, nextPageKey);
          }
        } else {
          text.value = 'Nothing to show';
        }
      }
    }
  }
}
