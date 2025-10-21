import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/service_item.dart';
import '../models/order_item.dart';
import '../theme/palette.dart';

List<OrderItem> dummyOrders = [
  // Hari Ini
  OrderItem(
    service: ServiceItem(kategori: 'Basic', nama: 'Haircut', harga: 50000, diskon: 0, durasi: 30),
    tanggal: '2025-10-22',
    jam: '10:00',
    barberman: 'Andi',
    status: '✔ Lunas',
    id: 'B001',
    totalHarga: 50000,
    metodePembayaran: 'Cash',
    catatan: 'Potong tipis',
  ),
  OrderItem(
    service: ServiceItem(kategori: 'Basic', nama: 'Shave', harga: 40000, diskon: 10, durasi: 20),
    tanggal: '2025-10-22',
    jam: '11:00',
    barberman: 'Budi',
    status: '⏳ Belum Dibayar',
    id: 'B002',
    totalHarga: 40000,
    metodePembayaran: 'OVO',
    catatan: 'Shave klasik',
  ),
  OrderItem(
    service: ServiceItem(kategori: 'Premium', nama: 'Haircut + Shave', harga: 90000, diskon: 5, durasi: 50),
    tanggal: '2025-10-22',
    jam: '14:00',
    barberman: 'Citra',
    status: '✔ Lunas',
    id: 'B003',
    totalHarga: 90000,
    metodePembayaran: 'Gopay',
    catatan: 'Potongan samping lebih pendek',
  ),

  OrderItem(
    service: ServiceItem(kategori: 'Basic', nama: 'Haircut', harga: 50000, diskon: 0, durasi: 30),
    tanggal: '2025-10-20',
    jam: '09:30',
    barberman: 'Andi',
    status: '✔ Lunas',
    id: 'B004',
    totalHarga: 50000,
    metodePembayaran: 'Cash',
    catatan: '',
  ),
  OrderItem(
    service: ServiceItem(kategori: 'Basic', nama: 'Shave', harga: 40000, diskon: 0, durasi: 20),
    tanggal: '2025-10-18',
    jam: '16:00',
    barberman: 'Budi',
    status: '❌ Dibatalkan',
    id: 'B005',
    totalHarga: 40000,
    metodePembayaran: 'OVO',
    catatan: 'Tidak datang',
  ),

  OrderItem(
    service: ServiceItem(kategori: 'Basic', nama: 'Haircut', harga: 50000, diskon: 0, durasi: 30),
    tanggal: '2025-10-10',
    jam: '12:00',
    barberman: 'Citra',
    status: '✔ Lunas',
    id: 'B006',
    totalHarga: 50000,
    metodePembayaran: 'Cash',
    catatan: '',
  ),
  OrderItem(
    service: ServiceItem(kategori: 'Basic', nama: 'Shave', harga: 40000, diskon: 0, durasi: 20),
    tanggal: '2025-10-05',
    jam: '14:00',
    barberman: 'Andi',
    status: '⏳ Belum Dibayar',
    id: 'B007',
    totalHarga: 40000,
    metodePembayaran: 'Gopay',
    catatan: '',
  ),

  OrderItem(
    service: ServiceItem(kategori: 'Basic', nama: 'Haircut', harga: 50000, diskon: 0, durasi: 30),
    tanggal: '2025-09-28',
    jam: '10:00',
    barberman: 'Budi',
    status: '✔ Lunas',
    id: 'B008',
    totalHarga: 50000,
    metodePembayaran: 'Cash',
    catatan: '',
  ),
  OrderItem(
    service: ServiceItem(kategori: 'Basic', nama: 'Shave', harga: 40000, diskon: 0, durasi: 20),
    tanggal: '2025-09-15',
    jam: '15:00',
    barberman: 'Citra',
    status: '❌ Dibatalkan',
    id: 'B009',
    totalHarga: 40000,
    metodePembayaran: 'OVO',
    catatan: '',
  ),
  OrderItem(
    service: ServiceItem(kategori: 'Premium', nama: 'Haircut + Shave', harga: 90000, diskon: 5, durasi: 50),
    tanggal: '2025-09-10',
    jam: '13:00',
    barberman: 'Andi',
    status: '✔ Lunas',
    id: 'B010',
    totalHarga: 90000,
    metodePembayaran: 'Gopay',
    catatan: '',
  ),
];

class RiwayatPage extends StatefulWidget {
  final List<OrderItem> orders;
  const RiwayatPage({super.key, required this.orders});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  String filter = "Semua";

