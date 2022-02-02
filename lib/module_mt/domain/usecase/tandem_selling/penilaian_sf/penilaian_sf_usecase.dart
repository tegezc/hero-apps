import 'package:hero/module_mt/data/datasources/tandem/penilaian_sf_datasource.dart';
import 'package:hero/module_mt/data/repositories/penilaian_sf/penilaian_sf_repository.dart';
import 'package:hero/module_mt/domain/entity/tandem_selling/penilaian_sf.dart';
import 'package:hero/module_mt/domain/repositories/penilaian_outlet/i_penilaian_outlet_repository.dart';
import 'package:hero/module_mt/domain/repositories/penilaian_sf/i_penilaian_sf_repository.dart';
import 'package:hero/module_mt/domain/usecase/tandem_selling/penilaian/penilaian_outlet_usecase.dart';

class PeniaianSfUsecase {
  IPenilaianSfRepository penilaianSfRepository;
  PeniaianSfUsecase(this.penilaianSfRepository);
  Future<PenilaianSf?> getData(String idSf) async {
    return await penilaianSfRepository.getData(idSf);
  }
}
