import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nytimes/core/app_image.dart';
import 'package:nytimes/core/app_string.dart';
import 'package:nytimes/core/routes.dart';
import 'package:nytimes/database/articles_db.dart';
import 'package:nytimes/pages/landing/landing_page_controller.dart';
import 'package:nytimes/widgets/bottom_bar/bottom_bar.dart';

class LandingPage extends GetView<LandingPageController> {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          AppImage.nyTimes,
          width: 200,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              // controller.locationController.isGpsEnabled.value ? Icons.location_on : Icons.location_off,
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: () async {
              await Geolocator.openAppSettings();
              // if (!controller.locationController.isGpsEnabled.value) {
              //   showLog('click to requestService');
              //   controller.locationController.requestLocationService();
              //
              // } else {
              //   await Geolocator.openAppSettings();
              // }
            },
          ),
        ],
      ),
      body: GetBuilder(
          builder: (LandingPageController controller) => Stack(
                children: [
                  RefreshIndicator(
                    displacement: 60,
                    key: controller.refreshIndicatorKey,
                    onRefresh: () {
                      controller.reset();
                      return controller.getArticles(1);
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(top: 60),
                            child: PagedListView.separated(
                              pagingController: controller.pagingController,
                              // physics: const NeverScrollableScrollPhysics(),
                              // shrinkWrap: true,
                              // primary: false,
                              padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 80),
                              builderDelegate: PagedChildBuilderDelegate<Article>(
                                itemBuilder: (BuildContext context, Article article, int index) {
                                  // Article article = controller.results[index];
                                  // String? imageUrl = '';
                                  // if (article.multimediaUrl?.length == 1) {
                                  //   imageUrl = article.multimedia?[0].url;
                                  // } else {
                                  //   imageUrl = article.multimedia?[1].url;
                                  // }
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
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                            child: CachedNetworkImage(
                                              imageUrl: article.multimediaUrl ?? '',
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
                                          ),
                                          // Text(article.keywords ?? ''),
                                          Container(
                                            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                                            child: Column(
                                              children: [
                                                Container(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    article.title ?? '',
                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: (15)),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  article.abstract ?? '',
                                                  textAlign: TextAlign.justify,
                                                  style: const TextStyle(
                                                    fontSize: (15),
                                                  ),
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
                                },
                                firstPageProgressIndicatorBuilder: (BuildContext context) => Container(),
                              ),
                              separatorBuilder: (BuildContext context, int index) {
                                return const SizedBox(
                                  height: 20,
                                );
                              },
                              // itemCount: controller.results.length,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(() => Container(
                        margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: controller.title.value,
                            icon: const Icon(Icons.arrow_drop_down),
                            underline: Container(),
                            onChanged: (String? value) {
                              if (controller.title.value != value) {
                                controller.setTitle(value);
                                controller.refreshList();
                              }
                            },
                            items: controller.titles.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      )),
                  Obx(() => Visibility(
                        visible: controller.connectionController.isOffline.value && controller.results.isEmpty,
                        child: Center(
                          child: Text(
                            AppString.nothingToShow.tr,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )),
                  BottomBar(
                    callback: () {
                      if (controller.results.isEmpty) {
                        controller.refreshList();
                      }
                    },
                    left: 10,
                    right: 70,
                  ),
                ],
              )),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white),
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            Get.toNamed(Routes.search);
          },
          child: const Icon(Icons.search),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
