import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:nytimes/models/top_stories_response_model.dart';

part 'articles_db.g.dart';

abstract class ArticleBoxAbstract {
  addItems(RxList<Results> results);

  getAllItems();
}

class ArticleBox implements ArticleBoxAbstract {
  final HiveInterface hive;

  ArticleBox({required this.hive});

  static const articlesDB = 'articles_db';

  Future<Box> openArticlesBox() async {
    return await hive.openBox(articlesDB);
  }

  // Box getArticleBox() {
  //   return Hive.box(articlesDB);
  // }

  @override
  addItems(RxList<Results> results) async {
    await clearArticles();
    Box box = await openArticlesBox();
    results
        .asMap()
        .forEach((index, element) => box.put(index, Article(element.url, element.multimedia?[1].url, element.title, element.abstract)));
  }

  @override
  Future<List<Article>> getAllItems() async {
    Box box = await openArticlesBox();
    return box.values.map((items) => items as Article).toList();
  }

  Future<Article> getItemFromLandingCategory(key) async {
    Box box = await openArticlesBox();
    return box.get(key);
  }

  Future<void> deleteItem(int key) async {
    Box box = await openArticlesBox();
    return await box.delete(key);
  }

  Future<int> clearArticles() async {
    Box box = await openArticlesBox();
    return await box.clear();
  }
}

@HiveType(typeId: 0)
class Article extends HiveObject {
  @HiveField(0)
  String? url;
  @HiveField(1)
  String? multimediaUrl;
  @HiveField(2)
  String? title;
  @HiveField(3)
  String? abstract;

  Article(this.url, this.multimediaUrl, this.title, this.abstract);
}
