class Catatan {
  final String catataner;
  final String catatan;
  final String timestamp;
  final String coffeeName;  // Tambahkan properti ini

  Catatan({
    required this.catataner,
    required this.catatan,
    required this.timestamp,
    required this.coffeeName,  // Tambahkan properti ini
  });

  Map<String, dynamic> toJson() => {
        'catataner': catataner,
        'catatan': catatan,
        'timestamp': timestamp,
        'coffeeName': coffeeName,  // Tambahkan properti ini
      };

  factory Catatan.fromJson(Map<String, dynamic> json) => Catatan(
        catataner: json['catataner'],
        catatan: json['catatan'],
        timestamp: json['timestamp'],
        coffeeName: json['coffeeName'],  // Tambahkan properti ini
      );
}
