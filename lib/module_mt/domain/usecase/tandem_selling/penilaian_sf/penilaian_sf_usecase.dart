import 'package:hero/module_mt/domain/entity/tandem_selling/penilaian_sf.dart';
import 'package:hero/module_mt/domain/repositories/penilaian_sf/i_penilaian_sf_repository.dart';

class PeniaianSfUsecase {
  IPenilaianSfRepository penilaianSfRepository;
  PeniaianSfUsecase(this.penilaianSfRepository);
  Future<PenilaianSf?> getData(String idSf) async {
    return await penilaianSfRepository.getData(idSf);
  }
}
