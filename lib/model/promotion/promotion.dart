import 'package:hero/model/pjp.dart';

class Promotion {
  String? idjnsweekly;
  String? idpromotion;
  String? nama;
  String? nmlocal;
  late bool isVideoExist;
  String? pathVideo;
  late Pjp pjp;

  // "id_jenis_weekly": "9",
  // "nama_jenis": "COMBO SAKTI"

  Promotion.fromJson(Map<String, dynamic> map) {
    isVideoExist = false;
    idjnsweekly = map['id_jenis_weekly'] == null ? '' : map['id_jenis_weekly'];
    nama = map['nama_jenis'] == null ? '' : map['nama_jenis'];
  }

  // "id_promotion":"1",
  // "nama_jenis":"PROGRAM LOKAL",
  // "nama_program_lokal":"test",
  // "file_video":"http:\/\/channelsumbagsel.com\/apihore\/assets\/promotion_video\/35_8.mp4"

  Promotion.fromJsonDetail(Map<String, dynamic> map) {
    isVideoExist = true;
    idpromotion = map['id_promotion'] == null ? '' : map['id_promotion'];
    nama = map['nama_jenis'] == null ? '' : map['nama_jenis'];

    nmlocal =
        map['nama_program_lokal'] == null ? '' : map['nama_program_lokal'];
    pathVideo = map['file_video'];
  }

  Map<String, dynamic> toJson() {
    String? nm = nmlocal == null ? "" : nmlocal;

    return {
      "id_tempat": pjp.id,
      "id_jenis_weekly": idjnsweekly,
      "nama_program_lokal": nm
    };
  }
}
