import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/availability.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/param_penilaian.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/question.dart';

class AvailabilityModel extends Availability {
  AvailabilityModel(Availability av)
      : super(
            perdanaTelkomsel: av.perdanaTelkomsel,
            perdanaOther: av.perdanaOther,
            fisikTelkomsel: av.fisikTelkomsel,
            fisikOther: av.fisikOther,
            question: av.question) {
    super.pathPhotoOperator = av.pathPhotoOperator;
    super.pathPhotoVF = av.pathPhotoVF;
  }

  Map<String, dynamic> toMapForSubmit(
    String idoutlet,
  ) {
    Map<String, dynamic> map = {};
    for (ParamPenilaian item in perdanaTelkomsel.lparams) {
      map[item.idparam] = item.nilai;
    }
    for (ParamPenilaian item in perdanaOther.lparams) {
      map[item.idparam] = item.nilai;
    }
    for (Question item in question.lquestion) {
      map[item.idPertanyaan] = item.isYes ? 'ya' : 'tidak';
    }
    map['id_outlet'] = idoutlet;

    return map;
  }
}
