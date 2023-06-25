import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nytimes/api/home_api_provider.dart';
import 'package:nytimes/api/home_respository.dart';
import 'package:nytimes/controllers/connection_controller.dart';
import 'package:nytimes/controllers/location_controller.dart';
import 'package:nytimes/database/articles_db.dart';
import 'package:nytimes/main.dart';
import 'package:nytimes/models/search_article_response_model.dart';
import 'package:nytimes/models/top_stories_response_model.dart';
import 'package:nytimes/pages/landing/landing_page.dart';
import 'package:nytimes/pages/landing/landing_page_controller.dart';
import 'package:nytimes/pages/search/search_page.dart';
import 'package:nytimes/pages/search/search_page_controller.dart';
import 'package:nytimes/pages/splash/splash_page.dart';
import 'package:nytimes/pages/splash/splash_page_controller.dart';
import 'package:nytimes/utils/utils.dart';

import 'unit_test.mocks.dart';

@GenerateMocks([HiveInterface, Box, LocationController, ConnectionController, HomeRepository, HomeProvider, SearchPageController])
void main() {
  late MockHomeRepository mockHomeRepository;
  late MockConnectionController mockConnectionController;
  late MockLocationController mockLocationController;
  late MockHiveInterface mockHiveInterface;
  late MockBox mockBox;
  late SplashPageController splashPageController;
  late LandingPageController landingPageController;
  late SearchPageController searchPageController;
  late MockSearchPageController mockSearchPageController;

  setUpAll(() => HttpOverrides.global = null);

  setUp(() async {
    mockHomeRepository = MockHomeRepository();
    mockConnectionController = MockConnectionController();
    mockLocationController = MockLocationController();
    mockHiveInterface = MockHiveInterface();
    mockBox = MockBox();
    splashPageController = SplashPageController();
    landingPageController = LandingPageController(
      repository: mockHomeRepository,
      connectionController: mockConnectionController,
      locationController: mockLocationController,
      hive: mockHiveInterface,
    );
    searchPageController = SearchPageController(
      repository: mockHomeRepository,
      connectionController: mockConnectionController,
      hive: mockHiveInterface,
    );
    mockSearchPageController = MockSearchPageController();
  });

  testWidgets('Splash Page navigation test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(SplashPage), findsOneWidget);
    expect(find.image(const AssetImage('assets/images/splash.png')), findsOneWidget);

    await splashPageController.countDown();

    await tester.runAsync(() async {
      await tester.pump(const Duration(seconds: 2));
      expect(find.byType(LandingPage), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });
  });

  testWidgets('Landing Page navigation test', (WidgetTester tester) async {
    await tester.runAsync(() async {
      when(mockConnectionController.getConnection()).thenAnswer((_) async => Future.value(false));
      when(mockConnectionController.isOffline).thenReturn(false.obs);
      when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockBox);
      when(mockBox.clear()).thenAnswer((_) async => 0);
      when(mockBox.values).thenReturn([Article('url', 'multimediaUrl', 'title', 'abstract', 'keywords', 'tag', '1 Jan 2023')]);
      when(mockBox.add(any)).thenAnswer((_) => Future.value(1));

      final String body = await File(_testPath('/api/resources/top_stories.json')).readAsString();
      TopStoriesResponseModel mockResponse = TopStoriesResponseModel.fromJson(jsonDecode(body));
      when(mockHomeRepository.getTopStories()).thenAnswer((_) async => mockResponse);

      Get.put(LandingPageController(
          repository: mockHomeRepository,
          locationController: mockLocationController,
          connectionController: mockConnectionController,
          hive: mockHiveInterface));

      await tester.pumpWidget(GetMaterialApp(
        home: const LandingPage(),
        getPages: [
          GetPage(name: '/landing', page: () => const LandingPage()),
          GetPage(name: '/search', page: () => const SearchPage()),
        ],
      ));

      expect(find.byType(FloatingActionButton), findsOneWidget);

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.byType(SearchPage), findsOneWidget);
    });
  });

  test('Landing Page online test', () async {
    when(mockConnectionController.getConnection()).thenAnswer((_) async => Future.value(false));
    when(mockConnectionController.isOffline).thenReturn(false.obs);
    when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockBox);
    when(mockBox.clear()).thenAnswer((_) async => 0);
    when(mockBox.add(any)).thenAnswer((_) => Future.value(1));

    final String body = await File(_testPath('/api/resources/top_stories.json')).readAsString();
    TopStoriesResponseModel mockResponse = TopStoriesResponseModel.fromJson(jsonDecode(body));
    when(mockHomeRepository.getTopStories()).thenAnswer((_) async => mockResponse);
    when(mockBox.values).thenReturn([
      Article('url', 'multimediaUrl', 'title', 'abstract', 'keywords', 'Top Stories', '1 Jan 2023'),
    ]);

    await landingPageController.getTopStories(1);

    expect(mockConnectionController.isOffline, false.obs);
    verify(mockHiveInterface.openBox("articles_db"));
    expect(landingPageController.results.length, 1);
  });

  test('Landing Page offline test', () async {
    when(mockConnectionController.getConnection()).thenAnswer((_) async => Future.value(true));
    when(mockConnectionController.isOffline).thenReturn(true.obs);
    when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockBox);
    when(mockBox.values).thenReturn([Article('url', 'multimediaUrl', 'title', 'abstract', 'keywords', 'Top Stories', '1 Jan 2023')]);

    await landingPageController.getTopStories(1);
    // await tester.pump(const Duration(seconds: 5)); //wait for animation to end

    expect(mockConnectionController.isOffline, true.obs);
    verify(mockHiveInterface.openBox("articles_db"));
    expect(landingPageController.results.length, 1);
  });

  test('Search Page online searchArticle method test', () async {
    when(mockConnectionController.getConnection()).thenAnswer((_) async => Future.value(false));
    when(mockHomeRepository.searchArticle(any, any))
        .thenAnswer((_) async => SearchArticleResponseModel(status: 'OK', response: SearchArticleResponse(docs: [])));
    searchPageController.searchText = 'election';
    await searchPageController.searchArticle(0);
    verify(mockHomeRepository.searchArticle(any, any)).called(1);
  });

  test('Search Page offline searchArticle method test', () async {
    when(mockConnectionController.getConnection()).thenAnswer((_) async => Future.value(true));
    when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockBox);
    when(mockBox.values).thenReturn([]);
    searchPageController.searchText = 'election';
    await searchPageController.searchArticle(0);
    verifyNever(mockHomeRepository.searchArticle(any, any));
  });

  test('Search Page online test', () async {
    when(mockConnectionController.getConnection()).thenAnswer((_) async => Future.value(false));
    when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockBox);
    when(mockBox.values).thenReturn([Article('url', 'multimediaUrl', 'title', 'abstract', 'election', 'Search', '2023-01-01')]);
    when(mockBox.add(any)).thenAnswer((_) async => 1);

    final String body = await File(_testPath('/api/resources/article_search.json')).readAsString();
    SearchArticleResponseModel mockResponse = SearchArticleResponseModel.fromJson(jsonDecode(body));
    when(mockHomeRepository.searchArticle('election', 0)).thenAnswer((_) async => mockResponse);

    searchPageController.searchText = 'election';
    await searchPageController.searchArticleApi(0);

    verify(mockHiveInterface.openBox("articles_db"));
    expect(searchPageController.isListEmpty.value, false);
    expect(searchPageController.results.length, 10);
    expect(searchPageController.pagingController.value.itemList?.length, 10);
  });

  test('Search Page offline test', () async {
    when(mockConnectionController.getConnection()).thenAnswer((_) async => Future.value(true));
    when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockBox);
    when(mockBox.values).thenReturn([Article('url', 'multimediaUrl', 'title', 'abstract', 'election', 'Search', '2023-01-01')]);

    final String body = await File(_testPath('/api/resources/article_search.json')).readAsString();
    SearchArticleResponseModel mockResponse = SearchArticleResponseModel.fromJson(jsonDecode(body));
    showLog('mockResponse $mockResponse');
    when(mockHomeRepository.searchArticle('election', 0)).thenAnswer((_) async => mockResponse);

    searchPageController.searchText = 'election';
    await searchPageController.searchArticleLocal(0);

    verify(mockHiveInterface.openBox("articles_db"));
    expect(searchPageController.isListEmpty.value, false);
    expect(searchPageController.results.length, 1);
    expect(searchPageController.pagingController.value.itemList?.length, 1);
  });
}

String _testPath(String relativePath) {
  final Directory current = Directory.current;
  final String path = current.path.endsWith('/test') ? current.path : current.path + '/test';
  return path + '/' + relativePath;
}
