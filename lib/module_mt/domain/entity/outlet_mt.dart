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
}
