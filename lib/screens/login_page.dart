import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  final String? prevName;
  final String? prevEmail;
  final String? prevPhone;

  const LoginPage({super.key, this.prevName, this.prevEmail, this.prevPhone});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();


  final _emailC = TextEditingController();
  final _passC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _nameController.text = widget.prevName ?? '';
    _phoneController.text = widget.prevPhone ?? '';
    _emailC.text = widget.prevEmail ?? '';

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _emailC.dispose();
    _passC.dispose();
    super.dispose();
  }

  void _toggleObscure() {
    setState(() => _obscure = !_obscure);
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final name = _nameController.text.trim();
  final phone = _phoneController.text.trim();
  final email = _emailC.text.trim();

    final phoneRegex = RegExp(r'^[0-9]{10,13}$');

    if (name.isEmpty || phone.isEmpty) {
      _showSnackBar('Nama dan telepon wajib diisi!');
      return;
    }
    if (!phoneRegex.hasMatch(phone)) {
      _showSnackBar('Nomor telepon harus 10–13 digit angka!');
      return;
    }

    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isLoading = false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            email: email,
            name: name,
            phone: phone,
          ),
        ),
      );
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildNavbar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Text("Home",
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white70)),
          const SizedBox(width: 20),
          Text("Sign In",
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white70)),
          const SizedBox(width: 20),
          Text("Log In",
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildLeftSide() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logo.png", width: 140),
            const SizedBox(height: 20),
            Text("Vanguard",
                style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 10),
            Text(
              "Modern Cuts.\nClassic Shaves.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRightSide() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          padding: const EdgeInsets.all(30),
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFF8F9FA), Color(0xFFECEFF1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 15,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Welcome Back!",
                  style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)),
              const SizedBox(height: 20),
            
              TextField(
                controller: _nameController,
                style: const TextStyle(color: Colors.black87),
                decoration: _inputStyle("Full Name (contoh: Budi Santoso)"),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _phoneController,
                style: const TextStyle(color: Colors.black87),
                decoration: _inputStyle("Phone Number (contoh: 081234567890)"),
              ),
              const SizedBox(height: 20),
            
              const SizedBox(height: 18),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailC,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(color: Colors.black87),
                      decoration: _inputStyle(
                        'Email',
                        prefix: const Icon(
                          Icons.email_outlined,
                          color: Colors.black54,
                        ),
                      ),
                      validator: (v) {
                        final value = v?.trim() ?? '';
                        if (value.isEmpty) return 'Email wajib diisi';
                        if (!RegExp(r'^.+@.+\..+$').hasMatch(value)) {
                          return 'Format email tidak valid';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _passC,
                      obscureText: _obscure,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _submit(),
                      style: const TextStyle(color: Colors.black87),
                      decoration: _inputStyle(
                        'Password',
                        prefix: const Icon(
                          Icons.lock_outline,
                          color: Colors.black54,
                        ),
                        suffix: IconButton(
                          onPressed: _toggleObscure,
                          icon: Icon(
                            _obscure
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.black54,
                          ),
                          tooltip: _obscure
                              ? 'Tampilkan password'
                              : 'Sembunyikan password',
                        ),
                      ),
                      validator: (v) {
                        final value = v ?? '';
                        if (value.isEmpty) return 'Password wajib diisi';
                        if (value.length < 6) {
                          return 'Minimal 6 karakter';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _submit,
                child: const Text("Log In"),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Expanded(child: Divider(thickness: 1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "or",
                      style: GoogleFonts.poppins(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider(thickness: 1)),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: _socialButton(FontAwesomeIcons.google, "Google"),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _socialButton(FontAwesomeIcons.apple, "Apple"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _iconButton(FontAwesomeIcons.facebook, Colors.blue),
                  const SizedBox(width: 10),
                  _iconButton(FontAwesomeIcons.github, Colors.black),
                  const SizedBox(width: 10),
                  _iconButton(FontAwesomeIcons.twitter, Colors.lightBlue),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputStyle(String label, {Widget? prefix, Widget? suffix}) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.grey), // label lebih gelap
      filled: true,
      fillColor: Colors.white,
      prefixIcon: prefix,
      suffixIcon: suffix,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }

  static ElevatedButton _socialButton(IconData icon, String text) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        side: const BorderSide(color: Colors.black12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      onPressed: () {},
      icon: FaIcon(icon, size: 18),
      label: Text(text),
    );
  }

  static IconButton _iconButton(IconData icon, Color color) {
    return IconButton(icon: FaIcon(icon, color: color), onPressed: () {});
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1E2A36),
                  Color(0xFF3F4E5A),
                  Color(0xFF7A869A),
                  Color(0xFFE0E0E0),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                _buildNavbar(),
                Expanded(
                  child: isMobile
                      ? SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildLeftSide(),
                              const SizedBox(height: 30),
                              _buildRightSide(),
                            ],
                          ),
                        )
                      : Row(
                          children: [
                            Expanded(flex: 1, child: _buildLeftSide()),
                            Expanded(flex: 1, child: _buildRightSide()),
                          ],
                        ),
                ),
              ],
            ),
          ),
          // Loading 
          if (_isLoading)
            Container(
              color: Colors.black45,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 4,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
