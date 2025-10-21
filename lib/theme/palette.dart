import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Palette {
  // Core colors
  static const Color deepNavy = Color(0xFF243447); // Deep Navy Blue
  static const Color barberRed = Color(0xFFB22E2E); // Barber Red
  static const Color steelGray = Color(0xFF4B4B4B); // Steel Gray
  static const Color ivory = Color(0xFFF5F5F5); // Ivory White
  static const Color classicBlue = Color(0xFF2E5EAA); // Classic Blue

  // Supporting accents
  static const Color poleRed = Color(0xFFD94141); // Barber Pole Red
  static const Color barberWhite = Color(0xFFFFFFFF); // Barber White
  static const Color coolGray = Color(0xFFA6A6A6); // Cool Gray
  static const Color slateBlack = Color(0xFF1A1A1A); // Slate Black
  static const Color silverTint = Color(0xFFD9D9D9); // Silver Tint

  /// Light theme using Ivory White base
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: ivory,
    primaryColor: barberRed,
    colorScheme: ColorScheme.light(
      primary: barberRed,
      secondary: classicBlue,
      background: ivory,
      onBackground: steelGray,
      onPrimary: barberWhite,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: ivory,
      foregroundColor: steelGray,
      titleTextStyle: GoogleFonts.poppins(color: steelGray, fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: const IconThemeData(color: steelGray),
    ),
    textTheme: GoogleFonts.poppinsTextTheme().apply(bodyColor: steelGray, displayColor: steelGray),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: barberRed, foregroundColor: barberWhite),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: barberRed),
  );

  /// Dark theme using Deep Navy Blue base
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: deepNavy,
    primaryColor: classicBlue,
    colorScheme: ColorScheme.dark(
      primary: classicBlue,
      secondary: barberRed,
      background: deepNavy,
      onBackground: ivory,
      onPrimary: ivory,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: steelGray,
      foregroundColor: ivory,
      titleTextStyle: GoogleFonts.poppins(color: ivory, fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: const IconThemeData(color: ivory),
    ),
    textTheme: GoogleFonts.poppinsTextTheme().apply(bodyColor: ivory, displayColor: ivory),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: barberRed, foregroundColor: ivory),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: classicBlue),
  );
}
