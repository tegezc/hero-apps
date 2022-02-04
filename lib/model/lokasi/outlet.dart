import 'package:hero/model/lokasi/pic.dart';
import 'package:hero/util/dateutil.dart';
import 'package:hero/util/numberconverter.dart';

import '../enumapp.dart';
import 'owner.dart';
import 'parentlokasi.dart';

/// {
//         "id_kecamatan": "KEC002",
//         "id_kelurahan": "",
//         "id_jenis_outlet": "2",
//         "id_tap": "TAP001",
//         "id_outlet": "2",
//         "id_digipos": "1",
//         "nama_outlet": "OUTLET 2 EDIT",
//         "alamat_outlet": "ALAMAT 2 EDIT",
//         "longitude": "LONG 1 EDIT",
//         "latitude": "LAT 1 EDIT",
//         "no_rs": "NO RS 1 EDIT",
//         "status": "WAITING APPROVAL",
//         "nama_owner": "Suparman",
//         "no_hp_owner": "NO HP OWNER 1 EDIT",
//         "tgl_lahir_owner": "2021-01-01",
//         "hobi_owner": "HOBI OWNER 1 EDIT",
//         "akun_fb_owner": "AKUN FB OWNER 1 EDIT",
//         "akun_ig_owner": "AKUN IG OWNER 1 EDIT",
//         "nama_pic": "NAMA PIC 1 EDIT",
//         "no_hp_pic": "NO HP PIC 1 EDIT",
//         "tgl_lahir_pic": "2021-02-02",
//         "hobi_pic": "HOBI PIC 1 EDIT",
//         "akun_fb_pic": "AKUN FB PIC 1 EDIT",
//         "akun_ig_pic": "AKUN IG PIC 1 EDIT",
//         "tgl_open": "2020-11-24",
//         "tgl_close": null,
//         "tgl_waiting": "2020-11-24",
//         "tgl_approval": null,
//         "created_by": "SSF001",
//         "approval_by": null,
//         "lastmodified": "2020-11-24 09:07:44",
//         "nama_kecamatan": "PINORAYA",
//         "nama_kelurahan": null,
//         "nama_tap": "TAP Curup"
//     }
class Outlet extends ParentLokasi {
  @override
  bool isValid() {
    // ph('$idkelurahan\n$nors\n$nama\n$alamat\n$idJnsOutlet\n$long\n$lat');
    if (cstr(idkelurahan) &&
        cstr(nors) &&
        cstr(nama) &&
        cstr(alamat) &&
        idJnsOutlet! > 0 &&
        owner!.isValid() &&
        long != 0 &&
        lat != 0) {
      if (lengthstr(alamat)) {
        return true;
      }
    }
    return false;
  }

  String? idprov;
  String? idkab;
  String? idkec;
  String? idkelurahan;
  int? idJnsOutlet;
  String? idtap;
  String? idoutlet;
  String? iddigipos;
  String? nama;
  String? alamat;
  double? long;
  double? lat;
  String? nors;
  String? status;
  DateTime? tglopen;
  DateTime? tglClose;
  DateTime? tglWaiting;
  DateTime? tglApproval;
  String? idsales;
  String? approvalBy;
  DateTime? lastmodified;
  String? namaTap;

  Pic? pic;
  Owner? owner;
  //
  // Provinsi prov;
  // Kabupaten kab;
  // Kecamatan kec;
  // Kelurahan kel;

  Outlet.kosong();

  // Wajib Diisi :
  // id_kecamatan, id_jenis_outlet, nama_outlet, alamat_outlet, longitude, latitude, no_rs,
  // nama_owner, no_hp_owner, tgl_lahir_owner
  Outlet.wajib(this.idkec, this.idJnsOutlet, this.nama, this.alamat, this.long,
      this.lat, this.nors, this.owner);
  Outlet.lengkap(this.idkec, this.idJnsOutlet, this.nama, this.alamat,
      this.long, this.lat, this.nors, this.owner,
      {this.idtap,
      this.idoutlet,
      this.iddigipos,
      this.status,
      this.tglApproval,
      this.tglopen,
      this.tglClose,
      this.tglWaiting,
      this.idsales,
      this.approvalBy,
      this.lastmodified,
      this.namaTap,
      this.pic});

