import 'package:dio/dio.dart';
import 'package:hero/module_mt/data/model/common/voice_of_reseller/jawaban_model.dart';
import 'package:hero/module_mt/data/model/common/voice_of_reseller/pertanyaan_model.dart';
import 'package:hero/module_mt/domain/entity/common/voice_of_retailer/jawaban.dart';
import 'package:hero/module_mt/domain/entity/common/voice_of_retailer/pertanyaan.dart';
import 'package:hero/module_mt/domain/entity/common/voice_of_retailer/voice_of_reseller.dart';

import 'core/dio_config.dart';

abstract class IVoiceOfResellerDatasource {
  Future<VoiceOfReseller?> getData(String idoutlet);
}

class VoiceOfResellerDatasourceImpl implements IVoiceOfResellerDatasource {
  @override
  Future<VoiceOfReseller?> getData(String idoutlet) async {
    Dio dio = await GetDio().dio();
    var response = await dio.get('/voiceofreseller/voiceof/$idoutlet');
    return _olahJson(response.data);
  }

  VoiceOfReseller _olahJson(dynamic json) {
    List<Pertanyaan> lPertanyaan = [];
    Map<String, dynamic> map = json;
    Map<String, dynamic> map2 = json['data'];
    for (var i = 1; i < map2.length; i++) {
      Map<String, dynamic> mapPertanyaan = map2['$i'];
      List<dynamic> lPilihan = mapPertanyaan['pilihan'];
      List<Jawaban> lJawaban = [];
      for (var j = 0; j < lPilihan.length; j++) {
        Map<String, dynamic> mJawaban = lPilihan[j];
        Jawaban jawaban = JawabanModel.fromJson(mJawaban);
        lJawaban.add(jawaban);
      }
      Pertanyaan pertanyaan = PertanyaanModel.fromJson(mapPertanyaan, lJawaban);
      lPertanyaan.add(pertanyaan);
    }
    return VoiceOfReseller(lPertanyaan: lPertanyaan);
  }
}
