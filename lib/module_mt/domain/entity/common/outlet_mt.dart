import 'package:hero/core/domain/entities/tgzlocation.dart';

class OutletMT {
  final String idOutlet;
  final String idDigipos;
  final String namaOutlet;
  final String noRs;
  final String idSales;
  final String namaSales;
  TgzLocationData? location;
  int? radiusClockIn;

  OutletMT(
      {required this.idDigipos,
      required this.idOutlet,
      required this.namaOutlet,
      required this.noRs,
      required this.idSales,
      required this.namaSales,
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
