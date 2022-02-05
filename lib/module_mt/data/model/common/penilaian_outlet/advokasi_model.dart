import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/advokasi.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/question.dart';

import '../../../../../util/dateutil.dart';

class AdvokasiModel extends Advokasi {
  AdvokasiModel(Advokasi advokasi) : super(lquestions: advokasi.lquestions);

  Map<String, dynamic> toMap(String idOutlet) {
    Map<String, dynamic> map = {};
    for (Question item in lquestions) {
      map[item.idPertanyaan] = item.isYes ? "ya" : "tidak";
    }
    map['id_outlet'] = idOutlet;
    map['tanggal'] = DateUtility.dateToStringYYYYMMDD(DateTime.now());
    return map;
  }
}
