// lib/screens/home_page.dart 
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    ServiceItem(kategori: "Premium", nama: "Haircut Premium", harga: 50000, diskon: 10, durasi: 45, bisaDatangKerumah: true, subItems: ["Cuci Rambut","Vitamin","Massage"], barberman: ["Aldo","Rizal","Budi"]),
    ServiceItem(kategori: "Basic", nama: "Shaving", harga: 30000, diskon: 5, durasi: 20, subItems: ["After Shave","Steam"], barberman: ["Rizal","Budi"]),
    ServiceItem(kategori: "Coloring", nama: "Hair Coloring", harga: 80000, diskon: 15, durasi: 60, subItems: ["Highlight","Full Color"], barberman: ["Aldo","Budi"]),
  ];

  List<OrderItem> activeOrders = [];
  List<ServiceItem> cart = [];

  @override
  void initState() {
    super.initState();
    currentUser = Customer(widget.name, widget.email, widget.phone);
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
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
    const activeBg = Color(0xFF586A79);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B343D),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3F4E5A), Color(0xFF2B343D)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text("Vanguard Barbershop", style: GoogleFonts.poppins(color: const Color(0xFFBCC1CE))),
        actions: [
          IconButton(icon: const Icon(Icons.notifications, color: Color(0xFFA1A4B9)), onPressed: () {}),
          IconButton(icon: const Icon(Icons.logout, color: Color(0xFFA1A4B9)), onPressed: _logout),
        ],
      ),
      body: _getCurrentTab(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedMenu,
        selectedItemColor: const Color(0xFFBCC1CE),
        unselectedItemColor: const Color(0xFFA1A4B9),
        backgroundColor: const Color(0xFF3F4E5A),
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
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HERO / HEADER dengan gradasi abu terang
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFE0E0E0), Color(0xFFB0B0B0)], // abu terang ke abu medium
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Tampilan Kerenmu Dimulai Di Sini!",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2B343D), // lebih gelap dari latar
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Halo, ${currentUser.name}👋🏻✨",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF3F4E5A),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                currentUser.email,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: const Color(0xFF3F4E5A),
                ),
              ),
            ]),
          ),

          const SizedBox(height: 20),

          // Promo heading dengan warna terang
          Text(
            "Promo Terbaru:",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFE0E0E0),
            ),
          ),
          const SizedBox(height: 10),

          Column(
            children: serviceList.map((promo) => Card(
              color: const Color(0xFFB0B0B0), // card abu terang
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                title: Text(promo.nama, style: const TextStyle(color: Color(0xFF2B343D), fontWeight: FontWeight.w600)),
                subtitle: Text("Diskon ${promo.diskon}%, Estimasi ${promo.durasi} menit", style: const TextStyle(color: Color(0xFF3F4E5A))),
                trailing: IconButton(icon: const Icon(Icons.shopping_cart, color: Color(0xFF2B343D)), onPressed: () => setState(() => cart.add(promo))),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}
