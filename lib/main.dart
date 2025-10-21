import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'services/app_settings.dart';
import 'models/person.dart';
import 'theme/palette.dart';

void main() {

  var person = Person("Andi", "andi@mail.com", "08123456789");
  var customer = Customer("Siti", "siti@mail.com", "0822334455");
  var employee = Employee("Budi", "budi@mail.com", "08987654321", "Kasir");

  print(person);
  print(customer);
  print(employee);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color darkest = Color(0xFF2B343D);
  static const Color dark = Color(0xFF3F4E5A);
  static const Color medium = Color(0xFF586A79);
  static const Color light = Color(0xFFA1A4B9);
  static const Color lighter = Color(0xFFBCC1CE);

  // very small i18n map used across the app
  static const Map<String, Map<String, String>> localized = {
    'id': {
      'title': 'Vanguard Barbershop',
      'splash': 'Selamat Datang',
    },
    'en': {
      'title': 'Vanguard Barbershop',
      'splash': 'Welcome',
    }
  };

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: AppSettings.themeMode,
      builder: (context, themeMode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: localized[AppSettings.language.value]!['title']!,
          themeMode: themeMode,
          theme: Palette.lightTheme,
          darkTheme: Palette.darkTheme,
          home: const SplashScreen(),
        );
      },
    );
  }
}
