import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/order_item.dart';

const Color kColorDarkest = Color(0xFF2B343D);
const Color kColorDark = Color(0xFF3F4E5A);
const Color kColorLight = Color(0xFFA1A4B9);
const Color kColorLightest = Color(0xFFBCC1CE);

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
    final filteredOrders = _applyFilter(widget.orders);

    return Scaffold(
      backgroundColor: kColorDarkest,
      appBar: AppBar(
        backgroundColor: kColorDark,
        title: Text("Riwayat Pesanan",
            style: GoogleFonts.poppins(color: kColorLightest)),
        actions: [
          PopupMenuButton<String>(
            color: kColorDark,
            icon: const Icon(Icons.filter_list, color: Colors.white),
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
                          style: GoogleFonts.poppins(color: kColorLightest)),
                    ))
                .toList(),
          ),
        ],
      ),
      body: filteredOrders.isEmpty
          ? Center(
              child: Text("Belum ada riwayat pesanan.",
                  style: GoogleFonts.poppins(color: kColorLight)))
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: filteredOrders.length,
              itemBuilder: (context, idx) {
                final order = filteredOrders[idx];
                return Card(
                  color: kColorDark,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _statusColor(order.status),
                      child: _statusIcon(order.status),
                    ),
                    title: Text(order.service.nama,
                        style: GoogleFonts.poppins(
                            color: kColorLightest,
                            fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        "Tanggal: ${order.tanggal}\nJam: ${order.jam}\nBarber: ${order.barberman}\nStatus: ${order.status}\nTotal: Rp${order.totalHarga}",
                        style: GoogleFonts.poppins(color: kColorLight)),
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

  // === Filter logic ===
  List<OrderItem> _applyFilter(List<OrderItem> orders) {
    if (filter == "Semua") return orders;
    // sementara: contoh filter dummy
    return orders.where((o) => o.status != "❌ Dibatalkan").toList();
  }

  // === Warna status ===
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

// ==================== Detail Transaksi ====================
class RiwayatDetailPage extends StatelessWidget {
  final OrderItem order;
  const RiwayatDetailPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorDarkest,
      appBar: AppBar(
        backgroundColor: kColorDark,
        title: Text("Detail Transaksi",
            style: GoogleFonts.poppins(color: kColorLightest)),
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
                  backgroundColor: Colors.green,
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
                  backgroundColor: Colors.amber,
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
                  backgroundColor: Colors.blue,
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
                  color: kColorLightest, fontWeight: FontWeight.w600)),
          Expanded(
            child: Text(value,
                style: GoogleFonts.poppins(color: kColorLightest)),
          ),
        ],
      ),
    );
  }

  // === Dialog Review ===
  void _showReviewDialog(BuildContext context) {
    double rating = 0;
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: kColorDark,
        title: Text("Beri Review",
            style: GoogleFonts.poppins(color: kColorLightest)),
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
              style: GoogleFonts.poppins(color: kColorLightest),
              decoration: InputDecoration(
                hintText: "Tulis komentar...",
                hintStyle: GoogleFonts.poppins(color: kColorLight),
                filled: true,
                fillColor: kColorDarkest,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text("Batal",
                  style: GoogleFonts.poppins(color: kColorLight))),
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
