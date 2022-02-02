import 'package:hero/module_mt/domain/entity/common/voice_of_retailer/jawaban.dart';

class JawabanModel extends Jawaban {
  JawabanModel({required String idJawaban, required String jawaban})
      : super(idJawaban: idJawaban, jawaban: jawaban);

  factory JawabanModel.fromJson(Map<String, dynamic> json) {
    return JawabanModel(
        idJawaban: json['id_pilihan'] ?? '', jawaban: json['pilihan'] ?? '');
  }
}
