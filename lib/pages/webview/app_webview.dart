import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:nytimes/pages/webview/app_webview_controller.dart';
import 'package:nytimes/widgets/bottom_bar.dart';

class AppWebView extends GetView<AppWebViewController> {
  const AppWebView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic arguments = ModalRoute.of(context)?.settings.arguments;
    InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        transparentBackground: true,
        verticalScrollBarEnabled: false,
        horizontalScrollBarEnabled: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Live Page"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Visibility(
                visible: controller.loadingPercentage.value != 100,
                child: Obx(
                  () => LinearProgressIndicator(
                    value: controller.loadingPercentage.value / 100.0,
                  ),
                ),
              ),
              Expanded(
                child: InAppWebView(
                  initialUrlRequest: URLRequest(url: Uri.parse(arguments['url'])),
                  initialOptions: options,
                  onProgressChanged: (inAppWebViewController, progress) {
                    controller.loadingPercentage.value = progress;
                  },
                ),
              ),
            ],
          ),
          Obx(() => bottomBar(right: 0)),
        ],
      ),
    );
  }
}
