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

  static const tagPerdana = 'Perdana';
  static const tagVF = 'VF';
  static const tagQuestion = 'Question';
  @override
  Availability getAvailability() {
    Questions questions = Questions(lquestion: []);
    Kategories paramPerdana = Kategories(kategori: tagPerdana, lparams: []);
    Kategories paramVF = Kategories(kategori: tagVF, lparams: []);
    if (json != null) {
      try {
        List<dynamic> ld = json['AVAILABILITY'];
        for (var i = 0; i < ld.length; i++) {
          Map<String, dynamic> map = ld[i];
          if (map['kategori'] == tagPerdana) {
            ParamPenilaian param = ParamPenilaianModel.fromJson(map);
            paramPerdana.lparams.add(param);
          } else if (map['kategori'] == tagVF) {
            ParamPenilaian param = ParamPenilaianModel.fromJson(map);
            paramVF.lparams.add(param);
          } else if (map['kategori'] == tagQuestion) {
            Question question = QuestionModel.fromJson(map);
            questions.lquestion.add(question);
          }
        }
        return Availability(
            kategoriOperator: paramPerdana,
            kategoriVF: paramVF,
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
    Kategories paramPoster = Kategories(kategori: tagPerdana, lparams: []);
    Kategories paramLayar = Kategories(kategori: tagVF, lparams: []);

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
