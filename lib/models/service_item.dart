class ServiceItem {
  String kategori;
  String nama;
  int harga;
  int diskon;
  int durasi;
  bool bisaDatangKerumah;
  List<String> subItems;
  List<String> barberman;

  ServiceItem({
    required this.kategori,
    required this.nama,
    required this.harga,
    required this.diskon,
    required this.durasi,
    this.bisaDatangKerumah = false,
    this.subItems = const [],
    this.barberman = const [],
  });
}
