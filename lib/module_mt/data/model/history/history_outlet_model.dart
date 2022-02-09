import 'package:hero/module_mt/domain/entity/history/outlet/history_outlet.dart';

class HistoryOutletModel extends HistoryOutlet {
  HistoryOutletModel(
      {required String idDigipos,
      required String namaOutlet,
      required String keterangan})
      : super(
            idDigipos: idDigipos,
            namaOutlet: namaOutlet,
            keterangan: keterangan);

  factory HistoryOutletModel.fromJson(Map<String, dynamic> json) {
    return HistoryOutletModel(
        idDigipos: json['id_digipos'] ?? '',
        namaOutlet: json['nama_outlet'] ?? '',
        keterangan: json['keterangan'] ?? '');
  }
}
