import 'package:hero/module_mt/domain/entity/tandem_selling/penilaian_sf.dart';

abstract class IPenilaianSfRepository {
  Future<PenilaianSf?> getData(String idsf);
}