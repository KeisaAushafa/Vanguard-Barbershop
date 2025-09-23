import 'package:flutter/material.dart';
import '../models/service_item.dart';

class CartService {
  static void addToCart(BuildContext context, List<ServiceItem> cart, ServiceItem item) {
    cart.add(item);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${item.nama} ditambahkan ke keranjang")),
    );
  }

  static void removeFromCart(List cart, int idx) {
    if (idx >= 0 && idx < cart.length) {
      cart.removeAt(idx);
    }
  }

  static int totalHarga(List<ServiceItem> cart) {
    int total = 0;
    for (var item in cart) {
      int hargaDiskon = item.harga - ((item.harga * item.diskon) ~/ 100);
      total += hargaDiskon;
    }
    return total;
  }
}
