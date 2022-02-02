import 'package:hero/module_mt/domain/entity/common/voice_of_retailer/jawaban.dart';
import 'package:hero/module_mt/domain/entity/common/voice_of_retailer/pertanyaan.dart';

class PertanyaanModel extends Pertanyaan {
  PertanyaanModel(
      {required String idPertanyaan,
      required String pertanyaan,
      required List<Jawaban> lJawaban})
      : super(
            idPertanyaan: idPertanyaan,
            pertanyaan: pertanyaan,
            lJawaban: lJawaban);

  factory PertanyaanModel.fromJson(
      Map<String, dynamic> json, List<Jawaban> lJawaban) {
    return PertanyaanModel(
        idPertanyaan: json['id_pertanyaan'] ?? '',
        pertanyaan: json['pertanyaan'] ?? '',
        lJawaban: lJawaban);
  }
}
