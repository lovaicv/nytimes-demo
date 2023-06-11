import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nytimes/core/routes.dart';
import 'package:nytimes/models/search_article_response_model.dart';
import 'package:nytimes/pages/search/search_page_controller.dart';
import 'package:nytimes/widgets/bottom_bar.dart';

class SearchPage extends GetView<SearchPageController> {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Search',
          style: TextStyle(color: Colors.black),
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
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'election',
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
                      builderDelegate: PagedChildBuilderDelegate<Docs>(itemBuilder: (BuildContext context, Docs docs, int index) {
                        // Docs? docs = controller.docs?[index];
                        String? imageUrl;
                        if (docs.multimedia != null && docs.multimedia!.isNotEmpty) {
                          imageUrl = 'https://static01.nyt.com/${docs.multimedia?[0].url}';
                        }
                        return InkWell(
                          onTap: () {
                            Get.toNamed(Routes.webView, arguments: {'url': docs.webUrl});
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
                                        errorWidget: (context, url, error) => const Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.error),
                                            Text('Error loading image'),
                                          ],
                                        ),
                                      ),
                                    )),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        docs.headline?.main ?? '',
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        docs.abstract ?? '',
                                        style: const TextStyle(fontSize: 15),
                                      ),
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
                        return const Center(child: Text('no result found'));
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
            Center(
              child: Obx(
                () => Visibility(
                  visible: !controller.isLoading.isTrue && (controller.docs?.isEmpty ?? false),
                  child: Text(
                    controller.text.value,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Obx(() => bottomBar(right: 0)),
            Center(
                child: Obx(
              () => Visibility(
                visible: controller.isLoading.isTrue,
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
