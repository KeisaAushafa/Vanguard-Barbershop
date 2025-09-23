import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/service_item.dart';

/// 🎨 Palette Warna Baru (disamakan dengan Home & Spec terbaru)
const Color kBgMain = Color(0xFF2B343D); // background utama
const Color kAppBarTop = Color(0xFF3F4E5A); // appbar gradasi atas
const Color kAppBarBottom = Color(0xFF2B343D); // appbar gradasi bawah
const Color kTextTitle = Color(0xFFBCC1CE); // abu terang
const Color kTextMedium = Color(0xFFA1A4B9); // abu medium
const Color kIconActiveBg = Color(0xFF586A79); // bg icon active
const Color kCardLight = Color(0xFFB0B0B0); // card promo
const Color kCardDark = Color(0xFF3F4E5A); // card di layanan
const Color kTextDark = Color(0xFF2B343D); // teks gelap
const Color kTextDarkBlue = Color(0xFF3F4E5A); // teks biru gelap

class LayananPage extends StatelessWidget {
  final List<ServiceItem> services;
  final void Function(ServiceItem) onAddToCart;
  final List<ServiceItem> cart;
  final Future<void> Function()? onCheckout;
  final int totalHarga;

  const LayananPage({
    super.key,
    required this.services,
    required this.onAddToCart,
    required this.cart,
    required this.onCheckout,
    required this.totalHarga,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBgMain,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Header ---
            Text(
              "Daftar Layanan",
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: kTextTitle,
              ),
            ),
            const SizedBox(height: 14),

            // --- Daftar layanan ---
            ...services.map(
              (item) => Card(
                color: kCardDark,
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 4,
                shadowColor: Colors.black54,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ExpansionTile(
                  collapsedIconColor: kTextMedium,
                  iconColor: kTextTitle,
                  leading: Icon(
                    Icons.content_cut,
                    color: item.kategori == "Premium"
                        ? Colors.amber
                        : kTextTitle,
                  ),
                  title: Text(
                    "${item.nama} (${item.kategori})",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: kTextTitle,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Harga: Rp${item.harga} | Diskon: ${item.diskon}% | Estimasi: ${item.durasi} menit",
                        style: GoogleFonts.poppins(
                          color: kTextMedium,
                          fontSize: 13,
                        ),
                      ),
                      if (item.bisaDatangKerumah)
                        const Text(
                          "Bisa datang ke rumah",
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (item.barberman.isNotEmpty)
                        Text(
                          "Barberman: ${item.barberman.join(', ')}",
                          style: GoogleFonts.poppins(
                            color: Colors.cyanAccent,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                  children: [
                    if (item.subItems.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pilihan Tambahan:",
                              style: GoogleFonts.poppins(
                                color: kTextTitle,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            ...item.subItems.map(
                              (sub) => Row(
                                children: [
                                  const Icon(
                                    Icons.check,
                                    size: 16,
                                    color: Colors.greenAccent,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    sub,
                                    style: GoogleFonts.poppins(
                                      color: kTextMedium,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kIconActiveBg,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          icon: const Icon(Icons.add_shopping_cart),
                          label: const Text("Tambah ke Keranjang"),
                          onPressed: () {
                            onAddToCart(item);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "${item.nama} ditambahkan ke keranjang",
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // --- Summary + Checkout ---
            Card(
              color: kCardDark,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Total (${cart.length} item)",
                            style: GoogleFonts.poppins(
                              color: kTextTitle,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          "Rp $totalHarga",
                          style: GoogleFonts.poppins(
                            color: kTextTitle,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: cart.isEmpty
                            ? null
                            : () => _showPaymentOptions(context),
                        icon: const Icon(Icons.payment),
                        label: const Text("Checkout"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kIconActiveBg,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Bottom sheet pilihan pembayaran ---
  void _showPaymentOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: kCardDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Pilih Metode Pembayaran",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kTextTitle,
                ),
              ),
              const SizedBox(height: 14),
              ListTile(
                leading: const Icon(Icons.money, color: Colors.greenAccent),
                title: const Text(
                  "Bayar Cash",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () async {
                  Navigator.pop(ctx);
                  if (onCheckout != null) await onCheckout!();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Pembayaran Cash Saat Berada di Tempat"),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.account_balance, color: Colors.blue),
                title: const Text(
                  "Transfer / QRIS",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(ctx);
                  _showQrisDialog(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.account_balance_wallet,
                    color: Colors.orange),
                title: const Text(
                  "Dana / E-Wallet",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () async {
                  Navigator.pop(ctx);
                  if (onCheckout != null) await onCheckout!();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Pembayaran via E-Wallet berhasil"),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text(
                    "Batal",
                    style: GoogleFonts.poppins(color: kTextMedium),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // --- Dialog QRIS ---
  void _showQrisDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: kCardDark,
          title: Text(
            "Scan QRIS",
            style: GoogleFonts.poppins(color: kTextTitle),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/qr.png",
                height: 220,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 12),
              Text(
                "Silakan scan QRIS untuk menyelesaikan pembayaran",
                style: GoogleFonts.poppins(
                  color: kTextMedium,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(
                "Tutup",
                style: GoogleFonts.poppins(color: kTextMedium),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(ctx);
                if (onCheckout != null) await onCheckout!();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Pembayaran via Transfer/QRIS berhasil"),
                  ),
                );
              },
              child: Text(
                "Selesai",
                style: GoogleFonts.poppins(color: kTextTitle),
              ),
            ),
          ],
        );
      },
    );
  }
}
