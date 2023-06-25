import 'package:hive/hive.dart';

part 'articles_db.g.dart';

abstract class ArticleBoxAbstract {
  addItem(Article article);

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
  Future<int> addItem(Article article) async {
    Box box = await openArticlesBox();
    return await box.add(article);
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
  @HiveField(4)
  String? keywords; //used for offline search
  @HiveField(5)
  String? tag; //top stories, most emailed, most viewed, most shared
  @HiveField(6)
  String? date;

  Article(this.url, this.multimediaUrl, this.title, this.abstract, this.keywords, this.tag, this.date);
}
