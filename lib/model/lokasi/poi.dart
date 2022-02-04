import 'parentlokasi.dart';

class Poi extends ParentLokasi {
  String? idpoi;
  String? idkel;
  String? nama;
  String? alamat;
  double? lat;
  double? long;

  @override
  bool isValid() {
    if (cstr(idkel) && cstr(nama) && cstr(alamat) && long != 0 && lat != 0) {
      if (lengthstr(alamat)) {
        return true;
      }
    }
    return false;
  }

  Poi.kosong();

  Poi.fromJson(Map<String, dynamic> map) {
    // "id_kelurahan" : "KLH6906",
    // "nama_poi" : "POI 11",
    // "alamat_poi" : "ALAMAT 11",
    // "longitude" : "LONG 11",
    // "latitude" : "LAT 11"
    // "id_tap": "TAP001",
    // "id_poi": "2",
    // "status": "WAITING APPROVAL",
    // "tgl_open": null,
    // "tgl_close": null,
    // "tgl_waiting": "2020-11-30",
    // "tgl_approval": null,
    // "created_by": "SDS001",
    // "approval_by": null,
    // "lastmodified": "2020-11-30 11:03:46",
    // "nama_kelurahan": "TOTOHARJO",
    // "id_kecamatan": "KEC301",
    // "nama_kecamatan": "BAKAUHENI",
    // "nama_tap": "TAP KALIANDA"
    idpoi = map['id_poi'] ?? '';
    idkel = map['id_kelurahan'] ?? '';
    nama = map['nama_poi'] ?? '';
    alamat = map['alamat_poi'] ?? '';
    if (map['longitude'] == null) {
      long = 0.0;
    } else {
      long = double.tryParse(map['longitude']) ?? 0.0;
    }

    if (map['latitude'] == null) {
      lat = 0.0;
    } else {
      lat = double.tryParse(map['latitude']) ?? 0.0;
    }
  }

  Map toJson() {
    return {
      "id_kelurahan": idkel,
      "nama_poi": nama,
      "alamat_poi": alamat,
      "longitude": long,
      "latitude": lat
    };
  }
}
