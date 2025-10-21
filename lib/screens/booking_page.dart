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
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

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

            // Pilih Layanan
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
              }),
            ),
            const SizedBox(height: 10),

            // Pilih Barberman
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

            // Pilih Tanggal (DatePicker)
            TextField(
              readOnly: true,
              controller: TextEditingController(
                  text: selectedDate != null
                      ? "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}"
                      : ""),
              style: GoogleFonts.poppins(color: kColorLightest),
              decoration: InputDecoration(
                labelText: "Tanggal",
                labelStyle: GoogleFonts.poppins(color: kColorLight),
                filled: true,
                fillColor: kColorDark,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today, color: Colors.white),
                  onPressed: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                      builder: (context, child) => Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: Color(0xFF586A79),
                            onPrimary: Colors.white,
                            onSurface: Colors.black,
                          ),
                        ),
                        child: child!,
                      ),
                    );
                    if (picked != null) setState(() => selectedDate = picked);
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Pilih Jam (TimePicker)
            TextField(
              readOnly: true,
              controller: TextEditingController(
                  text: selectedTime != null ? selectedTime!.format(context) : ""),
              style: GoogleFonts.poppins(color: kColorLightest),
              decoration: InputDecoration(
                labelText: "Jam",
                labelStyle: GoogleFonts.poppins(color: kColorLight),
                filled: true,
                fillColor: kColorDark,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.access_time, color: Colors.white),
                  onPressed: () async {
                    TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (picked != null) setState(() => selectedTime = picked);
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Tombol Konfirmasi Booking
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kColorMid,
                foregroundColor: kColorLightest,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                if (selectedService != null &&
                    selectedBarber != null &&
                    selectedDate != null &&
                    selectedTime != null) {
                  
                  widget.onBook(OrderItem(
                    service: selectedService!,
                    tanggal:
                        "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
                    jam: selectedTime!.format(context),
                    barberman: selectedBarber!,
                    status: "⏳ Menunggu",
                  ));

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Booking berhasil!")),
                  );
                
                  setState(() {
                    selectedService = null;
                    selectedBarber = null;
                    selectedDate = null;
                    selectedTime = null;
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Lengkapi semua data booking!")),
                  );
                }
              },
              child: Text("Konfirmasi Booking", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}
