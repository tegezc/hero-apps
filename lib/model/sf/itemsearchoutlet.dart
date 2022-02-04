import 'package:hero/model/enumapp.dart';
import 'package:hero/util/dateutil.dart';

class LokasiSearch {
  String? namapembeli;
  String? nohppembeli;
  DateTime? tgl;

  String? nonota;
  String? idoutlet;
  String? idjnslokasi;

  // nama_outlet":"YOKA CELL","
  // ""tgl":"2020-12-29","
  // ""id_outlet":"4950"
  /// atau
  // "no_nota": "SSF0440K-2",
  // "tgl_transaksi": "2020-12-28",
  // "nama_pembeli": "HARIAN CELL",
  // "no_hp_pembeli": "82280521988"

  LokasiSearch.fromJson(Map<String, dynamic> map) {
    if (map['id_outlet'] != null) {
      idoutlet = map['id_outlet'];
    } else if (map['id_tempat'] != null) {
      idoutlet = map['id_tempat'];
    } else if (map['id'] != null) {
      idoutlet = map['id'];
    }

    idjnslokasi = map['id_jenis_lokasi'] ?? '';

    if (map['nama_pembeli'] == null) {
      if (map['nama_outlet'] == null) {
        namapembeli = map['nama'] ?? '';
      } else {
        namapembeli = map['nama_outlet'];
      }
    } else {
      namapembeli = map['nama_pembeli'];
    }
    nohppembeli = map['no_hp_pembeli'] ?? '';
    nonota = map['no_nota'] ?? '';
    if (map['tgl'] == null) {
      if (map['tgl_transaksi'] == null) {
        tgl = DateUtility.stringToDateTime(map['tanggal']);
      } else {
        tgl = DateUtility.stringToDateTime(map['tgl_transaksi']);
      }
    } else {
      tgl = DateUtility.stringToDateTime(map['tgl']);
    }
  }

  EnumJenisLokasi? getJenisLokasi() {
    EnumJenisLokasi? enumJenisLokasi;
    switch (idjnslokasi) {
      case 'OUT':
        enumJenisLokasi = EnumJenisLokasi.outlet;
        break;
      case 'POI':
        enumJenisLokasi = EnumJenisLokasi.poi;
        break;
      case 'SEK':
        enumJenisLokasi = EnumJenisLokasi.sekolah;
        break;
      case 'KAM':
        enumJenisLokasi = EnumJenisLokasi.kampus;
        break;
      case 'FAK':
        enumJenisLokasi = EnumJenisLokasi.fakultas;
        break;
    }
    return enumJenisLokasi;
  }

  String getStrTgl() {
    if (tgl == null) {
      return '';
    }
    return DateUtility.dateToStringDdMmYyyy(tgl);
  }
}
