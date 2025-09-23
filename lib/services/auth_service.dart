import 'package:flutter/material.dart';
import '../screens/login_page.dart';

class AuthService {
  /// Simulasi Google sign-in (fake). Returns user map on success.
  static Future<Map<String, String>?> signInWithGoogle(BuildContext context) async {
    // show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pop(context); // close loading

    // Simulate success
    return {
      'email': 'google.user@example.com',
      'name': 'Google User',
      'phone': '081234567890',
    };
  }

  /// Simulasi Apple sign-in (fake)
  static Future<Map<String, String>?> signInWithApple(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pop(context);

    return {
      'email': 'apple.user@example.com',
      'name': 'Apple User',
      'phone': '081234567891',
    };
  }

  static Future<void> logout(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Konfirmasi"),
        content: const Text("Apakah kamu yakin ingin logout?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text("Batal")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black87),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("Logout"),
          ),
        ],
      ),
    );

    if (confirm == true && context.mounted) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginPage()), (route) => false);
    }
  }
}
