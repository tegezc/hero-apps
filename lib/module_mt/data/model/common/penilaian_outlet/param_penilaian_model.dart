import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/param_penilaian.dart';

class ParamPenilaianModel extends ParamPenilaian {
  ParamPenilaianModel({required String idParam, required String param})
      : super(idparam: idParam, param: param);

  factory ParamPenilaianModel.fromJson(Map<String, dynamic> json) {
    return ParamPenilaianModel(
        idParam: json['id_parameter'] ?? '', param: json['parameter'] ?? '');
  }
}
