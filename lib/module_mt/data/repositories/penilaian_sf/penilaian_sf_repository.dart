import 'package:hero/module_mt/data/datasources/tandem/penilaian_sf_datasource.dart';
import 'package:hero/module_mt/domain/entity/tandem_selling/penilaian_sf.dart';
import 'package:hero/module_mt/domain/repositories/penilaian_sf/i_penilaian_sf_repository.dart';

class PenilaianSfRepositoryImpl implements IPenilaianSfRepository {
  PenilaianSfDataSource penilaianSfDataSource;
  PenilaianSfRepositoryImpl(this.penilaianSfDataSource);
  @override
  Future<PenilaianSf?> getData(String idsf) async {
    return await penilaianSfDataSource.getData(idsf);
  }

  @override
  Future<double> checkPenilaianSf(PenilaianSf penilaianSf) async {
    return await penilaianSfDataSource.checkPenilaianSf(penilaianSf);
  }

  @override
  Future<bool> submit(PenilaianSf penilaianSf, String idsf) async {
    return await penilaianSfDataSource.submit(penilaianSf, idsf);
  }
}
