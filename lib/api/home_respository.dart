import 'package:get/get_connect/http/src/response/response.dart';
import 'package:nytimes/api/home_api_provider.dart';
import 'package:nytimes/api/urls.dart';
import 'package:nytimes/core/my_dialog.dart';
import 'package:nytimes/models/most_popular_response_model.dart';
import 'package:nytimes/models/search_article_response_model.dart';
import 'package:nytimes/models/top_stories_response_model.dart';

/// The `HomeRepository` class is responsible for fetching data from the NY Times API
/// by utilizing the `HomeProvider` to make the necessary HTTP requests.
class HomeRepository {
  HomeRepository({required this.provider});

  final HomeProvider provider;

  /// Fetches the top stories from the NY Times API.
  ///
  /// Returns a [Future] that completes with a [TopStoriesResponseModel]
  /// containing the top stories data, or an error if the request fails.
  Future<TopStoriesResponseModel> getTopStories() async {
    Response response = await provider.getArticles(Urls.topStories);
    if (response.hasError) {
      if (response.statusCode != null) {
        showSimpleDialog('${response.statusCode ?? ''} ${response.statusText}');
      }
      return TopStoriesResponseModel(status: '${response.statusCode}');
    } else {
      return TopStoriesResponseModel.fromJson(response.body!);
    }
  }

  /// Fetches the most popular articles from the NY Times API.
  ///
  /// The [path] parameter specifies the path for retrieving the most popular articles.
  /// The [period] parameter specifies the time period for the most popular articles.
  /// Returns a [Future] that completes with a [MostPopularResponseModel]
  /// containing the most popular articles data, or an error if the request fails.
  Future<MostPopularResponseModel> getMostPopular(String path, int period) async {
    Response response = await provider.getArticles('$path/$period.json');
    if (response.hasError) {
      if (response.statusCode != null) {
        showSimpleDialog('${response.statusCode ?? ''} ${response.statusText}');
      }
      return MostPopularResponseModel(status: '${response.statusCode}');
    } else {
      return MostPopularResponseModel.fromJson(response.body!);
    }
  }

  /// Searches for articles in the NY Times API.
  ///
  /// The [query] parameter specifies the search query string.
  /// The [page] parameter specifies the page number of the search results.
  /// Returns a [Future] that completes with a [SearchArticleResponseModel]
  /// containing the search results, or an error if the request fails.
  Future<SearchArticleResponseModel> searchArticle(String query, int page) async {
    Response response = await provider.searchArticle(Urls.searchArticle, query, page);
    if (response.hasError) {
      showSimpleDialog('${response.statusCode ?? ''} ${response.statusText}');
      return SearchArticleResponseModel(status: '${response.statusCode}');
    } else {
      return SearchArticleResponseModel.fromJson(response.body!);
    }
  }
}
