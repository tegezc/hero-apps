import 'package:hero/model/enumapp.dart';
import 'package:hero/model/tempat.dart';
import 'package:hero/util/dateutil.dart';
import 'package:hero/util/numberconverter.dart';

/// json dari pjp hari ini
// "no_kunjungan": "1",
// "id_jenis_lokasi": "OUT",
// "id_tempat": "18",
// "id_digipos": "1300024051",
// "nama_outlet": "RORIANTI CELL",
// "no_hp_owner": "087876564325",
// "longitude": "-122.084",
// "latitude": "37.4219983",
// "jam_clock_in": null,
// "jam_clock_out": null,
// "id_kabupaten": "KAB027",
// "nama_kabupaten": "BELITUNG TIMUR",
// "radius_clock_in": "5"

var m = {
  "id_sales": "SSF0440",
  "id_tempat": "3626",
  "id_jenis_lokasi": "OUT",
  "id_pjp": "1",
  "hari": "SENIN",
  "no_kunjungan": "1",
  "lastmodified": "2020-12-25 14:18:01",
  "tanggal": "2020-12-28",
  "nama": "81273311819-SINTA CELL",
  "longitude": "106.1674669",
  "latitude": "-2.2800254",
  "id_kelurahan": "KLH8749",
  "no_hp_owner": "81273311819",
  "nama_kabupaten": "BANGKA TENGAH",
  "radius_clock_in": "2",
  "jam_clock_in": null,
  "jam_clock_out": null,
  "status": "OPEN" //bisa OPEN, CLOSE, START, FINISH, null,
};

/// json dari history pjp
var d1 = {
  "tanggal": "2020-12-22",
  "jam_clock_in": "09:00:00",
  "jam_clock_out": "09:20:00",
  "status": "OPEN"
};

class Pjp {
  Pjp.fromJsonHistory(Map<String, dynamic> map) {
    DateTime? dt = DateUtility.stringToDateTime(map['tanggal']);
    if (dt != null) {
      clockin = DateUtility.stringToJam(map['jam_clock_in'], dt);
      clockout = DateUtility.stringToJam(map['jam_clock_out'], dt);
    }

    status = map['status'] == null ? null : map['status'];
  }

  String? id;
  int? nokunjungan;
  String? nohp;
  DateTime? clockin;
  DateTime? clockout;
  double? long;
  double? lat;
  String? status;
  int? radius;

  // - OUT : outlet
  // - SEK : sekolah
  // - FAK : fakultas
  // - KAM : kampus
  // - POI : poi
  String? idjenilokasi;

  Tempat? tempat;
  EnumStatusTempat? enumStatusTempat;
  EnumPjp? enumPjp;

  Pjp(this.clockin, this.clockout, this.tempat, this.enumStatusTempat);

  Pjp.fromJson(Map<String, dynamic> map) {
    id = map['id_tempat'] == null ? '' : map['id_tempat'];
    nokunjungan = ConverterNumber.stringToInt(map['no_kunjungan']);
    nohp = map['no_hp_owner'] == null ? '' : '${map['no_hp_owner']}';
    radius = ConverterNumber.stringToInt(map['radius_clock_in']);
    idjenilokasi = map['id_jenis_lokasi'] == null ? '' : map['id_jenis_lokasi'];

    clockin = DateUtility.stringToJam(map['jam_clock_in'], DateTime.now());
    clockout = DateUtility.stringToJam(map['jam_clock_out'], DateTime.now());

    lat = ConverterNumber.stringToDouble(map['latitude']);
    long = ConverterNumber.stringToDouble(map['longitude']);
    tempat = Tempat.kosong();
    tempat!.id = map['id_digipos'] == null ? '' : map['id_digipos'];
    tempat!.nama = map['nama'] == null ? '' : map['nama'];
    status = map['status'] == null ? null : map['status'];

    print('nohp: $nohp');
  }

  EnumJenisLokasi? getJenisLokasi() {
    EnumJenisLokasi? enumJenisLokasi;
    switch (this.idjenilokasi) {
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

  bool isAlreadyClockIn() {
    if (clockin != null && clockout == null) {
      return true;
    }
    return false;
  }

  bool isStatusDone() {
    if (clockout != null) {
      return true;
    }
    return false;
  }
}
