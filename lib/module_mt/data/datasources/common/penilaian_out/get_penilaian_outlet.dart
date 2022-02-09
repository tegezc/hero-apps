import 'package:dio/dio.dart';
import 'package:hero/core/error/fatal_object_null_exception.dart';
import 'package:hero/module_mt/data/model/common/penilaian_outlet/param_penilaian_model.dart';
import 'package:hero/module_mt/data/model/common/penilaian_outlet/question_model.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/advokasi.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/availability.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/kategories.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/param_penilaian.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/question.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/questions.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/visibility.dart';

import '../../core/dio_config.dart';

abstract class PenilaianOutletDataSource {
  Availability getAvailability();
  PenilaianVisibility getVisibility();
  Advokasi getAdvokasi();
}

class PenilaianOutletDataSourceImpl implements PenilaianOutletDataSource {
  /// Private constructor
  late Dio dio;
  late dynamic json;
  PenilaianOutletDataSourceImpl._create();

  /// Public factory
  static Future<PenilaianOutletDataSourceImpl> create(String idOutlet) async {
    var component = PenilaianOutletDataSourceImpl._create();
    component.dio = await GetDio().dio();
    dynamic data = await component._getJsonPenilaian(idOutlet);
    Map<String, dynamic> map = data;
    component.json = map['data'];

    return component;
  }

  Future<dynamic> _getJsonPenilaian(String idOutlet) async {
    var response = await dio.get('/penilaianoutlet/penilaian/$idOutlet');
    return response.data;
  }

  @override
  Advokasi getAdvokasi() {
    List<Question> lQuestion = [];
    if (json != null) {
      try {
        List<dynamic> ld = json['ADVOKASI'];
        for (var i = 0; i < ld.length; i++) {
          Map<String, dynamic> map = ld[i];
          Question question = QuestionModel.fromJson(map);
          lQuestion.add(question);
        }
        return Advokasi(lquestions: lQuestion);
      } catch (e) {
        throw FatalObjectNullException(e.toString());
      }
    }
    throw FatalObjectNullException('Data Advokasi tidak valid');
  }

  static const tagPerdanaTelkomsel = 'perdana_telkomsel';
  static const tagPerdanaOther = 'perdana_all_operator';
  static const tagFisikTelkomsel = 'vf_telkomsel';
  static const tagFisikOther = 'vf_all_operator';
  static const tagQuestion = 'Question';
  @override
  Availability getAvailability() {
    Questions questions = Questions(lquestion: []);
    Kategories paramPerdana =
        Kategories(kategori: 'Parameter Perdana Telkomsel', lparams: []);
    Kategories paramVF =
        Kategories(kategori: 'Parameter All Operator', lparams: []);
    Kategories fisikTelkomsel = Kategories(kategori: 'Parameter', lparams: []);
    Kategories fisikOther = Kategories(kategori: 'Parameter', lparams: []);
    if (json != null) {
      try {
        List<dynamic> ld = json['AVAILABILITY'];
        for (var i = 0; i < ld.length; i++) {
          Map<String, dynamic> map = ld[i];
          if (map['key_kategori'] == tagPerdanaTelkomsel) {
            ParamPenilaian param = ParamPenilaianModel.fromJson(map);
            paramPerdana.lparams.add(param);
          } else if (map['key_kategori'] == tagPerdanaOther) {
            ParamPenilaian param = ParamPenilaianModel.fromJson(map);
            paramVF.lparams.add(param);
          } else if (map['key_kategori'] == tagFisikTelkomsel) {
            ParamPenilaian param = ParamPenilaianModel.fromJson(map);
            fisikTelkomsel.lparams.add(param);
          } else if (map['key_kategori'] == tagFisikOther) {
            ParamPenilaian param = ParamPenilaianModel.fromJson(map);
            fisikOther.lparams.add(param);
          } else if (map['kategori'] == tagQuestion) {
            Question question = QuestionModel.fromJson(map);
            questions.lquestion.add(question);
          }
        }
        return Availability(
            perdanaTelkomsel: paramPerdana,
            perdanaOther: paramVF,
            fisikTelkomsel: fisikTelkomsel,
            fisikOther: fisikOther,
            question: questions);
      } catch (e) {
        throw FatalObjectNullException(e.toString());
      }
    }
    throw FatalObjectNullException('Data Availability tidak valid');
  }

  static const tagPoster = 'Poster';
  static const tagLayar = 'Layar Toko';

  @override
  PenilaianVisibility getVisibility() {
    List<Question> lQuestion = [];
    Kategories paramPoster = Kategories(kategori: 'Parameter', lparams: []);
    Kategories paramLayar = Kategories(kategori: 'Parameter', lparams: []);

    if (json != null) {
      try {
        List<dynamic> ld = json['VISIBILITY'];
        for (var i = 0; i < ld.length; i++) {
          Map<String, dynamic> map = ld[i];
          if (map['kategori'] == tagPoster) {
            ParamPenilaian param = ParamPenilaianModel.fromJson(map);
            paramPoster.lparams.add(param);
          } else if (map['kategori'] == tagLayar) {
            ParamPenilaian param = ParamPenilaianModel.fromJson(map);
            paramLayar.lparams.add(param);
          } else if (map['kategori'] == tagQuestion) {
            Question question = QuestionModel.fromJson(map);
            lQuestion.add(question);
          }
        }

        if (lQuestion.length == 2 &&
            paramLayar.lparams.isNotEmpty &&
            paramPoster.lparams.isNotEmpty) {
          return PenilaianVisibility(
              questionAtas: lQuestion[0],
              kategoriesLayar: paramLayar,
              kategoriesPoster: paramPoster,
              questionBawah: lQuestion[1]);
        } else {
          throw FatalObjectNullException('Data Availability tidak valid');
        }
      } catch (e) {
        throw FatalObjectNullException(e.toString());
      }
    }
    throw FatalObjectNullException('Tidak memperoleh data dari server.');
  }
}
