import 'package:hero/module_mt/domain/entity/tandem_selling/pertanyaan_sf.dart';
import 'package:hero/module_mt/domain/entity/tandem_selling/static_nilai_sf.dart';

class PenilaianSf {
  List<PertanyaanSf> personalities;
  List<PertanyaanSf> distribution;
  List<PertanyaanSf> merchandising;
  List<PertanyaanSf> promotion;
  String? message;
  List<NilaiSf> listPilihan;

  PenilaianSf(
      {required this.personalities,
      required this.distribution,
      required this.merchandising,
      required this.promotion,
      required this.listPilihan,
      required this.message});

  bool isValidToSubmit() {
    bool value = _checkList(personalities);
    if (!value) {
      return value;
    }
    value = _checkList(distribution);
    if (!value) {
      return value;
    }
    value = _checkList(merchandising);
    if (!value) {
      return value;
    }
    value = _checkList(promotion);

    return value;
  }

  bool _checkList(List<PertanyaanSf> lp) {
    for (PertanyaanSf p in lp) {
      if (p.nilai == null) {
        return false;
      }
    }
    return true;
  }
}
