import 'package:hero/module_mt/domain/entity/common/voice_of_retailer/jawaban.dart';

class Pertanyaan {
  final String idPertanyaan;
  final String pertanyaan;
  final List<Jawaban> lJawaban;
  Jawaban? terpilih;

  Pertanyaan(
      {required this.idPertanyaan,
      required this.pertanyaan,
      required this.lJawaban,
      this.terpilih});
}
