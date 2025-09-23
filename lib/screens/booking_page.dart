import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/service_item.dart';
import '../models/order_item.dart';

const Color kColorDarkest = Color(0xFF2B343D);
const Color kColorDark = Color(0xFF3F4E5A);
const Color kColorMid = Color(0xFF586A79);
const Color kColorLight = Color(0xFFA1A4B9);
const Color kColorLightest = Color(0xFFBCC1CE);

class BookingPage extends StatefulWidget {
  final List<ServiceItem> serviceList;
  final Function(OrderItem) onBook;

  const BookingPage({super.key, required this.serviceList, required this.onBook});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  ServiceItem? selectedService;
  String? selectedBarber;
  String? selectedDate;
  String? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorDarkest,
      appBar: AppBar(
        backgroundColor: kColorDark,
        title: Text("Booking", style: GoogleFonts.poppins(color: kColorLightest)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            DropdownButtonFormField<ServiceItem>(
              decoration: InputDecoration(
                labelText: "Pilih Layanan",
                labelStyle: GoogleFonts.poppins(color: kColorLight),
                filled: true,
                fillColor: kColorDark,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              dropdownColor: kColorDark,
              items: widget.serviceList.map((s) => DropdownMenuItem(
                value: s,
                child: Text(s.nama, style: GoogleFonts.poppins(color: kColorLightest)),
              )).toList(),
              onChanged: (s) => setState(() {
                selectedService = s;
                selectedBarber = null;
                selectedDate = null;
                selectedTime = null;
              }),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Pilih Barberman",
                labelStyle: GoogleFonts.poppins(color: kColorLight),
                filled: true,
                fillColor: kColorDark,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              dropdownColor: kColorDark,
              items: ["Aldo", "Rizal", "Budi"].map((b) => DropdownMenuItem(
                value: b,
                child: Text(b, style: GoogleFonts.poppins(color: kColorLightest)),
              )).toList(),
              onChanged: (b) => setState(() => selectedBarber = b),
            ),
            const SizedBox(height: 10),
            TextField(
              style: GoogleFonts.poppins(color: kColorLightest),
              decoration: InputDecoration(
                labelText: "Tanggal (cth: 21 Sept 2025)",
                labelStyle: GoogleFonts.poppins(color: kColorLight),
                filled: true,
                fillColor: kColorDark,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (val) => selectedDate = val,
            ),
            const SizedBox(height: 10),
            TextField(
              style: GoogleFonts.poppins(color: kColorLightest),
              decoration: InputDecoration(
                labelText: "Jam (cth: 14:00)",
                labelStyle: GoogleFonts.poppins(color: kColorLight),
                filled: true,
                fillColor: kColorDark,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (val) => selectedTime = val,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kColorMid,
                foregroundColor: kColorLightest,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                if(selectedService != null && selectedBarber != null && selectedDate != null && selectedTime != null){
                  widget.onBook(OrderItem(
                    service: selectedService!,
                    tanggal: selectedDate!,
                    jam: selectedTime!,
                    barberman: selectedBarber!,
                    status: "Menunggu",
                  ));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Booking berhasil!"))
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Lengkapi data booking!"))
                  );
                }
              },
              child: Text("Konfirmasi Booking", style: GoogleFonts.poppins()),
            )
          ],
        ),
      ),
    );
  }
}
