// import 'package:get/get.dart';
// import 'package:hive/hive.dart';
// import 'package:nytimes/api/urls.dart';
// import 'package:nytimes/models/top_stories_response_model.dart';
//
// part 'articles_db.g.dart';
//
// const articlesDB = 'articles_db';
// const latest = 'latest';
//
// Future<Box> openArticlesBox() async {
//   return await Hive.openBox(articlesDB);
// }
//
// Box getLandingCategoryBox() {
//   return Hive.box(articlesDB);
// }
//
// addItem(RxList<Results> results) async {
//   await clearLandingCategory();
//   Box box = getLandingCategoryBox();
//   results
//       .asMap()
//       .forEach((index, element) => box.put(index, Article(element.url, element.multimedia?[1].url, element.title, element.abstract)));
// }
//
// List<Article> getLandingCategoryFromDB() {
//   return getLandingCategoryBox().values.map((items) => items as Article).toList();
// }
//
// getItemFromLandingCategory(key) {
//   return getLandingCategoryBox().get(key);
// }
//
// // deleteItem(int key) {
// //   getLandingCategoryBox().delete(key);
// // }
//
// clearLandingCategory() async {
//   await getLandingCategoryBox().clear();
// }
//
// @HiveType(typeId: 0)
// class Article extends HiveObject {
//   @HiveField(0)
//   String? url;
//   @HiveField(1)
//   String? multimediaUrl;
//   @HiveField(2)
//   String? title;
//   @HiveField(3)
//   String? abstract;
//
//   Article(this.url, this.multimediaUrl, this.title, this.abstract);
// }
