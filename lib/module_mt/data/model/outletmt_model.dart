import 'package:hero/core/domain/entities/tgzlocation.dart';
import 'package:hero/module_mt/domain/entity/outlet_mt.dart';

class OutletMTData extends OutletMT {
  TgzLocationData? locationData;
  int? radiusValid;
  OutletMTData({
    required String idDigipos,
    required String idOutlet,
    required String namaOutlet,
  }) : super(idDigipos: idDigipos, idOutlet: idOutlet, namaOutlet: namaOutlet);

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

  factory OutletMTData.fromJson(Map<String, dynamic> json) {
    OutletMTData data = OutletMTData(
        idDigipos: json['id_digipos'] ?? '',
        idOutlet: json['id_outlet'] ?? '',
        namaOutlet: json['nama_outlet'] ?? '');
    data.setLocation(json['longitude'] ?? '', json['latitude'] ?? '');
    data.setRadius(json['radius_clock_in'] ?? '');

    return data;
  }
}
