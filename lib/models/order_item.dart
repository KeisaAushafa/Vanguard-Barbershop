// models/order_item.dart
import 'service_item.dart';

class OrderItem {
  final ServiceItem service;
  final String tanggal;
  final String jam;
  final String barberman;
  String status;

  final String id;
  final int totalHarga;
  final String metodePembayaran;
  final String catatan;

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
        
        totalHarga = totalHarga ??
            (service.harga - ((service.harga * service.diskon) ~/ 100)),
        metodePembayaran = metodePembayaran ?? "Belum dipilih",
        catatan = catatan ?? "";

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
