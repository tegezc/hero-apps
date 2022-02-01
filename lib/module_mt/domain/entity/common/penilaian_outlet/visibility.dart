import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/question.dart';

import 'kategories.dart';

class PenilaianVisibility {
  Question questionAtas;
  Kategories kategoriesPoster;
  Kategories kategoriesLayar;
  Question questionBawah;

  PenilaianVisibility(
      {required this.questionAtas,
      required this.kategoriesPoster,
      required this.kategoriesLayar,
      required this.questionBawah});
}
