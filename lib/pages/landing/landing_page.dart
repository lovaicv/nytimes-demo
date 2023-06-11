import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:nytimes/core/routes.dart';
import 'package:nytimes/models/top_stories_response_model.dart';
import 'package:nytimes/pages/landing/landing_page_controller.dart';
import 'package:nytimes/widgets/bottom_bar.dart';

class LandingPage extends GetView<LandingPageController> {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/images/ny_times.jpg',
          width: 200,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: () async {
              await Geolocator.openAppSettings();
            },
          )
        ],
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            key: controller.refreshIndicatorKey,
            onRefresh: () {
              return controller.getTopStories();
            },
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                            child: const Text(
                              'Top Stories',
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                            )),
                        Obx(
                          () => ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            primary: false,
                            padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 80),
                            itemBuilder: (BuildContext context, int index) {
                              Results? result = controller.results[index];
                              String? imageUrl = '';
                              if (result.multimedia?.length == 1) {
                                imageUrl = result.multimedia?[0].url;
                              } else {
                                imageUrl = result.multimedia?[1].url;
                              }
                              return InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.webView, arguments: {'url': result.url});
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
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                result.title ?? '',
                                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: (15)),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              result.abstract ?? '',
                                              style: const TextStyle(
                                                fontSize: (15),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return const SizedBox(
                                height: 20,
                              );
                            },
                            itemCount: controller.results.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(() => Visibility(
                visible: controller.connectionController.isOffline.value && controller.results.isEmpty,
                child: const Center(
                  child: Text(
                    'Nothing to show',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )),
          Obx(() => bottomBar(
              right: 70,
              callback: () {
                if (controller.results.isEmpty) {
                  controller.getTopStories();
                }
              })),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        onPressed: () {
          Get.toNamed(Routes.search);
        },
        child: const Icon(Icons.search),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
