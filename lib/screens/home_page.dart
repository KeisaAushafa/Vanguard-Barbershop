// lib/screens/home_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/palette.dart';
import '../models/customer.dart';
import '../models/service_item.dart';
import '../models/order_item.dart';
import 'login_page.dart';
import 'layanan_page.dart';
import 'booking_page.dart';
import 'riwayat_page.dart';
import 'profil_page.dart';
import 'tentang_page.dart';

class HomePage extends StatefulWidget {
  final String email;
  final String name;
  final String phone;

  const HomePage({super.key, required this.email, required this.name, required this.phone});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Customer currentUser;
  int _selectedMenu = 0;

  final List<ServiceItem> serviceList = [
    ServiceItem(
        kategori: "Premium",
        nama: "Kids Cut",
        harga: 25000,
        diskon: 5,
        durasi: 30,
        subItems: ["Shampoo", "Detangler"],
        barberman: ["Budi"]),
    ServiceItem(
        kategori: "Coloring",
        nama: "Hair Highlight",
        harga: 90000,
        diskon: 20,
        durasi: 70,
        subItems: ["Shampoo", "Conditioner"],
        barberman: ["Aldo"]),
    ServiceItem(
        kategori: "Premium",
        nama: "Full Service",
        harga: 120000,
        diskon: 25,
        durasi: 90,
        subItems: ["Haircut", "Shaving", "Massage", "Vitamin"],
        barberman: ["Aldo", "Rizal"]),
    ServiceItem(
        kategori: "Basic",
        nama: "Quick Cut",
        harga: 20000,
        diskon: 0,
        durasi: 15,
        subItems: ["Shampoo"],
        barberman: ["Rizal"]),
    ServiceItem(
        kategori: "Premium",
        nama: "Facial",
        harga: 60000,
        diskon: 18,
        durasi: 50,
        subItems: ["Mask", "Massage"],
        barberman: ["Budi"]),
    ServiceItem(
        kategori: "Coloring",
        nama: "Balayage",
        harga: 110000,
        diskon: 22,
        durasi: 80,
        subItems: ["Shampoo", "Conditioner", "Vitamin"],
        barberman: ["Aldo", "Budi"]),
    ServiceItem(
        kategori: "Premium",
        nama: "Scalp Treatment",
        harga: 45000,
        diskon: 10,
        durasi: 35,
        subItems: ["Massage", "Serum"],
        barberman: ["Rizal", "Budi"]),
    ServiceItem(
        kategori: "Basic",
        nama: "Beard Coloring",
        harga: 55000,
        diskon: 10,
        durasi: 30,
        subItems: ["Color Mix", "Aftercare"],
        barberman: ["Aldo", "Citra"]),
    ServiceItem(
        kategori: "Premium",
        nama: "Executive Package",
        harga: 180000,
        diskon: 30,
        durasi: 120,
        subItems: ["Haircut", "Facial", "Massage", "Shave"],
        barberman: ["Aldo", "Rizal", "Budi"]),
    ServiceItem(
        kategori: "Basic",
        nama: "Ear Cleaning",
        harga: 15000,
        diskon: 0,
        durasi: 10,
        subItems: [],
        barberman: ["Citra"]),
  ];

  List<OrderItem> activeOrders = [];
  List<ServiceItem> cart = [];

  final List<String> notifications = [
    "Diskon 20% untuk Hair Coloring minggu ini!",
    "Booking Aldo penuh besok, cek jadwal lain.",
    "Promo paket hemat tersedia hingga akhir bulan."
  ];

  @override
  void initState() {
    super.initState();
    currentUser = Customer(widget.name, widget.email, widget.phone);
  }

