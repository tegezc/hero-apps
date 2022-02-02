import 'package:hero/module_mt/domain/entity/tandem_selling/pertanyaan_sf.dart';

class PertanyaanSfModel extends PertanyaanSf {
  PertanyaanSfModel({required String idpertanyaan, required String pertanyaan})
      : super(idPertanyaan: idpertanyaan, pertanyaan: pertanyaan);

  factory PertanyaanSfModel.fromJson(Map<String, dynamic> json) {
    return PertanyaanSfModel(
        idpertanyaan: json['id_parameter'] ?? '',
        pertanyaan: json['parameter'] ?? '');
  }
}
