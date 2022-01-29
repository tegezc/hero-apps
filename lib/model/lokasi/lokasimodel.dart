import 'package:hero/core/data/datasources/database/stringdb.dart';

class Provinsi {
  int? id;
  String? realid;
  String? nama;

  Provinsi({this.id, this.realid, this.nama});
  Provinsi.fromJson(Map<String, dynamic> map) {
    //
    //   "id_provinsi": "PRV004",
    // "nama_provinsi": "LAMPUNG",
    // "lastmodified": "2020-11-29 09:00:00"
    //

    realid = map['id_provinsi'] == null ? '' : map['id_provinsi'];
    nama = map['nama_provinsi'] == null ? '' : map['nama_provinsi'];
  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map[TbProv.id] = id;
    map[TbProv.realid] = realid;
    map[TbProv.nama] = nama;
    return map;
  }

  Provinsi.formDb(this.id, this.realid, this.nama);

  @override
  bool operator ==(dynamic other) =>
      other != null && other is Provinsi && realid == other.realid;

  @override
  String toString() {
    return '$nama';
  }
}

class Kabupaten {
  int? id;
  String? realid;
  String? idprov;
  String? nama;
  int? radiusClockin;

  Kabupaten({this.id, this.realid, this.idprov, this.nama});

  Kabupaten.formDb(this.id, this.realid, this.idprov, this.nama);

  Kabupaten.fromJson(Map<String, dynamic> map) {
    // "id_provinsi": "PRV004",
    // "id_kabupaten": "KAB029",
    // "nama_kabupaten": "KOTA BANDAR LAMPUNG",
    // "radius_clock_in": "0",
    // "lastmodified": "2020-11-29 09:00:00"
    realid = map['id_kabupaten'] == null ? '' : map['id_kabupaten'];
    idprov = map['id_provinsi'] == null ? '' : map['id_provinsi'];
    nama = map['nama_kabupaten'] == null ? '' : map['nama_kabupaten'];
    if (map['radius_clock_in'] == null) {
      radiusClockin = 25;
    } else {
      radiusClockin = int.tryParse(map['radius_clock_in']) == null
          ? 25
          : int.tryParse(map['radius_clock_in']);
    }
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map[TbKab.id] = id;
    map[TbKab.realid] = realid;
    map[TbKab.idprov] = idprov;
    map[TbKab.nama] = nama;
    return map;
  }

  @override
  bool operator ==(dynamic other) =>
      other != null && other is Kabupaten && realid == other.realid;

  @override
  String toString() {
    return '$nama';
  }
}

class Kecamatan {
  int? id;
  String? realid;
  String? idcluster;
  String? idkab;
  String? nama;

  Kecamatan({
    required this.realid,
    required this.idcluster,
    required this.idkab,
    required this.nama,
    this.id,
  });

  Kecamatan.fromJson(Map<String, dynamic> map) {
    // "id_kabupaten": "KAB029",
    // "id_cluster": "CTR005",
    // "id_kecamatan": "KEC172",
    // "nama_kecamatan": "BUMI WARAS",
    // "lastmodified": "2020-11-29 09:00:00"

    realid = map['id_kecamatan'] == null ? '' : map['id_kecamatan'];
    idkab = map['id_kabupaten'] == null ? '' : map['id_kabupaten'];
    idcluster = map['id_cluster'] == null ? '' : map['id_cluster'];
    nama = map['nama_kecamatan'] == null ? '' : map['nama_kecamatan'];
  }

  Kecamatan.fromDb(
    this.id,
    this.realid,
    this.idcluster,
    this.idkab,
    this.nama,
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map[TbKec.id] = id;
    map[TbKec.realid] = realid;
    map[TbKec.idkab] = idkab;
    map[TbKec.idcluster] = idcluster;
    map[TbKec.nama] = nama;
    return map;
  }

  @override
  bool operator ==(dynamic other) =>
      other != null && other is Kecamatan && realid == other.realid;

  @override
  String toString() {
    return '$nama';
  }
}

class Kelurahan {
  int? id;
  String? idkel;
  String? idkec;
  String? nama;

  Kelurahan({this.id, this.idkec, this.idkel, this.nama});

  Kelurahan.fromDb(this.id, this.idkec, this.idkel, this.nama);

  // "id_kecamatan": "KEC172",
  // "id_kelurahan": "KLH8478",
  // "nama_kelurahan": "BUMI RAYA",
  // "lastmodified": "2020-11-29 09:00:00"
  Kelurahan.fromJson(Map<String, dynamic> map) {
    idkel = map['id_kelurahan'] == null ? '' : map['id_kelurahan'];
    idkec = map['id_kecamatan'] == null ? '' : map['id_kecamatan'];
    nama = map['nama_kelurahan'] == null ? '' : map['nama_kelurahan'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map[TbKel.id] = id;
    map[TbKel.idkel] = idkel;
    map[TbKel.idkec] = idkec;
    map[TbKel.nama] = nama;
    return map;
  }

  @override
  bool operator ==(dynamic other) =>
      other != null && other is Kelurahan && idkel == other.idkel;

  @override
  String toString() {
    return '$nama';
  }
}
