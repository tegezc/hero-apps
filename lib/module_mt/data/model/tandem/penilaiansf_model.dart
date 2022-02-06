import 'package:hero/module_mt/domain/entity/tandem_selling/penilaian_sf.dart';
import 'package:hero/module_mt/domain/entity/tandem_selling/pertanyaan_sf.dart';

class PenilaianSfModel extends PenilaianSf {
  PenilaianSfModel(PenilaianSf penilaianSf)
      : super(
            personalities: penilaianSf.personalities,
            distribution: penilaianSf.distribution,
            merchandising: penilaianSf.merchandising,
            promotion: penilaianSf.promotion,
            listPilihan: penilaianSf.listPilihan,
            message: penilaianSf.message);

  Map<String, dynamic> toMapForSubmit(String idsf) {
    Map<String, dynamic> map = {};
    map.addAll(_listPertanyaanSfToMap(personalities));
    map.addAll(_listPertanyaanSfToMap(distribution));
    map.addAll(_listPertanyaanSfToMap(merchandising));
    map.addAll(_listPertanyaanSfToMap(promotion));
    map['message'] = message;
    map['id_sales'] = idsf;
    return map;
  }

  Map<String, dynamic> _listPertanyaanSfToMap(List<PertanyaanSf> lPertanyaan) {
    Map<String, dynamic> map = {};
    for (int i = 0; i < lPertanyaan.length; i++) {
      PertanyaanSf p = lPertanyaan[i];
      map[p.idPertanyaan] = p.nilai!.id;
    }
    return map;
  }
}
