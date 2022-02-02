import 'package:hero/model/retur.dart';
import 'package:hero/module_mt/domain/entity/tandem_selling/pertanyaan_sf.dart';

class PenilaianSf {
  List<PertanyaanSf> personalities;
  List<PertanyaanSf> distribution;
  List<PertanyaanSf> merchandising;
  List<PertanyaanSf> promotion;

  PenilaianSf(
      {required this.personalities,
      required this.distribution,
      required this.merchandising,
      required this.promotion});
}
