import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/param_penilaian.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/question.dart';

import 'kategories.dart';

class PenilaianVisibility {
  Question questionAtas;
  Kategories kategoriesPoster;
  Kategories kategoriesLayar;
  Question questionBawah;
  String? imageEtalase;
  String? imagePoster;
  String? imageLayar;

  PenilaianVisibility(
      {required this.questionAtas,
      required this.kategoriesPoster,
      required this.kategoriesLayar,
      required this.questionBawah});

  bool isValidToSubmit() {
    if (imageEtalase == null || imagePoster == null || imageLayar == null) {
      return false;
    }

    if (kategoriesPoster.lparams.isEmpty || kategoriesLayar.lparams.isEmpty) {
      return false;
    }
    bool cekParam = _checkListParams(kategoriesPoster.lparams);
    if (cekParam) {
      cekParam = _checkListParams(kategoriesLayar.lparams);
    }
    return true; //cekParam;
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
