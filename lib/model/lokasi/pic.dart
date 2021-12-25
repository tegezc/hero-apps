//         "nama_pic": "NAMA PIC 1 EDIT",
//         "no_hp_pic": "NO HP PIC 1 EDIT",
//         "tgl_lahir_pic": "2021-02-02",
//         "hobi_pic": "HOBI PIC 1 EDIT",
//         "akun_fb_pic": "AKUN FB PIC 1 EDIT",
//         "akun_ig_pic": "AKUN IG PIC 1 EDIT",


import 'package:hero/util/dateutil.dart';

class Pic {
  String? nama;
  String? nohp;
  DateTime? tglLahir;
  String? hobi;
  String? fb;
  String? ig;

  Pic.kosong();

  Pic.fromJson(Map<String, dynamic> map) {
    nama = map['nama_pic'] == null ? '' : map['nama_pic'];
    nohp = map['no_hp_pic'] == null ? '' : map['no_hp_pic'];
    hobi = map['hobi_pic'] == null ? '' : map['hobi_pic'];
    fb = map['akun_fb_pic'] == null ? '' : map['akun_fb_pic'];
    ig = map['akun_ig_pic'] == null ? '' : map['akun_ig_pic'];
    tglLahir = DateUtility.stringToDateTime(map['tgl_lahir_pic']);
  }

  String? getNama() {
    return nama == null ? '-' : nama;
  }

  String? getNohp() {
    return nohp == null ? '-' : nohp;
  }

  String getTglLahir() {
    return tglLahir == null ? '-' : DateUtility.dateToStringDdMmYyyy(tglLahir);
  }

  String? getHobi() {
    return hobi == null ? '-' : hobi;
  }

  String? getFb() {
    return fb == null ? '-' : fb;
  }

  String? getIg() {
    return ig == null ? '-' : ig;
  }
}
