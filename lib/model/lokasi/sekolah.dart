import 'package:hero/model/itemui.dart';
import 'package:hero/util/dateutil.dart';

import 'owner.dart';
import 'parentlokasi.dart';
import 'pic.dart';

class Sekolah extends ParentLokasi {
  String? idsekolah;
  String? idkec;
  String? idkel;
  String? nama;
  String? noNpsn;
  String? alamat;
  int? jmlGuru;
  int? jmlMurid;
  JenjangSekolah? jenjang;
  double? long;
  double? lat;

  Owner? owner;
  Pic? pic;

  @override
  bool isValid() {
    if (owner!.isValid() &&
        cstr(idkel) &&
        cstr(nama) &&
        cstr(noNpsn) &&
        cstr(alamat) &&
        jenjang != null &&
        long != 0 &&
        lat != 0) {
      if (lengthstr(alamat)) {
        return true;
      }
    }
    return false;
  }

  Sekolah.kosong();
  // "status": "WAITING APPROVAL",
  // "tgl_open": "2020-11-29",
  // "tgl_close": null,
  // "tgl_waiting": "2020-11-29",
  // "tgl_approval": null,
  // "created_by": "SDS001",
  // "approval_by": null,
  // "lastmodified": "2020-11-29 11:23:54",
  // "nama_kelurahan": "TOTOHARJO",
  // "nama_kecamatan": "BAKAUHENI",
  // "nama_tap": "TAP KALIANDA"

  // "id_tap": "TAP001",
  // "id_sekolah": "1",
  // "id_kecamatan" : "KEC001",
  //   "id_kelurahan" : "",
  //   "no_npsn" : "1",
  //   "nama_sekolah" : "SEKOLAH 11",
  //   "alamat_sekolah" : "ALAMAT 11",
  //   "longitude" : "LONG 11",
  //   "latitude" : "LAT 11",
  //   "jumlah_guru" : "1",
  //   "jumlah_siswa" : "2",
  //   "jenjang" : "SD"
  static const tagIdKec = 'id_kecamatan';
  static const tagIdKel = 'id_kelurahan';
  static const tagIdSekolah = 'id_sekolah';
  static const tagNpsn = 'no_npsn';
  static const tagNama = 'nama_sekolah';
  static const tagAlamat = 'alamat_sekolah';
  static const tagLong = 'longitude';
  static const tagLat = 'latitude';
  static const tagJmlGuru = 'jumlah_guru';
  static const tagJmlMurid = 'jumlah_siswa';
  static const tagJenjang = 'jenjang';

  //   "nama_kepsek" : "NAMA KEPSEK 11",
  //   "no_hp_kepsek" : "NO HP KEPSEK 11",
  //   "tgl_lahir_kepsek" : "2020-01-01",
  //   "hobi_kepsek" : "HOBI KEPSEK 11",
  //   "akun_fb_kepsek" : "AKUN FB KEPSEK 11",
  //   "akun_ig_kepsek" : "AKUN IG KEPSEK 11",
  static const tagNmKepsek = 'nama_kepsek';
  static const tagHpKep = 'no_hp_kepsek';
  static const tagTglLahirKep = 'tgl_lahir_kepsek';
  static const tagHobKep = 'hobi_kepsek';
  static const tagFbKep = 'akun_fb_kepsek';
  static const tagIgKep = 'akun_ig_kepsek';

  //   "nama_pic" : "NAMA PIC 11",
  //   "no_hp_pic" : "NO HP PIC 11",
  //   "tgl_lahir_pic" : "2020-02-02",
  //   "hobi_pic" : "HOBI PIC 11",
  //   "akun_fb_pic" : "AKUN FB PIC 11",
  //   "akun_ig_pic" : "AKUN IG PIC 11",
  static const tagNmPic = 'nama_pic';
  static const tagHpPic = 'no_hp_pic';
  static const tagTglLhrPic = 'tgl_lahir_pic';
  static const tagHobiPic = 'hobi_pic';
  static const tagFbPic = 'akun_fb_pic';
  static const tagIgPic = 'akun_ig_pic';

  Sekolah.fromJson(Map<String, dynamic> map) {
    // set jumlah guru
    if (map[tagJmlGuru] != null) {
      jmlGuru = int.tryParse(map[tagJmlGuru]) ?? 0;
    } else {
      jmlGuru = 0;
    }

// set jumlah murid
    if (map[tagJmlMurid] != null) {
      jmlMurid = int.tryParse(map[tagJmlMurid]) ?? 0;
    } else {
      jmlMurid = 0;
    }

// set jenjang
    int? intJenjang;
    Map<String, int> mapjjg = {};

    mapjjg['SD'] = 1;
    mapjjg['SMP'] = 2;
    mapjjg['SMA'] = 3;
    mapjjg['PONPES'] = 4;
    if (map[tagJenjang] != null) {
      intJenjang = mapjjg[map[tagJenjang]] ?? 1;
      intJenjang = intJenjang > 4 || intJenjang < 1 ? 1 : intJenjang;
    } else {
      intJenjang = 1;
    }

    Map<int, JenjangSekolah> mapJenjang = ItemUi.getJenjangSekolah();
    jenjang = mapJenjang[intJenjang];

// set long
    String strlong = map[tagLong] ?? '0';
    if (strlong.isNotEmpty) {
      long = double.tryParse(strlong);
    } else {
      long = 0.0;
    }

// set lat
    String strlat = map[tagLat] ?? '0';
    if (strlat.isNotEmpty) {
      lat = double.tryParse(strlat);
    } else {
      lat = 0.0;
    }

    idsekolah = map[tagIdSekolah];
    idkec = map[tagIdKec];
    idkel = map[tagIdKel];
    nama = map[tagNama];
    noNpsn = map[tagNpsn];
    alamat = map[tagAlamat] ?? '';

    owner = Owner.fromJson(map, tagNmKepsek, tagHpKep, tagTglLahirKep,
        tagHobKep, tagFbKep, tagIgKep);
    pic = Pic.fromJson(map);
  }

  Map toJson() {
    return {
      // tagIdKec: idkec,
      tagIdKel: idkel,
      tagIdSekolah: idsekolah,
      tagNpsn: noNpsn,
      tagNama: nama,
      tagAlamat: alamat,
      tagLong: long,
      tagLat: lat,
      tagJmlGuru: jmlGuru,
      tagJmlMurid: jmlMurid,
      tagJenjang: jenjang!.getIntJenjang(),
      tagNmKepsek: owner!.getNama(),
      tagHpKep: owner!.getNohp(),
      tagTglLahirKep: DateUtility.dateToStringYYYYMMDD(owner!.tglLahir),
      tagHobKep: owner!.getHobi(),
      tagFbKep: owner!.getFb(),
      tagIgKep: owner!.getIg(),
      tagNmPic: pic!.getNama(),
      tagHpPic: pic!.getNohp(),
      tagTglLhrPic: DateUtility.dateToStringYYYYMMDD(pic!.tglLahir),
      tagHobiPic: pic!.getHobi(),
      tagFbPic: pic!.getFb(),
      tagIgPic: pic!.getIg()
    };
  }

  String getStrJenjang() {
    if (jenjang != null) {
      return jenjang!.text;
    }
    return '-';
  }
}
