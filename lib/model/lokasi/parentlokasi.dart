import 'lokasimodel.dart';

class ParentLokasi {
  Provinsi? prov;
  Kabupaten? kab;
  Kecamatan? kec;
  Kelurahan? kel;

  String? getStrProv() {
    return prov == null ? '-' : prov!.nama;
  }

  String? getStrKab() {
    return kab == null ? '-' : kab!.nama;
  }

  String? getStrKec() {
    return kec == null ? '-' : kec!.nama;
  }

  String? getStrKel() {
    return kel == null ? '-' : kel!.nama;
  }

  bool isValid() {
    return true;
  }

  bool cstr(String? str) {
    if (str != null) {
      if (str.isNotEmpty) {
        return true;
      }
    }
    return false;
  }

  bool lengthstr(String? str) {
    if (str != null) {
      if (str.length >= 10) {
        return true;
      }
    }
    return false;
  }
}
