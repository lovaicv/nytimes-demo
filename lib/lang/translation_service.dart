import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nytimes/lang/en_US.dart';

/// this class responsible for providing translations for the application.
class TranslationService extends Translations {
  static Locale? get locale => Get.deviceLocale;
  static const fallbackLocale = Locale('en', 'US');

  /// supported languages are listed below
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en_US,
      };
}
