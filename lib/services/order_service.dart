import 'package:flutter/material.dart';
import '../models/order_item.dart';
import '../models/service_item.dart';

class OrderService {
  static void buatBooking({
    required BuildContext context,
    required List<OrderItem> activeOrders,
    required ServiceItem service,
    required String barberman,
    required String tanggal,
    required String jam,
  }) {
    final newOrder = OrderItem(
      service: service,
      tanggal: tanggal,
      jam: jam,
      barberman: barberman,
      status: "Menunggu",
    );

    activeOrders.add(newOrder);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Booking berhasil!")),
    );
  }
}
