import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/splash_screen.dart';
import 'models/person.dart' hide Employee;
import 'models/customer.dart' hide Customer;
import 'models/employee.dart';

void main() {
  // ===== Contoh penggunaan OOP Person / Customer / Employee =====
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

  @override
  Widget build(BuildContext context) {
    // 🎨 Palet warna lama tetap dipakai
    const darkest = Color(0xFF2B343D);
    const dark = Color(0xFF3F4E5A);
    const medium = Color(0xFF586A79);
    const light = Color(0xFFA1A4B9);
    const lighter = Color(0xFFBCC1CE);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Vanguard Barbershop",
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: darkest,
        primaryColor: medium,
        appBarTheme: AppBarTheme(
          backgroundColor: dark,
          foregroundColor: lighter,
          titleTextStyle: GoogleFonts.poppins(
            color: lighter,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: const IconThemeData(color: lighter),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: dark,
          selectedItemColor: lighter,
          unselectedItemColor: light,
        ),
        textTheme: GoogleFonts.poppinsTextTheme().apply(
          bodyColor: lighter,
          displayColor: lighter,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: medium,
            foregroundColor: lighter,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: dark,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          labelStyle: TextStyle(color: light),
          hintStyle: TextStyle(color: light),
        ),
      ),

      // ✅ SplashScreen baru tetap dipanggil di awal
      home: const SplashScreen(),
    );
  }
}
