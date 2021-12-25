import 'package:hero/util/dateutil.dart';

import 'owner.dart';
import 'parentlokasi.dart';
import 'pic.dart';

class Universitas extends ParentLokasi {
  String? iduniv;
  String? idkel;
  String? npsn;
  String? nama;
  String? alamat;
  double? lat;
  double? long;

  Owner? owner;
  Pic? pic;
  @override
  bool isValid() {
    if (owner!.isValid() &&
        cstr(idkel) &&
        cstr(nama) &&
        cstr(npsn) &&
        cstr(alamat) &&
        long != 0 &&
        lat != 0) {
      if (lengthstr(alamat)) {
        return true;
      }
    }
    return false;
  }

  Universitas.kosong();
  Universitas.fromJson(Map<String, dynamic> map) {
    iduniv = map[tagiduniv];
    idkel = map[tagidkel] == null ? '' : map[tagidkel];
    npsn = map[tagnpsn] == null ? '' : map[tagnpsn];
    nama = map[tagnama] == null ? '' : map[tagnama];
    alamat = map[tagalamat] == null ? '' : map[tagalamat];

    String strlong = map[taglong] == null ? '0' : map[taglong];
    if (strlong.length > 0) {
      long = double.tryParse(strlong);
    } else {
      long = 0.0;
    }

// set lat
    String strlat = map[taglat] == null ? '0' : map[taglat];
    if (strlat.length > 0) {
      lat = double.tryParse(strlat);
    } else {
      lat = 0.0;
    }

    owner = Owner.fromJson(map, tagNmOwner, tagNoHpOwner, tagTglLahirOwner,
        tagHobiOw, tagFbOw, tagIgOw);
    pic = Pic.fromJson(map);
  }

  Map toJson() {
    return {
      tagidkel: idkel,
      tagiduniv: iduniv,
      tagnpsn: npsn,
      tagnama: nama,
      tagalamat: alamat,
      taglong: long,
      taglat: lat,
      tagNmOwner: owner!.nama,
      tagNoHpOwner: owner!.nohp,
      tagTglLahirOwner: DateUtility.dateToStringYYYYMMDD(owner!.tglLahir),
      tagHobiOw: owner!.hobi,
      tagFbOw: owner!.fb,
      tagIgOw: owner!.ig,
      tagNmPic: pic!.nama,
      tagHpPic: pic!.nohp,
      tagTglLahirPic: DateUtility.dateToStringYYYYMMDD(pic!.tglLahir),
      tagHobiPic: pic!.hobi,
      tabFbPic: pic!.fb,
      tagIgPic: pic!.ig
    };
  }

  static const String tagidkel = 'id_kelurahan';
  static const String tagiduniv = 'id_universitas';
  static const String tagnpsn = 'no_npsn';
  static const String tagnama = 'nama_universitas';
  static const String tagalamat = 'alamat_universitas';
  static const String taglong = 'longitude';
  static const String taglat = 'latitude';
  static const String tagNmOwner = 'nama_rektor';
  static const String tagNoHpOwner = 'no_hp_rektor';
  static const String tagTglLahirOwner = 'tgl_lahir_rektor';
  static const String tagHobiOw = 'hobi_rektor';
  static const String tagFbOw = 'akun_fb_rektor';
  static const String tagIgOw = 'akun_ig_rektor';
  static const String tagNmPic = 'nama_pic';
  static const String tagHpPic = 'no_hp_pic';
  static const String tagTglLahirPic = 'tgl_lahir_pic';
  static const String tagHobiPic = 'hobi_pic';
  static const String tabFbPic = 'akun_fb_pic';
  static const String tagIgPic = 'akun_ig_pic';

  bool operator ==(dynamic other) =>
      other != null && other is Universitas && this.iduniv == other.iduniv;

  @override
  int get hashCode => super.hashCode;
// "id_tap": "TAP001",
// "status": "WAITING APPROVAL",
// "tgl_open": "2020-11-29",
  // "tgl_close": null,
  // "tgl_waiting": "2020-11-29",
  // "tgl_approval": null,
  // "created_by": "SDS001",
  // "approval_by": null,
  // "lastmodified": "2020-11-29 11:35:30",
  // "nama_kelurahan": "TOTOHARJO",
  // "id_kecamatan": "KEC301",
  // "nama_kecamatan": "BAKAUHENI",
  // "nama_tap": "TAP KALIANDA"

}
