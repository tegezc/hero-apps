class Rekomendasi {
  static const String segel = 'SEGEL';
  static const String sa = 'SA';
  static const String voint = 'VO Internet';
  static const String vog = 'VO Games';
  List<ItemRekomendasi>? lsegel;
  List<ItemRekomendasi>? lsa;
  List<ItemRekomendasi>? lvointernet;
  List<ItemRekomendasi>? lvogames;
}

class ItemRekomendasi {
  String? nama;
  late String w1;
  late String w2;
  late String w3;
  late String w4;
  String? rkmd;

  // "nama": "Simpati",
  // "w1": 0,
  // "w2": 0,
  // "w3": 0,
  // "w4": 0,
  // "rekomendasi": 0

  ItemRekomendasi.fromJson(Map<String, dynamic> map) {
    nama = map['nama'] ?? '';
    w1 = map['w1'] == null ? '' : '${map['w1']}';
    w2 = map['w2'] == null ? '' : '${map['w2']}';
    w3 = map['w3'] == null ? '' : '${map['w3']}';
    w4 = map['w4'] == null ? '' : '${map['w4']}';
    rkmd = map['rekomendasi'] == null ? '' : '${map['rekomendasi']}';
  }
}
