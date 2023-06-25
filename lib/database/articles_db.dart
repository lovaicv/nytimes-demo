import 'package:hive/hive.dart';

part 'articles_db.g.dart';

abstract class ArticleBoxAbstract {
  addItem(Article article);

  getAllItems();
}

/// database to store every articles fetched from API
/// here we used hive which describe every database as a box
class ArticleBox implements ArticleBoxAbstract {
  final HiveInterface hive;

  ArticleBox({required this.hive});

  static const articlesDB = 'articles_db';

  /// open the article database before we do CRUD operation
  Future<Box> openArticlesBox() async {
    return await hive.openBox(articlesDB);
  }

  /// add single [article] entry to the box
  @override
  Future<int> addItem(Article article) async {
    Box box = await openArticlesBox();
    return await box.add(article);
  }

  /// get all entries in the box
  @override
  Future<List<Article>> getAllItems() async {
    Box box = await openArticlesBox();
    return box.values.map((items) => items as Article).toList();
  }

  /// delete a single entry by it's [key] in the box
  Future<void> deleteItem(int key) async {
    Box box = await openArticlesBox();
    return await box.delete(key);
  }

  /// delete all entries in the box
  Future<int> clearArticles() async {
    Box box = await openArticlesBox();
    return await box.clear();
  }
}

/// The Article class represents an article HiveObject.
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
  String? keywords; // used for offline search
  @HiveField(5)
  String? tag; // top stories, most emailed, most viewed, most shared
  @HiveField(6)
  String? date;

  Article(this.url, this.multimediaUrl, this.title, this.abstract, this.keywords, this.tag, this.date);
}
