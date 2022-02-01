import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/kategories.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/param_penilaian.dart';

class KategoriesModel extends Kategories {
  KategoriesModel(
      {required String kategori, required List<ParamPenilaian> lParam})
      : super(kategori: kategori, lparams: lParam);
}
