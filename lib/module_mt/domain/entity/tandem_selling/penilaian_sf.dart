import 'package:hero/module_mt/domain/entity/tandem_selling/pertanyaan_sf.dart';
import 'package:hero/module_mt/domain/entity/tandem_selling/static_nilai_sf.dart';

class PenilaianSf {
  List<PertanyaanSf> personalities;
  List<PertanyaanSf> distribution;
  List<PertanyaanSf> merchandising;
  List<PertanyaanSf> promotion;
  String message;
  List<NilaiSf> listPilihan;

  PenilaianSf(
      {required this.personalities,
      required this.distribution,
      required this.merchandising,
      required this.promotion,
      required this.listPilihan,
      required this.message});
}
