import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/question.dart';

class QuestionModel extends Question {
  QuestionModel(
      {required String idPertanyaan,
      required String pertanyaan,
      required bool isYes})
      : super(idPertanyaan: idPertanyaan, pertanyaan: pertanyaan, isYes: isYes);

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
        idPertanyaan: json['id_parameter'] ?? '',
        pertanyaan: json['parameter'] ?? '',
        isYes: false);
  }
}
