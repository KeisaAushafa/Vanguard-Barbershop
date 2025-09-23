import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeTab extends StatelessWidget {
  final String name;
  const HomeTab({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Halo, $name!",
              style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple)),
          const SizedBox(height: 8),
          Text("Selamat datang di aplikasi kami.",
              style: TextStyle(color: Colors.grey.shade600)),
          const SizedBox(height: 20),
          SizedBox(
            height: 140,
            child: PageView(
              children: [
                _promoBanner("Promo: Diskon 15% Hair Coloring!", Colors.amber),
                _promoBanner("Grooming Paket: Gratis Vitamin!", Colors.pinkAccent),
                _promoBanner("5x Potong Gratis 1x!", Colors.deepPurple),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _promoBanner(String text, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF8D6748), width: 2),
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF8D6748)),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
