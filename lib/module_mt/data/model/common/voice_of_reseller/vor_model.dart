import 'package:hero/module_mt/domain/entity/common/voice_of_retailer/pertanyaan.dart';
import 'package:hero/module_mt/domain/entity/common/voice_of_retailer/voice_of_reseller.dart';

import '../../../../../util/dateutil.dart';

class VoiceOfResellerModel extends VoiceOfReseller {
  VoiceOfResellerModel(VoiceOfReseller vor)
      : super(lPertanyaan: vor.lPertanyaan) {
    super.pathVideo = vor.pathVideo;
  }

  Map<String, dynamic> toMap(String idOutlet) {
    Map<String, dynamic> map = {};
    for (Pertanyaan item in lPertanyaan) {
      map[item.idPertanyaan] = item.terpilih;
    }
    map['id_outlet'] = idOutlet;
    return map;
  }
}
