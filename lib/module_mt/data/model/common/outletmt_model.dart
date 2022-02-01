import 'package:hero/core/domain/entities/tgzlocation.dart';
import 'package:hero/module_mt/domain/entity/common/outlet_mt.dart';

class OutletMTData extends OutletMT {
  TgzLocationData? locationData;
  int? radiusValid;
  OutletMTData({
    required String idDigipos,
    required String idOutlet,
    required String namaOutlet,
    required String noRs,
    required String namaSales,
    required String idSales,
  }) : super(
            idDigipos: idDigipos,
            idOutlet: idOutlet,
            namaOutlet: namaOutlet,
            noRs: noRs,
            idSales: idSales,
            namaSales: namaSales);

  void setLocation(String slong, String slat) {
    double? long = double.tryParse(slong);
    double? lat = double.tryParse(slat);

    if (long != null && lat != null) {
      super.location = TgzLocationData(latitude: lat, longitude: long);
    }
  }

  void setRadius(String radius) {
    int? r = int.tryParse(radius);
    if (r != null) {
      super.radiusClockIn = r;
    }
  }

// "id_outlet": "54",
//       "id_digipos": "1300000004",
//       "nama_outlet": "OUTLET D",
//       "no_rs": "6282185172939",
//       "id_sales": "SSF0017",
//       "nama_sales": "NOFY",
//       "longitude": "106.7297109",
//       "latitude": "-6.3163768",
//       "radius_clock_in": "100"
  factory OutletMTData.fromJson(Map<String, dynamic> json) {
    OutletMTData data = OutletMTData(
        idDigipos: json['id_digipos'] ?? '',
        idOutlet: json['id_outlet'] ?? '',
        namaOutlet: json['nama_outlet'] ?? '',
        namaSales: json['nama_sales'] ?? '',
        noRs: json['no_rs'] ?? '',
        idSales: json['id_sales'] ?? '');
    data.setLocation(json['longitude'] ?? '', json['latitude'] ?? '');
    data.setRadius(json['radius_clock_in'] ?? '');

    return data;
  }
}
