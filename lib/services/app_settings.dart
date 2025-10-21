import 'package:flutter/material.dart';

/// Central app settings used for simple global state (theme + language)
class AppSettings {
  static final ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.dark);
  // language code: 'id' or 'en'
  static final ValueNotifier<String> language = ValueNotifier('id');

  static void toggleTheme() {
    themeMode.value = themeMode.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }

  static void setLanguage(String code) {
    language.value = code;
  }
}
