import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:nytimes/api/urls.dart';
import 'package:nytimes/core/constant.dart';

/// The `HomeProvider` class is responsible for making HTTP requests to the NY Times API
/// in order to retrieve articles and perform article searches.
class HomeProvider extends GetConnect {
  /// Initializes the `HomeProvider` by setting the base URL and maximum authentication retries for the HTTP client.
  @override
  void onInit() {
    httpClient.baseUrl = Urls.baseUrl;
    httpClient.maxAuthRetries = 3;

    // Request modifier to log the URL before sending the request
    httpClient.addRequestModifier((Request request) {
      return request;
    });

    super.onInit();
  }

  /// Sends an HTTP GET request to retrieve articles from the NY Times API.
  ///
  /// The [path] parameter specifies the endpoint path for retrieving articles.
  /// Returns a [Future] containing the response from the API.
  Future<Response<dynamic>> getArticles(String path) => get(
        path,
        query: {'api-key': Constant.getApiKey()},
      );

  /// Sends an HTTP GET request to search for articles in the NY Times API.
  ///
  /// The [path] parameter specifies the endpoint path for searching articles.
  /// The [query] parameter is the search query string.
  /// The [page] parameter specifies the page number of the search results.
  /// Returns a [Future] containing the response from the API.
  Future<Response<dynamic>> searchArticle(String path, String query, int page) => get(
        path,
        query: {
          'q': query,
          'page': page.toString(),
          'api-key': Constant.getApiKey(),
        },
      );
}
