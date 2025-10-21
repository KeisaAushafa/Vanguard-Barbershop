import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart'; 
import '../services/app_settings.dart';

const Color kColorDarkest = Color(0xFF2B343D);
const Color kColorMid = Color(0xFF586A79);
const Color kColorLightest = Color(0xFFBCC1CE);
const Color kAccent = Color(0xFFFFC107);

class ProfilPage extends StatefulWidget {
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
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  bool _useLogoAvatar = false;
  late String _name;
  late String _email;
  late String _phone;
  String _alamat = "Belum diatur";
  DateTime? _tanggalLahir;
  String _gender = "Belum dipilih";
  bool _isDarkMode = true;
  String _language = "Indonesia";

  @override
  void initState() {
    super.initState();
    _name = widget.name;
    _email = widget.email;
    _phone = widget.phone;
  }

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Gunakan avatar default'),
                onTap: () {
                  setState(() => _useLogoAvatar = true);
                  Navigator.pop(ctx);
                },
              ),
              ListTile(
                leading: const Icon(Icons.close),
                title: const Text('Batal'),
                onTap: () => Navigator.pop(ctx),
              )
            ],
          ),
        );
      },
    );
  }

  void _editProfile() {
    showModalBottomSheet(
      context: context,
      backgroundColor: kColorDarkest,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Edit Profil",
                    style: GoogleFonts.poppins(
                        color: kColorLightest,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                _buildTextField("Nama", _name, (v) => _name = v),
                _buildTextField("Email", _email, (v) => _email = v),
                _buildTextField("No HP", _phone, (v) => _phone = v),
                _buildTextField("Alamat", _alamat, (v) => _alamat = v),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kColorMid,
                      foregroundColor: kColorLightest),
                  onPressed: () {
                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: Text("Simpan Perubahan",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _pickDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: ThemeData.dark().copyWith(
          colorScheme:
              const ColorScheme.dark(primary: kAccent, surface: kColorDarkest),
        ),
        child: child!,
      ),
    );
    if (selected != null) {
      setState(() {
        _tanggalLahir = selected;
      });
    }
  }

  void _selectGender() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
        title: const Text("Pilih Gender"),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              setState(() => _gender = "Laki-laki");
              Navigator.pop(context);
            },
            child: const Text("Laki-laki"),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              setState(() => _gender = "Perempuan");
              Navigator.pop(context);
            },
            child: const Text("Perempuan"),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: const Text("Batal"),
        ),
      ),
    );
  }

  void _changeLanguage() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: kColorDarkest,
        title: Text("Pilih Bahasa",
            style: GoogleFonts.poppins(color: kColorLightest)),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          _languageOption("Indonesia"),
          _languageOption("English"),
        ]),
      ),
    );
  }

  Widget _languageOption(String lang) {
    return RadioListTile(
      value: lang,
      groupValue: _language,
      activeColor: kAccent,
      title: Text(lang, style: GoogleFonts.poppins(color: kColorLightest)),
      onChanged: (v) {
        setState(() => _language = v.toString());

        AppSettings.setLanguage(v == 'English' ? 'en' : 'id');
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Language set to $v')),
        );
      },
    );
  }

  Widget _buildTextField(String label, String value, Function(String) onChange) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        style: GoogleFonts.poppins(color: kColorLightest),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(color: kColorLightest),
          filled: true,
          fillColor: kColorMid.withOpacity(0.3),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
        ),
        controller: TextEditingController(text: value),
        onChanged: onChange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorDarkest,
      appBar: AppBar(
        backgroundColor: kColorDarkest,
        elevation: 0,
        title: Text("Profil",
            style: GoogleFonts.poppins(
                color: kColorLightest, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
              CircleAvatar(
                radius: 55,
                backgroundColor: kColorMid,
                backgroundImage: _useLogoAvatar ? const AssetImage('assets/logo.png') as ImageProvider : null,
                child: !_useLogoAvatar
                  ? Text(
                    _name.isNotEmpty ? _name.substring(0, 1) : "?",
                    style: GoogleFonts.poppins(
                      fontSize: 40,
                      color: kColorLightest,
                      fontWeight: FontWeight.bold),
                  )
                  : null,
              ),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: kAccent,
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt, size: 18),
                    onPressed: _pickImage,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          infoText("Nama", _name),
          infoText("Email", _email),
          infoText("No HP", _phone),
          infoText("Alamat", _alamat),
      infoText(
        "Tanggal Lahir",
        _tanggalLahir != null ? _formatDate(_tanggalLahir!) : "-"),
          infoText("Gender", _gender),

          const SizedBox(height: 10),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                backgroundColor: kAccent,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50)),
            icon: const Icon(Icons.edit),
            label: Text("Edit Profil", style: GoogleFonts.poppins()),
            onPressed: _editProfile,
          ),
          const SizedBox(height: 20),
          sectionTitle("Pengaturan Akun"),
          buildSettingTile(Icons.lock, "Ganti Password / PIN"),
          buildSettingTile(Icons.language, "Bahasa ($_language)",
              onTap: _changeLanguage),
          buildSettingTile(
              Icons.dark_mode,
              _isDarkMode ? "Mode Gelap Aktif" : "Mode Terang",
              onTap: () {
                AppSettings.toggleTheme();
                setState(() => _isDarkMode = !_isDarkMode);
              }),
          buildSettingTile(Icons.calendar_month, "Atur Tanggal Lahir",
              onTap: _pickDate),
          buildSettingTile(Icons.people, "Pilih Gender", onTap: _selectGender),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                backgroundColor: kColorMid,
                foregroundColor: kColorLightest,
                minimumSize: const Size(double.infinity, 50)),
            icon: const Icon(Icons.logout),
            label: Text("Logout", style: GoogleFonts.poppins()),
            onPressed: widget.onLogout,
          ),
        ]),
      ),
    );
  }

  Widget infoText(String label, String value) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text("$label: $value",
            style: GoogleFonts.poppins(color: kColorLightest, fontSize: 15)),
      );

  Widget sectionTitle(String title) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(title,
            style: GoogleFonts.poppins(
                fontSize: 18,
                color: kColorLightest,
                fontWeight: FontWeight.bold)),
      );

  Widget buildSettingTile(IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: kColorLightest),
      title: Text(title,
          style: GoogleFonts.poppins(color: kColorLightest, fontSize: 15)),
      onTap: onTap,
    );
  }

  String _formatDate(DateTime d) {
    final monthNames = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${d.day} ${monthNames[d.month - 1]} ${d.year}';
  }
}
