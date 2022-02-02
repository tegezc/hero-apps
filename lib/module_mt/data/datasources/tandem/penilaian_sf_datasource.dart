import 'package:dio/dio.dart';
import 'package:hero/module_mt/data/datasources/core/dio_config.dart';
import 'package:hero/module_mt/data/model/tandem/pertanyaan_sf_model.dart';
import 'package:hero/module_mt/domain/entity/tandem_selling/penilaian_sf.dart';
import 'package:hero/module_mt/domain/entity/tandem_selling/pertanyaan_sf.dart';

abstract class PenilaianSfDataSource {
  Future<PenilaianSf?> getData(String idSf);
}

class PenilaianSfDataSourceImpl implements PenilaianSfDataSource {
  @override
  Future<PenilaianSf?> getData(String idSf) async {
    Dio dio = await GetDio().dio();
    var response = await dio.get('/penilaiansf/penilaian/$idSf');

    return _olahJson(response.data);
  }

  PenilaianSf? _olahJson(dynamic json) {
    Map<String, dynamic> map1 = json;
    Map<String, dynamic> map2 = map1['data'];
    Map<String, dynamic> mapPersonality = map2['Personality'];
    Map<String, dynamic> mapDistribution = map2['Distribution'];
    Map<String, dynamic> mapMerch = map2['Merchandising'];
    Map<String, dynamic> mapPromotion = map2['Promotion'];

    List<PertanyaanSf>? personalities = _olahJsonListPertanyaan(mapPersonality);
    List<PertanyaanSf>? distribution = _olahJsonListPertanyaan(mapDistribution);
    List<PertanyaanSf>? merchandising = _olahJsonListPertanyaan(mapMerch);
    List<PertanyaanSf>? promotion = _olahJsonListPertanyaan(mapPromotion);

    return PenilaianSf(
        personalities: personalities ?? [],
        distribution: distribution ?? [],
        merchandising: merchandising ?? [],
        promotion: promotion ?? []);
  }

  List<PertanyaanSf>? _olahJsonListPertanyaan(Map<String, dynamic> map) {
    List<PertanyaanSf> lSf = [];
    try {
      List<dynamic> ld = map['parameter'];
      for (var i = 0; i < ld.length; i++) {
        Map<String, dynamic> mapPertanyaan = ld[i];
        PertanyaanSf pertanyaanSf = PertanyaanSfModel.fromJson(mapPertanyaan);
        lSf.add(pertanyaanSf);
      }
      return lSf;
    } catch (e) {
      return null;
    }
  }
}
