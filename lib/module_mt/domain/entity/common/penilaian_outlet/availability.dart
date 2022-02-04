import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/param_penilaian.dart';

import 'kategories.dart';
import 'questions.dart';

class Availability {
  Kategories kategoriOperator;
  Kategories kategoriVF;
  Questions question;
  String? pathPhotoOperator;
  String? pathPhotoVF;

  Availability(
      {required this.kategoriOperator,
      required this.kategoriVF,
      required this.question});

  bool isValidToSubmit() {
    if (pathPhotoOperator == null || pathPhotoVF == null) {
      return false;
    }

    if (kategoriOperator.lparams.isEmpty ||
        kategoriVF.lparams.isEmpty ||
        question.lquestion.isEmpty) {
      return false;
    }
    bool cekParam = _checkListParams(kategoriOperator.lparams);
    if (cekParam) {
      cekParam = _checkListParams(kategoriVF.lparams);
    }
    return cekParam;
  }

  bool _checkListParams(List<ParamPenilaian> lParams) {
    for (ParamPenilaian p in kategoriOperator.lparams) {
      if (!p.isValidToSubmit()) {
        return false;
      }
    }
    return true;
  }
}
