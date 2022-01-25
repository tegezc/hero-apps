import 'package:hero/util/dateutil.dart';

import 'owner.dart';
import 'parentlokasi.dart';
import 'pic.dart';

class Fakultas extends ParentLokasi {
  String? idkel;
  String? iduniv;
  String? idfak;
  String? nama;
  String? alamat;
  double? long;
  double? lat;
  int? jmlDosen;
  int? jmlMahasiswa;
  String? namaUniv;
  Owner? dekan;
  Pic? pic;

  @override
  bool isValid() {
    if (cstr(idkel) &&
        cstr(iduniv) &&
        cstr(nama) &&
        cstr(alamat) &&
        dekan!.isValid() &&
        long != 0 &&
        lat != 0) {
      if (lengthstr(alamat)) {
        return true;
      }
    }
    return false;
  }

  Fakultas.kosong();
  static const String tagNmUniv = 'nama_universitas';
  static const String tagidkel = 'id_kelurahan';
  static const String tagiduniv = 'id_universitas';
  static const String tagidfakultas = 'id_fakultas';
  static const String tagnama = 'nama_fakultas';
  static const String tagalamat = 'alamat_fakultas';
  static const String tagidtap = 'id_tap';
  static const String taglong = 'longitude';
  static const String taglat = 'latitude';
  static const String tagJmlDosen = 'jumlah_dosen';
  static const String tagJmlMahasiswa = 'jumlah_mahasiswa';
  static const String tagNmOwner = 'nama_dekan';
  static const String tagNoHpOwner = 'no_hp_dekan';
  static const String tagTglLahirOwner = 'tgl_lahir_dekan';
  static const String tagHobiOw = 'hobi_dekan';
  static const String tagFbOw = 'akun_fb_dekan';
  static const String tagIgOw = 'akun_ig_dekan';
  static const String tagNmPic = 'nama_pic';
  static const String tagHpPic = 'no_hp_pic';
  static const String tagTglLahirPic = 'tgl_lahir_pic';
  static const String tagHobiPic = 'hobi_pic';
  static const String tabFbPic = 'akun_fb_pic';
  static const String tagIgPic = 'akun_ig_pic';

  Fakultas.fromJson(Map<String, dynamic> map) {
    String strlong = map[taglong] == null ? '0' : map[taglong];
    if (strlong.isNotEmpty) {
      long = double.tryParse(strlong);
    } else {
      long = 0.0;
    }

    String strlat = map[taglat] == null ? '0' : map[taglat];
    if (strlat.isNotEmpty) {
      lat = double.tryParse(strlat);
    } else {
      lat = 0.0;
    }

    if (map[tagidkel] == null) {
      /// kodisi gak valid
      idkel = '';
    } else {
      idkel = map[tagidkel];
    }

    // set jumlah Dosen
    if (map[tagJmlDosen] != null) {
      jmlDosen = int.tryParse(map[tagJmlDosen]) == null
          ? 0
          : int.tryParse(map[tagJmlDosen]);
    } else {
      jmlDosen = 0;
    }

// set jumlah Mahasiswa
    if (map[tagJmlMahasiswa] != null) {
      jmlMahasiswa = int.tryParse(map[tagJmlMahasiswa]) == null
          ? 0
          : int.tryParse(map[tagJmlMahasiswa]);
    } else {
      jmlMahasiswa = 0;
    }

    idfak = map[tagidfakultas] == null ? '' : map[tagidfakultas];
    iduniv = map[tagiduniv] == null ? '' : map[tagiduniv];
    nama = map[tagnama] == null ? '' : map[tagnama];
    alamat = map[tagalamat] == null ? '' : map[tagalamat];
    namaUniv = map[tagNmUniv] == null ? '' : map[tagNmUniv];

    pic = Pic.fromJson(map);
    dekan = Owner.fromJson(map, tagNmOwner, tagNoHpOwner, tagTglLahirOwner,
        tagHobiOw, tagFbOw, tagIgOw);
  }

  Map toJson() {
    return {
      tagidkel: idkel,
      tagiduniv: iduniv,
      tagidfakultas: idfak,
      tagnama: nama,
      tagalamat: alamat,
      taglong: long,
      taglat: lat,
      tagJmlDosen: jmlDosen,
      tagJmlMahasiswa: jmlMahasiswa,
      tagNmOwner: dekan!.nama,
      tagNoHpOwner: dekan!.nohp,
      tagTglLahirOwner: DateUtility.dateToStringYYYYMMDD(dekan!.tglLahir),
      tagHobiOw: dekan!.hobi,
      tagFbOw: dekan!.fb,
      tagIgOw: dekan!.ig,
      tagNmPic: pic!.nama,
      tagHpPic: pic!.nohp,
      tagTglLahirPic: DateUtility.dateToStringYYYYMMDD(pic!.tglLahir),
      tagHobiPic: pic!.hobi,
      tabFbPic: pic!.fb,
      tagIgPic: pic!.ig
    };
  }

  // "tgl_open": null,
  // "tgl_close": "2020-11-30",
  // "tgl_waiting": "2020-12-01",
  // "tgl_approval": "2020-11-30",
  // "created_by": "SDS001",
  // "approval_by": "REG001-CO",
  // "lastmodified": "2020-12-01 00:52:39",
  // "nama_kelurahan": "TOTOHARJO",
  // "id_kecamatan": "KEC301",
  // "nama_kecamatan": "BAKAUHENI",
  // "nama_tap": "TAP KALIANDA",

}
