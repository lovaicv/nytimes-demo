import 'package:get/get_connect/http/src/response/response.dart';
import 'package:nytimes/api/home_api_provider.dart';
import 'package:nytimes/api/urls.dart';
import 'package:nytimes/core/my_dialog.dart';
import 'package:nytimes/models/most_popular_response_model.dart';
import 'package:nytimes/models/search_article_response_model.dart';
import 'package:nytimes/models/top_stories_response_model.dart';

class HomeRepository {
  HomeRepository({required this.provider});

  final HomeProvider provider;

  Future<TopStoriesResponseModel> getTopStories() async {
    Response response = await provider.getTopStories(Urls.topStories);
    if (response.hasError) {
      if (response.statusCode != null) {
        showSimpleDialog('${response.statusCode ?? ''} ${response.statusText}');
      }
      return TopStoriesResponseModel(status: '${response.statusCode}');
    } else {
      return TopStoriesResponseModel.fromJson(response.body!);
    }
  }

  Future<MostPopularResponseModel> getMostPopular(String path, int period) async {
    Response response = await provider.getMostPopular('$path/$period.json');
    if (response.hasError) {
      if (response.statusCode != null) {
        showSimpleDialog('${response.statusCode ?? ''} ${response.statusText}');
      }
      return MostPopularResponseModel(status: '${response.statusCode}');
    } else {
      return MostPopularResponseModel.fromJson(response.body!);
    }
  }

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
