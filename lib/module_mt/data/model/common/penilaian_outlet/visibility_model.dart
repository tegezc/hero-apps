import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/visibility.dart';

import '../../../../../util/dateutil.dart';
import '../../../../domain/entity/common/penilaian_outlet/param_penilaian.dart';

class VisibilityModel extends PenilaianVisibility {
  VisibilityModel(PenilaianVisibility visibility)
      : super(
            questionAtas: visibility.questionAtas,
            kategoriesPoster: visibility.kategoriesPoster,
            kategoriesLayar: visibility.kategoriesLayar,
            questionBawah: visibility.questionBawah) {
    super.imageEtalase = visibility.imageEtalase;
    super.imagePoster = visibility.imagePoster;
    super.imageLayar = visibility.imageLayar;
  }

  Map<String, dynamic> toMapForSubmit(
    String idoutlet,
  ) {
    Map<String, dynamic> map = {};
    for (ParamPenilaian item in kategoriesPoster.lparams) {
      map[item.idparam] = item.nilai;
    }
    for (ParamPenilaian item in kategoriesLayar.lparams) {
      map[item.idparam] = item.nilai;
    }
    map[questionAtas.idPertanyaan] = questionAtas.isYes ? 'ya' : 'tidak';
    map[questionBawah.idPertanyaan] = questionBawah.isYes ? 'ya' : 'tidak';
    map['myfile1'] = imageEtalase;
    map['myfile2'] = imagePoster;
    map['myfile3'] = imageLayar;
    map['id_outlet'] = idoutlet;
    map['tanggal'] = DateUtility.dateToStringYYYYMMDD(DateTime.now());
    return map;
  }
}
