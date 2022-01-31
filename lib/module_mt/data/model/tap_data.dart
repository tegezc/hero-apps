import 'package:hero/module_mt/domain/entity/common/tap.dart';

class TapModel extends Tap {
  TapModel({required String idTp, required String nmTap})
      : super(idTap: idTp, namaTap: nmTap);

  factory TapModel.formJson(Map<String, dynamic> json) {
    return TapModel(nmTap: json['nama_tap'] ?? '', idTp: json['id_tap'] ?? '');
  }
}