  Outlet.fromJson(Map<String, dynamic> map) {
    String strlong = map[tagLong] ?? '0';
    if (strlong.isNotEmpty) {
      long = double.tryParse(strlong);
    } else {
      long = 0.0;
    }

    String strlat = map[tagLat] ?? '0';
    if (strlat.isNotEmpty) {
      lat = double.tryParse(strlat);
    } else {
      lat = 0.0;
    }

    if (map['id_kecamatan'] == null) {
      idkec = '';
    } else {
      idkec = map['id_kecamatan'];
    }
    idkelurahan = map['id_kelurahan'] ?? '';
    idJnsOutlet = map['id_jenis_outlet'] == null
        ? 1
        : int.tryParse(map['id_jenis_outlet']);
    idtap = map['id_tap'] ?? '';
    idoutlet = map['id_outlet'] ?? '';
    iddigipos = map['id_digipos'] ?? '';
    nama = map['nama_outlet'] ?? '';
    alamat = map['alamat_outlet'] ?? '';
    nors = map['no_rs'] ?? '';
    status = map['status'] ?? '';
    tglopen = DateUtility.stringToDateTime(map['tgl_open']);
    tglClose = DateUtility.stringToDateTime(map['tgl_close']);
    tglWaiting = DateUtility.stringToDateTime(map['tgl_waiting']);
    tglApproval = DateUtility.stringToDateTime(map['tgl_approval']);
    idsales = map['created_by'] ?? '';
    approvalBy = map['approval_by'] ?? '';
    lastmodified = DateUtility.stringLongToDateTime(map['lastmodified']);
    namaTap = map['nama_tap'] ?? '';

    pic = Pic.fromJson(map);
    owner = Owner.fromJson(map, tagNmOwner, tagNoHpOwner, tagTglLahirOwner,
        tagHobiOw, tagFbOw, tagIgOw);
  }

  static const String tagIdKel = 'id_kelurahan';
  static const String tagIdKec = 'id_kecamatan';
  static const String tagIdJnsOutlet = 'id_jenis_outlet';
  static const String tagIdDigipos = 'id_digipos';
  static const String tagNama = 'nama_outlet';
  static const String tagAlamat = 'alamat_outlet';
  static const String tagLong = 'longitude';
  static const String tagLat = 'latitude';
  static const String tagNoRs = 'no_rs';
  static const String tagNmOwner = 'nama_owner';
  static const String tagNoHpOwner = 'no_hp_owner';
  static const String tagTglLahirOwner = 'tgl_lahir_owner';
  static const String tagHobiOw = 'hobi_owner';
  static const String tagFbOw = 'akun_fb_owner';
  static const String tagIgOw = 'akun_ig_owner';
  static const String tagNmPic = 'nama_pic';
  static const String tagHpPic = 'no_hp_pic';
  static const String tagTglLahirPic = 'tgl_lahir_pic';
  static const String tagHobiPic = 'hobi_pic';
  static const String tabFbPic = 'akun_fb_pic';
  static const String tagIgPic = 'akun_ig_pic';

  Map toJson() {
    return {
      //   tagIdKec:idkec,
      //     tagIdKec: idkec,
      tagIdKel: idkelurahan,
      tagIdJnsOutlet: idJnsOutlet,
      tagIdDigipos: iddigipos,
      tagNama: nama,
      tagAlamat: alamat,
      tagLong: long,
      tagLat: lat,
      tagNoRs: nors ?? '9999',
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

  int getJenisOutletByEnum(EnumJenisOutlet? enumJenisOutlet) {
    switch (enumJenisOutlet) {
      case EnumJenisOutlet.device:
        return 1;
      case EnumJenisOutlet.reguler:
        return 2;
      case EnumJenisOutlet.pareto:
        return 3;
      default:
    }
    return 1;
  }

  String getStrJenisOutlet() {
    switch (idJnsOutlet) {
      case 1:
        return 'Device';
      case 2:
        return 'Reguler';
      case 3:
        return 'Paretor';
    }
    return '';
  }

  EnumJenisOutlet? getEnumJenisOUtlet() {
    if (idJnsOutlet == 1) {
      return EnumJenisOutlet.device;
    } else if (idJnsOutlet == 2) {
      return EnumJenisOutlet.reguler;
    } else if (idJnsOutlet == 3) {
      return EnumJenisOutlet.pareto;
    } else {
      return null;
    }
  }
}

class ItemComboJenisOutlet {
  EnumJenisOutlet? enumJenisOutlet;
  String? text;

  ItemComboJenisOutlet(this.enumJenisOutlet, this.text);

  // {"id_jenis_outlet":"1","nama_jenis_outlet":"DEVICE"}
  ItemComboJenisOutlet.fromJson(Map<String, dynamic> map) {
    int? i = ConverterNumber.stringToIntOrZero(map['id_jenis_outlet']);

    if (i == 1) {
      enumJenisOutlet = EnumJenisOutlet.device;
    } else if (i == 2) {
      enumJenisOutlet = EnumJenisOutlet.reguler;
    } else if (i == 3) {
      enumJenisOutlet = EnumJenisOutlet.pareto;
    } else {
      enumJenisOutlet = null;
    }

    text = map['nama_jenis_outlet'] ?? '';
  }
  @override
  bool operator ==(dynamic other) =>
      other != null &&
      other is ItemComboJenisOutlet &&
      enumJenisOutlet == other.enumJenisOutlet;
}
