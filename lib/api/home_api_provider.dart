import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:nytimes/api/urls.dart';
import 'package:nytimes/core/constant.dart';
import 'package:nytimes/utils/utils.dart';

class HomeProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = Urls.baseUrl;
    httpClient.maxAuthRetries = 3;

    httpClient.addRequestModifier((Request request) {
      showLog(request.url);
      return request;
    });

    super.onInit();
  }

  Future<Response<dynamic>> getTopStories(String path) => get(
        path,
        query: {'api-key': Constant.getApiKey()},
      );

  Future<Response<dynamic>> getMostPopular(String path) => get(
        path,
        query: {'api-key': Constant.getApiKey()},
      );

  // Future<Response<dynamic>> getMostShared(int period) => get(
  //       path,
  //       query: {'api-key': Constant.getApiKey()},
  //     );
  //
  // Future<Response<dynamic>> getMostViewed(int period path) => get(
  //       path,
  //       query: {'api-key': Constant.getApiKey()},
  //     );

  Future<Response<dynamic>> searchArticle(String path, String query, int page) => get(
        path,
        query: {
          'q': query,
          'page': page.toString(),
          'api-key': Constant.getApiKey(),
        },
      );
}

// dynamic responseHandler(Response response) {
//   switch (response.statusCode) {
//     case 200:
//     case 201:
//     case 202:
//       var responseJson = response.body.toString();
//       return responseJson;
//     case 500:
//       throw "Server Error pls retry later";
//     case 403:
//       throw 'Error occurred pls check internet and retry.';
//     case 500:
//     default:
//       throw 'Error occurred retry';
//   }
// }
