import 'package:hero/module_mt/domain/entity/tandem_selling/static_nilai_sf.dart';

class NilaiSfModel extends NilaiSf {
  NilaiSfModel(String id, String nilai, String desc) : super(id, nilai, desc);

  factory NilaiSfModel.fromJson(Map<String, dynamic> json) {
    return NilaiSfModel(json['id_pilihan'], json['angka'], json['pilihan']);
  }
}
