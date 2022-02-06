import 'package:dio/dio.dart';
import 'package:hero/module_mt/data/datasources/core/dio_config.dart';
import 'package:hero/module_mt/data/model/tandem/nilai_sf_model.dart';
import 'package:hero/module_mt/data/model/tandem/penilaiansf_model.dart';
import 'package:hero/module_mt/data/model/tandem/pertanyaan_sf_model.dart';
import 'package:hero/module_mt/domain/entity/tandem_selling/penilaian_sf.dart';
import 'package:hero/module_mt/domain/entity/tandem_selling/pertanyaan_sf.dart';
import 'package:hero/module_mt/domain/entity/tandem_selling/static_nilai_sf.dart';

import '../../../../util/numberconverter.dart';

abstract class PenilaianSfDataSource {
  Future<PenilaianSf?> getData(String idSf);
  Future<bool> submit(PenilaianSf penilaianSf, String idsf);
  Future<bool> checkPenilaianSf(PenilaianSf penilaianSf, String idsf);
}

class PenilaianSfDataSourceImpl implements PenilaianSfDataSource {
  @override
  Future<PenilaianSf?> getData(String idSf) async {
    Dio dio = await GetDio().dio();
    var response = await dio.get('/penilaiansf/penilaian/SSF0018/$idSf');
    var responsePilihan = await dio.get('/penilaiansf/pilihan');

    return _olahJson(response.data, responsePilihan.data);
  }

  PenilaianSf? _olahJson(dynamic json, dynamic jsonPilihan) {
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
    List<NilaiSf>? lNilaiSf = _olahJsonPilihan(jsonPilihan);

    return PenilaianSf(
        personalities: personalities ?? [],
        distribution: distribution ?? [],
        merchandising: merchandising ?? [],
        promotion: promotion ?? [],
        listPilihan: lNilaiSf ?? [],
        message: '');
  }

  List<NilaiSf>? _olahJsonPilihan(dynamic json) {
    try {
      List<NilaiSf> lNilaiSf = [];
      List<dynamic> ld = json['data'];
      for (int i = 0; i < ld.length; i++) {
        Map<String, dynamic> map = ld[i];
        NilaiSf nilaiSf = NilaiSfModel.fromJson(map);
        if (nilaiSf.isValid()) {
          lNilaiSf.add(nilaiSf);
        }
      }
      return lNilaiSf;
    } catch (e) {
      return null;
    }
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

  @override
  Future<bool> checkPenilaianSf(PenilaianSf penilaianSf, String idsf) {
    // TODO: implement checkPenilaianSf
    throw UnimplementedError();
  }

  @override
  Future<bool> submit(PenilaianSf penilaianSf, String idsf) async {
    Map<String, dynamic> mapsf =
        PenilaianSfModel(penilaianSf).toMapForSubmit(idsf);

    GetDio getDio = GetDio();
    Dio dio = await getDio.dioForm();
    var formData = FormData.fromMap(mapsf);
    var response =
        await dio.post('/penilaiansf/kirim_penilaian', data: formData);
    return _olahJsonResponseSubmit(response.data);
  }

  bool _olahJsonResponseSubmit(dynamic json) {
    try {
      Map<String, dynamic> map = json;
      if (map['status'] != null) {
        int? status = ConverterNumber.stringToIntOrNull(map['status']);
        if (status == null) {
          return false;
        } else if (status == 1) {
          return true;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
