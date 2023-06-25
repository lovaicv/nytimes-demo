import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nytimes/api/urls.dart';
import 'package:nytimes/core/app_image.dart';
import 'package:nytimes/core/app_string.dart';
import 'package:nytimes/core/routes.dart';
import 'package:nytimes/database/articles_db.dart';
import 'package:nytimes/pages/search/search_page_controller.dart';
import 'package:nytimes/widgets/bottom_bar/bottom_bar.dart';

class SearchPage extends GetView<SearchPageController> {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          AppString.search.tr,
          style: const TextStyle(color: Colors.black),
        ),
        foregroundColor: Colors.black,
      ),
      body: GetBuilder(
        builder: (SearchPageController controller) => Stack(
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.white),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        focusNode: controller.focusNode,
                            decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: AppString.election.tr,
                        ),
                        onChanged: (newText) {
                          controller.searchText = newText;
                          if (newText.isNotEmpty) {
                            if (controller.debounce?.isActive ?? false) controller.debounce?.cancel();
                            controller.debounce = Timer(const Duration(milliseconds: 500), () {
                              controller.reset();
                              controller.searchArticle(0);
                            });
                          }
                        },
                      )),
                      InkWell(
                        onTap: () {
                          controller.reset();
                          controller.searchArticle(0);
                        },
                        child: const Icon(Icons.search),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: PagedListView.separated(
                      scrollController: controller.scrollController,
                      pagingController: controller.pagingController,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 60),
                      builderDelegate: PagedChildBuilderDelegate<Article>(itemBuilder: (BuildContext context, Article article, int index) {
                        // Docs? docs = controller.docs?[index];
                        String? imageUrl;
                        if (article.multimediaUrl != null && article.multimediaUrl!.isNotEmpty) {
                          imageUrl = '${Urls.imageUrl}${article.multimediaUrl}';
                        }
                        return InkWell(
                          onTap: () {
                            Get.toNamed(Routes.webView, arguments: {'url': article.url});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color: Colors.white),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Visibility(
                                    visible: imageUrl != null && imageUrl.isNotEmpty,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                      child: CachedNetworkImage(
                                        imageUrl: imageUrl ?? '',
                                        height: 250,
                                        fit: BoxFit.cover,
                                        placeholder: (BuildContext context, String string) => Image.asset(
                                          AppImage.placeHolderImage,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                        errorWidget: (context, url, error) => Image.asset(
                                          AppImage.placeHolderImage,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                      ),
                                    )),
                                const SizedBox(
                                  height: 5,
                                ),
                                // Text(article.keywords ?? ''),
                                Container(
                                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        article.title ?? '',
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        article.abstract ?? '',
                                        textAlign: TextAlign.justify,
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      // Text(article.tag??''),
                                      Text(article.date ?? ''),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }, firstPageProgressIndicatorBuilder: (_) {
                        // return progressIndicator();
                        return Container();
                      }, newPageProgressIndicatorBuilder: (_) {
                        return const SizedBox(
                            height: 50,
                            width: 50,
                            child: Center(
                                child: CircularProgressIndicator(
                              color: Colors.white,
                            )));
                      }, noItemsFoundIndicatorBuilder: (_) {
                        return Center(child: Text(AppString.noResultFound.tr));
                      }, newPageErrorIndicatorBuilder: (_) {
                        return Container();
                      }),
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 20,
                        );
                      },
                      // itemCount: controller.docs?.length ?? 0,
                    ),
                  ),
                ),
              ],
            ),
            Obx(() => Center(
                  child: Visibility(
                    visible: !controller.isLoading.value && controller.isListEmpty.value,
                    child: Text(
                      controller.text.value,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                )),
            // Obx(() => bottomBar(right: 0)),
            BottomBar(
              right: 0,
            ),
            Center(
                child: Obx(
              () => Visibility(
                visible: controller.isLoading.value,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
