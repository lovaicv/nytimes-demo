import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nytimes/api/home_respository.dart';
import 'package:nytimes/controllers/connection_controller.dart';
import 'package:nytimes/controllers/location_controller.dart';
import 'package:nytimes/database/articles_db.dart';
import 'package:nytimes/main.dart';
import 'package:nytimes/models/top_stories_response_model.dart';
import 'package:nytimes/pages/landing/landing_page.dart';
import 'package:nytimes/pages/landing/landing_page_controller.dart';
import 'package:nytimes/pages/search/search_page.dart';
import 'package:nytimes/pages/splash/splash_page.dart';
import 'package:nytimes/pages/splash/splash_page_controller.dart';

import 'utils.dart';
import 'widget_test.mocks.dart';

@GenerateMocks([HiveInterface, Box, LocationController, ConnectionController, HomeRepository])
void main() {
  late MockHomeRepository mockHomeRepository;
  late MockConnectionController mockConnectionController;
  late MockLocationController mockLocationController;
  late MockHiveInterface mockHiveInterface;
  late MockBox mockBox;
  late SplashPageController splashPageController;

  setUpAll(() => HttpOverrides.global = null);

  setUp(() async {
    mockHomeRepository = MockHomeRepository();
    mockConnectionController = MockConnectionController();
    mockLocationController = MockLocationController();
    mockHiveInterface = MockHiveInterface();
    mockBox = MockBox();
    splashPageController = SplashPageController();
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

      final String body = await File(testPath('/api/resources/top_stories.json')).readAsString();
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
}
