import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/service_item.dart';

const Color kBgMain = Color(0xFF2B343D); // background utama
const Color kAppBarTop = Color(0xFF3F4E5A); // appbar gradasi atas
const Color kAppBarBottom = Color(0xFF2B343D); // appbar gradasi bawah
const Color kTextTitle = Color(0xFFBCC1CE); // abu terang
const Color kTextMedium = Color(0xFFA1A4B9); // abu medium
const Color kIconActiveBg = Color(0xFF586A79); // bg icon active
const Color kCardLight = Color(0xFFFDF3E7); // cream
const Color kCardDark = Color(0xFF6E4CA7); // purple (ungu)
const Color kTextDark = Color(0xFF2B343D); // teks gelap (untuk cream)
const Color kTextOnPurple = Color(0xFFFFFFFF); // teks putih pada ungu

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
            Row(
              children: [
                const Text('✂️', style: TextStyle(fontSize: 26)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Daftar Layanan",
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: kTextTitle,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Pilih layanan terbaik untukmu — kualitas & gaya modern',
                        style: GoogleFonts.poppins(color: kTextMedium, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_list),
                  label: const Text('Filter'),
                  style: ElevatedButton.styleFrom(backgroundColor: kIconActiveBg),
                )
              ],
            ),
            const SizedBox(height: 14),

            // --- Daftar layanan ---
            ...services.map(
              (item) {
                // Dua warna saja: ungu untuk 'Coloring', sisanya cream
                final bool isPurple = item.kategori == 'Coloring';
                final Color tileColor = isPurple ? kCardDark : kCardLight;
                final Color titleColor = isPurple ? kTextOnPurple : kTextDark;
                final Color subtitleColor = isPurple ? kTextOnPurple.withOpacity(0.9) : kTextMedium;
                final Color iconColor = isPurple ? kTextOnPurple : kTextDark;

                final hargaDiskon = item.harga - ((item.harga * item.diskon) ~/ 100);

                return Card(
                  color: tileColor,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 4,
                  shadowColor: Colors.black45,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.content_cut, size: 26, color: iconColor),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '${item.nama} • ${item.kategori}',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: titleColor,
                                ),
                              ),
                            ),
                            if (item.diskon > 0)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                decoration: BoxDecoration(
                                  color: kIconActiveBg,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text('🎉 ${item.diskon} %', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              )
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text('Harga: Rp${item.harga}  →  Rp$hargaDiskon', style: GoogleFonts.poppins(color: subtitleColor, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        if (item.subItems.isNotEmpty)
                          Wrap(
                            spacing: 8,
                            children: item.subItems
                                .map((s) => Chip(
                                      backgroundColor: isPurple ? Colors.white10 : Colors.white70,
                                      label: Text(
                                        s,
                                        style: TextStyle(color: isPurple ? kTextOnPurple : kTextDark),
                                      ),
                                    ))
                                .toList(),
                          ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isPurple ? const Color(0xFF7D5DB8) : kIconActiveBg,
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
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

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

  // QRIS
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
