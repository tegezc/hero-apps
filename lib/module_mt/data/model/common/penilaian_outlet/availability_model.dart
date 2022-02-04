import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/availability.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/param_penilaian.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/question.dart';
import 'package:hero/util/dateutil.dart';

class AvailabilityModel extends Availability {
  AvailabilityModel(Availability av)
      : super(
            kategoriOperator: av.kategoriOperator,
            kategoriVF: av.kategoriVF,
            question: av.question) {
    super.pathPhotoOperator = av.pathPhotoOperator;
    super.pathPhotoVF = av.pathPhotoVF;
  }

  Map<String, dynamic> toMap(
    String idoutlet,
  ) {
    Map<String, dynamic> map = {};
    for (ParamPenilaian item in kategoriOperator.lparams) {
      map[item.idparam] = item.nilai;
    }
    for (ParamPenilaian item in kategoriVF.lparams) {
      map[item.idparam] = item.nilai;
    }
    for (Question item in question.lquestion) {
      map[item.idPertanyaan] = item.isYes ? 'ya' : 'tidak';
    }
    map['id_outlet'] = idoutlet;
    map['tanggal'] = DateUtility.dateToStringYYYYMMDD(DateTime.now());
    return map;
  }
}
