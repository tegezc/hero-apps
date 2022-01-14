import 'dart:convert';

class FrekuensiPaket {
  String idserver;
  String nama;
  FrekuensiPaket({required this.idserver, required this.nama});

  bool isValid() {
    if (idserver == null || nama == null) {
      return false;
    }
    return true;
  }

  Map<String, dynamic> toMap() {
    return {'id': idserver, 'jenis': nama};
  }

  var contohmap = {"id": "2", "jenis": "Mingguan"};

  factory FrekuensiPaket.fromMap(Map<String, dynamic> map) {
    return FrekuensiPaket(
      idserver: map['id'],
      nama: map['jenis'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FrekuensiPaket.fromJson(String source) =>
      FrekuensiPaket.fromMap(json.decode(source));
}
