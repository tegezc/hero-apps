import 'package:hero/module_mt/domain/entity/tandem_selling/penilaian_sf.dart';

import '../../../repositories/penilaian_sf/i_penilaian_sf_repository.dart';

class SubmitPenilaianSFUsecase {
  final IPenilaianSfRepository penilaianSfRepository;

  SubmitPenilaianSFUsecase(this.penilaianSfRepository);

  Future<bool> call(PenilaianSf penilaianSf, String idsf) async {
    return await penilaianSfRepository.submit(penilaianSf, idsf);
  }
}
