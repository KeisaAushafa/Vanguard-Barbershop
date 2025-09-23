// models/order_item.dart
import 'service_item.dart';

class OrderItem {
  /// Core fields (lama)
  final ServiceItem service;
  final String tanggal;
  final String jam;
  final String barberman;
  String status;

  /// Tambahan agar UI dan detail page bisa akses:
  final String id;               // booking / transaksi id
  final int totalHarga;          // total (set default jika tidak diberikan)
  final String metodePembayaran; // contoh "Cash", "QRIS", "E-Wallet"
  final String catatan;          // catatan tambahan dari user

  /// Constructor: kompatibel dengan pemanggilan lama.
  /// Kamu dapat tetap memanggil:
  /// OrderItem(service: s, tanggal: t, jam: j, barberman: b, status: "Menunggu")
  /// — dan fields tambahan akan diberi nilai default.
  OrderItem({
    required this.service,
    required this.tanggal,
    required this.jam,
    required this.barberman,
    this.status = "Menunggu",
    String? id,
    int? totalHarga,
    String? metodePembayaran,
    String? catatan,
  })  : id = id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        // default totalHarga: harga setelah diskon (jika tersedia)
        totalHarga = totalHarga ??
            (service.harga - ((service.harga * service.diskon) ~/ 100)),
        metodePembayaran = metodePembayaran ?? "Belum dipilih",
        catatan = catatan ?? "";

  /// copyWith: memudahkan update status / metode / catatan tanpa membuat error
  OrderItem copyWith({
    String? status,
    String? metodePembayaran,
    String? catatan,
    int? totalHarga,
  }) {
    return OrderItem(
      service: service,
      tanggal: tanggal,
      jam: jam,
      barberman: barberman,
      status: status ?? this.status,
      id: id,
      totalHarga: totalHarga ?? this.totalHarga,
      metodePembayaran: metodePembayaran ?? this.metodePembayaran,
      catatan: catatan ?? this.catatan,
    );
  }
}
