import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/param_penilaian.dart';

import 'kategories.dart';
import 'questions.dart';

class Availability {
  Kategories perdanaTelkomsel;
  Kategories perdanaOther;
  Kategories fisikTelkomsel;
  Kategories fisikOther;
  Questions question;
  String? pathPhotoOperator;
  String? pathPhotoVF;

  Availability(
      {required this.perdanaTelkomsel,
      required this.perdanaOther,
      required this.fisikTelkomsel,
      required this.fisikOther,
      required this.question});

  bool isValidToSubmit() {
    if (pathPhotoOperator == null || pathPhotoVF == null) {
      return false;
    }

    if (perdanaTelkomsel.lparams.isEmpty ||
        perdanaOther.lparams.isEmpty ||
        question.lquestion.isEmpty) {
      return false;
    }
    bool cekParam = _checkListParams(perdanaTelkomsel.lparams);
    if (cekParam) {
      cekParam = _checkListParams(perdanaOther.lparams);
    }
    return cekParam;
  }

  bool _checkListParams(List<ParamPenilaian> lParams) {
    for (ParamPenilaian p in lParams) {
      if (!p.isValidToSubmit()) {
        return false;
      }
    }
    return true;
  }
}