  @override
  Widget build(BuildContext context) {
    final sourceOrders = (widget.orders.isNotEmpty) ? widget.orders : dummyOrders;
    final filteredOrders = _applyFilter(sourceOrders);

    return Scaffold(
      backgroundColor: Palette.deepNavy,
      appBar: AppBar(
        backgroundColor: Palette.steelGray,
        title: Text("Riwayat Pesanan",
            style: GoogleFonts.poppins(color: Palette.ivory)),
        actions: [
          PopupMenuButton<String>(
            color: Palette.steelGray,
            icon: Icon(Icons.filter_list, color: Palette.ivory),
            onSelected: (val) => setState(() => filter = val),
            itemBuilder: (context) => [
              "Hari Ini",
              "Minggu Ini",
              "Bulan Ini",
              "Semua"
            ]
                .map((f) => PopupMenuItem(
                      value: f,
                      child: Text(f,
                          style: GoogleFonts.poppins(color: Palette.ivory)),
                    ))
                .toList(),
          ),
        ],
      ),
      body: filteredOrders.isEmpty
          ? Center(
              child: Text("Belum ada riwayat pesanan.",
                  style: GoogleFonts.poppins(color: Palette.coolGray)))
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: filteredOrders.length,
              itemBuilder: (context, idx) {
                final order = filteredOrders[idx];
                return Card(
                  color: Palette.steelGray,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _statusColor(order.status),
                      child: _statusIcon(order.status),
                    ),
                    title: Text(order.service.nama,
                        style: GoogleFonts.poppins(
                            color: Palette.ivory,
                            fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        "Tanggal: ${order.tanggal}\nJam: ${order.jam}\nBarber: ${order.barberman}\nStatus: ${order.status}\nTotal: Rp${order.totalHarga}",
                        style: GoogleFonts.poppins(color: Palette.coolGray)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RiwayatDetailPage(order: order),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }

  List<OrderItem> _applyFilter(List<OrderItem> orders) {
    final now = DateTime.now();
    if (filter == "Hari Ini") {
      return orders.where((o) {
        try {
          final t = DateTime.parse(o.tanggal);
          return t.year == now.year && t.month == now.month && t.day == now.day;
        } catch (e) {
          return false;
        }
      }).toList();
    } else if (filter == "Minggu Ini") {
      final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
      final endOfWeek = startOfWeek.add(const Duration(days: 6));
      return orders.where((o) {
        try {
          final t = DateTime.parse(o.tanggal);
          return !t.isBefore(startOfWeek) && !t.isAfter(endOfWeek);
        } catch (e) {
          return false;
        }
      }).toList();
    } else if (filter == "Bulan Ini") {
      return orders.where((o) {
        try {
          final t = DateTime.parse(o.tanggal);
          return t.month == now.month && t.year == now.year;
        } catch (e) {
          return false;
        }
      }).toList();
    }
    return orders;
  }

  Color _statusColor(String status) {
    if (status.contains("✔")) return Colors.green;
    if (status.contains("⏳")) return Colors.orange;
    if (status.contains("❌")) return Colors.red;
    return Colors.grey;
  }

  // === Ikon status ===
  Icon _statusIcon(String status) {
    if (status.contains("✔")) return const Icon(Icons.check, color: Colors.white);
    if (status.contains("⏳")) return const Icon(Icons.hourglass_bottom, color: Colors.white);
    if (status.contains("❌")) return const Icon(Icons.close, color: Colors.white);
    return const Icon(Icons.help, color: Colors.white);
  }
}

class RiwayatDetailPage extends StatelessWidget {
  final OrderItem order;
  const RiwayatDetailPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.deepNavy,
      appBar: AppBar(
        backgroundColor: Palette.steelGray,
        title: Text("Detail Transaksi",
            style: GoogleFonts.poppins(color: Palette.ivory)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            _buildDetail("Booking ID", order.id),
            _buildDetail("Layanan", order.service.nama),
            _buildDetail("Tanggal", order.tanggal),
            _buildDetail("Jam", order.jam),
            _buildDetail("Durasi", "${order.service.durasi} menit"),
            _buildDetail("Barberman", order.barberman),
            _buildDetail("Status", order.status),
            _buildDetail("Total Harga", "Rp${order.totalHarga}"),
            _buildDetail("Diskon", "${order.service.diskon}%"),
            _buildDetail("Metode Pembayaran", order.metodePembayaran),
            _buildDetail("Catatan", order.catatan),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Palette.classicBlue,
                  minimumSize: const Size(double.infinity, 50)),
              icon: const Icon(Icons.repeat),
              label: const Text("Pesan Ulang"),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Repeat booking berhasil ditambahkan")));
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Palette.barberRed,
                  minimumSize: const Size(double.infinity, 50)),
              icon: const Icon(Icons.star_rate),
              label: const Text("Beri Review"),
              onPressed: () {
                _showReviewDialog(context);
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Palette.classicBlue,
                  minimumSize: const Size(double.infinity, 50)),
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text("Download Struk"),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Struk berhasil diunduh (simulasi)")));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$label: ",
              style: GoogleFonts.poppins(
                  color: Palette.ivory, fontWeight: FontWeight.w600)),
          Expanded(
            child: Text(value,
                style: GoogleFonts.poppins(color: Palette.ivory)),
          ),
        ],
      ),
    );
  }

  void _showReviewDialog(BuildContext context) {
    double rating = 0;
    final controller = TextEditingController();

    showDialog(
      context: context,
    builder: (ctx) => AlertDialog(
    backgroundColor: Palette.steelGray,
    title: Text("Beri Review",
      style: GoogleFonts.poppins(color: Palette.ivory)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StatefulBuilder(
              builder: (context, setState) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (i) {
                    return IconButton(
                      icon: Icon(
                        i < rating ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                      ),
                      onPressed: () => setState(() => rating = i + 1.0),
                    );
                  }),
                );
              },
            ),
            TextField(
              controller: controller,
              style: GoogleFonts.poppins(color: Palette.ivory),
              decoration: InputDecoration(
                hintText: "Tulis komentar...",
                hintStyle: GoogleFonts.poppins(color: Palette.coolGray),
                filled: true,
                fillColor: Palette.deepNavy,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
        child: Text("Batal",
          style: GoogleFonts.poppins(color: Palette.coolGray))),
          TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "Review terkirim: $rating bintang, '${controller.text}'")));
              },
                  child: Text("Kirim",
                      style: GoogleFonts.poppins(color: Colors.amber))),
        ],
      ),
    );
  }
}

// ==================== MAIN ====================
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RiwayatPage(orders: dummyOrders),
  ));
}