  void _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Konfirmasi', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        content: Text('Yakin mau logout?', style: GoogleFonts.poppins()),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text('Tidak', style: GoogleFonts.poppins(color: _textSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text('Iya', style: GoogleFonts.poppins(color: Palette.barberRed)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => LoginPage(
            prevName: currentUser.name,
            prevEmail: currentUser.email,
            prevPhone: currentUser.phone,
          ),
        ),
      );
    }
  }

  int get totalHarga {
    int total = 0;
    for (var item in cart) {
      int hargaDiskon = item.harga - ((item.harga * item.diskon) ~/ 100);
      total += hargaDiskon;
    }
    return total;
  }

  BottomNavigationBarItem _navItem(IconData icon, String label) {
    const activeBg = Color(0xFF6E7A83);
    return BottomNavigationBarItem(
      icon: Icon(icon),
      activeIcon: Container(
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          color: activeBg,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white),
      ),
      label: label,
    );
  }

  static const Color _cardPremium = Color(0xFFFDF3E7);
  static const Color _cardColoring = Color(0xFFF4E8FF);
  static const Color _cardBasic = Color(0xFFE8F5FB);

  static const Color _titleOnCard = Color(0xFF1E2C3A); // biru tua kuat
  static const Color _priceOnCard = Color(0xFF111111); // hitam pekat
  static const Color _textSecondary = Color(0xFF2A2A2A); // abu tua agar kontras

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.deepNavy,
      appBar: AppBar(
        backgroundColor: Palette.steelGray,
        title: Text(
          "Vanguard Barbershop",
          style: GoogleFonts.poppins(color: Palette.ivory, fontWeight: FontWeight.w600),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.notifications, color: Palette.silverTint),
            onSelected: (val) {},
            itemBuilder: (context) => notifications
                .map((notif) => PopupMenuItem(
                      value: notif,
                      child: Text(notif, style: GoogleFonts.poppins(fontSize: 12)),
                    ))
                .toList(),
          ),
          IconButton(icon: Icon(Icons.logout, color: Palette.silverTint), onPressed: _logout),
        ],
      ),
      body: _getCurrentTab(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedMenu,
        selectedItemColor: Palette.ivory,
        unselectedItemColor: Palette.coolGray,
        backgroundColor: Palette.steelGray,
        type: BottomNavigationBarType.fixed,
        onTap: (idx) => setState(() => _selectedMenu = idx),
        items: [
          _navItem(Icons.home, "Beranda"),
          _navItem(Icons.content_cut, "Layanan"),
          _navItem(Icons.calendar_month, "Booking"),
          _navItem(Icons.history, "Riwayat"),
          _navItem(Icons.person, "Profil"),
          _navItem(Icons.info_outline, "Tentang"),
        ],
      ),
    );
  }

  Widget _getCurrentTab() {
    switch (_selectedMenu) {
      case 0:
        return _buildHomeTab();
      case 1:
        return LayananPage(
          services: serviceList,
          onAddToCart: (item) => setState(() => cart.add(item)),
          cart: cart,
          onCheckout: () async {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Checkout berhasil!")));
          },
          totalHarga: totalHarga,
        );
      case 2:
        return BookingPage(
          serviceList: serviceList,
          onBook: (order) => setState(() => activeOrders.add(order)),
        );
      case 3:
        return RiwayatPage(orders: activeOrders);
      case 4:
        return ProfilPage(
          name: currentUser.name,
          email: currentUser.email,
          phone: currentUser.phone,
          onLogout: _logout,
        );
      case 5:
        return const TentangPage();
      default:
        return _buildHomeTab();
    }
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Palette.steelGray,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 6, offset: const Offset(0, 3)),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.account_circle, color: Colors.white, size: 44),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Halo, ${currentUser.name} 👋",
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                      Text(currentUser.email,
                          style: GoogleFonts.poppins(fontSize: 13, color: Colors.white70)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // Promo area: cream background to match LayananPage style
          Container(
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
              color: _cardPremium,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8, offset: const Offset(0, 4)),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.local_offer, color: Color(0xFF2B343D), size: 36),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Promo Terbaru",
                        style: GoogleFonts.poppins(
                          color: _titleOnCard,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Diskon spesial & paket hemat 🎉",
                        style: GoogleFonts.poppins(
                          color: _textSecondary,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Lihat Promo Terbaru")));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF586A79),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: const Text("Lihat", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: serviceList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (MediaQuery.of(context).size.width >= 1200)
                  ? 5
                  : (MediaQuery.of(context).size.width >= 800)
                      ? 4
                      : 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.0,
            ),
            itemBuilder: (context, index) {
              final promo = serviceList[index];
              final hargaDiskon = promo.harga - ((promo.harga * promo.diskon) ~/ 100);

              Color bgColor = _cardBasic;
              if (promo.kategori == 'Premium') {
                bgColor = _cardPremium;
              } else if (promo.kategori == 'Coloring') {
                bgColor = _cardColoring;
              }

              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.14), blurRadius: 6, offset: const Offset(0, 4)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Palette.deepNavy.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            promo.kategori,
                            style: TextStyle(
                              color: _textSecondary,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const Spacer(),
                        if (promo.diskon > 0)
                          Text('🎉 ${promo.diskon}%',
                              style: TextStyle(color: Palette.barberRed, fontWeight: FontWeight.bold, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(promo.nama,
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.w700, color: _titleOnCard),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 6),
                    Text('Durasi: ${promo.durasi} menit',
                        style: TextStyle(color: _textSecondary.withOpacity(0.75), fontSize: 11)),
                    const SizedBox(height: 6),
                    Text('Rp $hargaDiskon',
                        style: GoogleFonts.poppins(color: _priceOnCard, fontWeight: FontWeight.w800, fontSize: 13)),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Palette.barberRed,
                            foregroundColor: Palette.barberWhite,
                            minimumSize: const Size(double.infinity, 36),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                        onPressed: () {
                          final now = DateTime.now();
                          const monthNames = [
                            'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                            'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
                          ];
                          final tanggalStr = '${now.day} ${monthNames[now.month - 1]} ${now.year}';
                          final jamStr = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
                          final barber = (promo.barberman.isNotEmpty) ? promo.barberman[0] : 'TBD';

                          setState(() {
                            cart.add(promo);
                            activeOrders.add(OrderItem(
                              service: promo,
                              tanggal: tanggalStr,
                              jam: jamStr,
                              barberman: barber,
                              status: 'Menunggu',
                            ));
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${promo.nama} berhasil dipesan!'),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BookingPage(
                                serviceList: serviceList,
                                onBook: (order) => setState(() => activeOrders.add(order)),
                              ),
                            ),
                          );
                        },
                        child: const Text("Pesan Sekarang", style: TextStyle(fontSize: 12)),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
