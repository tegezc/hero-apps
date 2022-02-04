import 'package:hero/util/dateutil.dart';

///         "nama_owner": "Suparman",
///         "no_hp_owner": "NO HP OWNER 1 EDIT",
///         "tgl_lahir_owner": "2021-01-01",
///         "hobi_owner": "HOBI OWNER 1 EDIT",
///         "akun_fb_owner": "AKUN FB OWNER 1 EDIT",
///         "akun_ig_owner": "AKUN IG OWNER 1 EDIT",
class Owner {
  String? nama;
  String? nohp;
  DateTime? tglLahir;
  String? hobi;
  String? fb;
  String? ig;

  bool isValid() {
    if (_cstr(nama) && _cstr(nohp) && tglLahir != null) {
      return true;
    }
    return false;
  }

  bool _cstr(String? str) {
    if (str != null) {
      if (str.isNotEmpty) {
        return true;
      }
    }
    return false;
  }

  Owner.kosong();

  Owner.fromJson(Map<String, dynamic> map, String tagnm, String tagnohp,
      String tagtgllahir, String taghobi, String tagfb, String tagig) {
    tglLahir = DateUtility.stringToDateTime(map[tagtgllahir]);
    nama = map[tagnm] ?? '';
    nohp = map[tagnohp] ?? '';
    hobi = map[taghobi] ?? '';
    fb = map[tagfb] ?? '';
    ig = map[tagig] ?? '';
  }

// nama_owner, no_hp_owner, tgl_lahir_owner
  Owner.wajib(this.nama, this.nohp, this.tglLahir);

  String? getNama() {
    return nama ?? '-';
  }

  String? getNohp() {
    return nohp ?? '-';
  }

  String getTglLahir() {
    return tglLahir == null ? '-' : DateUtility.dateToStringDdMmYyyy(tglLahir);
  }

  String? getHobi() {
    return hobi ?? '-';
  }

  String? getFb() {
    return fb ?? '-';
  }

  String? getIg() {
    return ig ?? '-';
  }
}
