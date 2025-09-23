import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kColorDarkest = Color(0xFF2B343D);
const Color kColorDark = Color(0xFF3F4E5A);
const Color kColorLight = Color(0xFFA1A4B9);
const Color kColorLightest = Color(0xFFBCC1CE);

class TentangPage extends StatelessWidget {
  const TentangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorDarkest,
      appBar: AppBar(
        backgroundColor: kColorDark,
        title: Text("Tentang", style: GoogleFonts.poppins(color: kColorLightest)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Vanguard Barbershop",
                style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: kColorLight)),
            const SizedBox(height: 10),
            Text("Jl. Coding No. 404, Eror Abadi, Kota Jibitinya Limit, Provinsi Puyeng Parah\nJam buka: 09.00 - 21.00",
                style: GoogleFonts.poppins(color: kColorLightest)),
            const SizedBox(height: 20),
            Text("Kontak & Media Sosial", style: GoogleFonts.poppins(color: kColorLight, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Icon(Icons.chat, color: kColorLight),
                const SizedBox(width: 8),
                Text("WhatsApp: +62 895 1234 4040", style: GoogleFonts.poppins(color: kColorLightest)),
              ],
            ),
            Row(
              children: [
                Icon(Icons.phone, color: kColorLight),
                const SizedBox(width: 8),
                Text("Telepon: +62 895 1234 4040", style: GoogleFonts.poppins(color: kColorLightest)),
              ],
            ),
            Row(
              children: [
                Icon(Icons.camera_alt, color: kColorLight),
                const SizedBox(width: 8),
                Text("Instagram: @vanguardbarber", style: GoogleFonts.poppins(color: kColorLightest)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
