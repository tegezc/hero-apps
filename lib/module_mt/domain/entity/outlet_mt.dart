import 'package:hero/core/data/datasources/database/stringdb.dart';
import 'package:hero/core/domain/entities/tgzlocation.dart';

class OutletMT {
  String idOutlet;
  String idDigipos;
  String namaOutlet;
  TgzLocationData? location;
  int? radiusClockIn;

  OutletMT(
      {required this.idDigipos,
      required this.idOutlet,
      required this.namaOutlet,
      this.location,
      this.radiusClockIn});

  bool isValid() {
    if (location != null && radiusClockIn != null) {
      if (idDigipos.isNotEmpty &&
          idOutlet.isNotEmpty &&
          namaOutlet.isNotEmpty) {
        return true;
      }
    }
    return false;
  }
}
