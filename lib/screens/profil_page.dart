import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kColorDarkest = Color(0xFF2B343D);
const Color kColorMid = Color(0xFF586A79);
const Color kColorLightest = Color(0xFFBCC1CE);

class ProfilPage extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final VoidCallback onLogout;

  const ProfilPage({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorDarkest,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Foto profil
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: kColorMid,
                  child: Text(
                    name.isNotEmpty ? name.substring(0, 1) : "?",
                    style: GoogleFonts.poppins(
                        fontSize: 40,
                        color: kColorLightest,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: kColorLightest,
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt, size: 18),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Ganti foto profil coming soon!")),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Identitas
          Text("Nama: $name",
              style: GoogleFonts.poppins(fontSize: 16, color: kColorLightest)),
          Text("Email: $email",
              style: GoogleFonts.poppins(fontSize: 16, color: kColorLightest)),
          Text("No HP: $phone",
              style: GoogleFonts.poppins(fontSize: 16, color: kColorLightest)),
          Text("Alamat: Belum diatur",
              style: GoogleFonts.poppins(fontSize: 16, color: kColorLightest)),
          Text("Tanggal Lahir: -",
              style: GoogleFonts.poppins(fontSize: 16, color: kColorLightest)),
          Text("Gender: -",
              style: GoogleFonts.poppins(fontSize: 16, color: kColorLightest)),

          const SizedBox(height: 20),

          // Tombol edit profil
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                backgroundColor: kColorMid,
                foregroundColor: kColorLightest,
                minimumSize: const Size(double.infinity, 50)),
            icon: const Icon(Icons.edit),
            label: Text("Edit Profil", style: GoogleFonts.poppins()),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Edit profil coming soon!")));
            },
          ),
          const SizedBox(height: 10),

          // =================== Membership / Poin ===================
          sectionTitle("Membership & Poin"),
          ListTile(
            leading: const Icon(Icons.stars, color: Colors.amber),
            title: Text("Level: Gold Member",
                style: GoogleFonts.poppins(color: kColorLightest)),
            subtitle: Text("Poin: 1200",
                style: GoogleFonts.poppins(color: kColorLightest)),
          ),

          // =================== Voucher ===================
          sectionTitle("Voucher & Kupon"),
          ListTile(
            leading: const Icon(Icons.card_giftcard, color: Colors.pinkAccent),
            title: Text("Voucher Diskon 20%",
                style: GoogleFonts.poppins(color: kColorLightest)),
            subtitle: Text("Berlaku sampai 30 Sept 2025",
                style: GoogleFonts.poppins(color: kColorLightest)),
          ),

          // =================== Metode Pembayaran ===================
          sectionTitle("Metode Pembayaran"),
          ListTile(
            leading: const Icon(Icons.wallet, color: Colors.lightBlue),
            title: Text("Dana - 08xxxx"),
            subtitle: Text("E-wallet tersimpan",
                style: GoogleFonts.poppins(color: kColorLightest)),
          ),
          ListTile(
            leading: const Icon(Icons.credit_card, color: Colors.green),
            title: Text("Visa **** 1234"),
            subtitle: Text("Kartu debit",
                style: GoogleFonts.poppins(color: kColorLightest)),
          ),

          // =================== Pengaturan Akun ===================
          sectionTitle("Pengaturan Akun"),
          buildSettingTile(Icons.lock, "Ganti Password / PIN"),
          buildSettingTile(Icons.phone_android, "Ganti Nomor HP / Email"),
          buildSettingTile(Icons.dark_mode, "Mode Gelap / Terang"),
          buildSettingTile(Icons.language, "Pilihan Bahasa"),

          // =================== Lain-lain ===================
          sectionTitle("Lain-lain"),
          ListTile(
            leading: const Icon(Icons.history, color: Colors.orange),
            title: Text("Riwayat Transaksi / Booking"),
            onTap: () {
              Navigator.pushNamed(context, "/riwayat");
            },
          ),
          buildSettingTile(Icons.support_agent, "Bantuan & Support"),
          buildSettingTile(Icons.privacy_tip, "Kebijakan Privasi"),
          buildSettingTile(Icons.delete_forever, "Hapus Akun"),

          const SizedBox(height: 20),

          // Tombol logout
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                backgroundColor: kColorMid,
                foregroundColor: kColorLightest,
                minimumSize: const Size(double.infinity, 50)),
            icon: const Icon(Icons.logout),
            label: Text("Logout", style: GoogleFonts.poppins()),
            onPressed: onLogout,
          ),
        ]),
      ),
    );
  }

  // 🔹 Helper untuk judul section
  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(title,
          style: GoogleFonts.poppins(
              fontSize: 18, color: kColorLightest, fontWeight: FontWeight.bold)),
    );
  }

  // 🔹 Helper untuk setting item
  Widget buildSettingTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: kColorLightest),
      title: Text(title,
          style: GoogleFonts.poppins(color: kColorLightest, fontSize: 15)),
      onTap: () {
        debugPrint("$title diklik");
      },
    );
  }
}
