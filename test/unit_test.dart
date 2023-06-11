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

import 'unit_test.mocks.dart';

@GenerateMocks([HiveInterface, Box, LocationController, ConnectionController, HomeRepository, HomeProvider])
void main() {
  late MockHomeRepository mockHomeRepository;
  late MockConnectionController mockConnectionController;
  late MockHiveInterface mockHiveInterface;
  late MockBox mockBox;
  late SplashPageController splashPageController;
  late LandingPageController landingPageController;
  late SearchPageController searchPageController;

  setUpAll(() => HttpOverrides.global = null);

  setUp(() async {
    mockHomeRepository = MockHomeRepository();
    mockConnectionController = MockConnectionController();
    mockHiveInterface = MockHiveInterface();
    mockBox = MockBox();
    splashPageController = SplashPageController();
    landingPageController = LandingPageController(
      repository: mockHomeRepository,
      connectionController: mockConnectionController,
      hive: mockHiveInterface,
    );
    searchPageController = SearchPageController(repository: mockHomeRepository);
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

      final String body = await File(_testPath('/api/resources/top_stories.json')).readAsString();
      TopStoriesResponseModel mockResponse = TopStoriesResponseModel.fromJson(jsonDecode(body));
      when(mockHomeRepository.getTopStories()).thenAnswer((_) async => mockResponse);

      Get.put(
          LandingPageController(repository: mockHomeRepository, connectionController: mockConnectionController, hive: mockHiveInterface));

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

    final String body = await File(_testPath('/api/resources/top_stories.json')).readAsString();
    TopStoriesResponseModel mockResponse = TopStoriesResponseModel.fromJson(jsonDecode(body));
    when(mockHomeRepository.getTopStories()).thenAnswer((_) async => mockResponse);

    await landingPageController.getTopStories();

    expect(mockConnectionController.isOffline, false.obs);
    verify(mockHiveInterface.openBox("articles_db"));
    expect(landingPageController.results.length, 23);
  });

  testWidgets('Landing Page offline test', (WidgetTester tester) async {
    await tester.pumpWidget(GetMaterialApp(
      home: const LandingPage(),
      getPages: [
        GetPage(name: '/landing', page: () => const LandingPage()),
      ],
    ));

    when(mockConnectionController.getConnection()).thenAnswer((_) async => Future.value(true));
    when(mockConnectionController.isOffline).thenReturn(true.obs);
    when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockBox);
    when(mockBox.values).thenReturn([Article('url', 'multimediaUrl', 'title', 'abstract')]);

    await landingPageController.getTopStories();
    await tester.pump(const Duration(seconds: 5)); //wait for animation to end

    expect(mockConnectionController.isOffline, true.obs);
    verify(mockHiveInterface.openBox("articles_db"));
    expect(landingPageController.results.length, 1);
  });

  test('Search Page online test', () async {
    final String body = await File(_testPath('/api/resources/article_search.json')).readAsString();
    SearchArticleResponseModel mockResponse = SearchArticleResponseModel.fromJson(jsonDecode(body));
    when(mockHomeRepository.searchArticle('', 0)).thenAnswer((_) async => mockResponse);

    await searchPageController.searchArticle(0);

    expect(searchPageController.docs?.length, 10);
  });
}

String _testPath(String relativePath) {
  final Directory current = Directory.current;
  final String path = current.path.endsWith('/test') ? current.path : current.path + '/test';
  return path + '/' + relativePath;
}
