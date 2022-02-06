import 'package:flutter/cupertino.dart';
import 'package:hero/module_mt/domain/entity/tandem_selling/penilaian_sf.dart';

import '../../../repositories/penilaian_sf/i_penilaian_sf_repository.dart';

class CheckPenilaianSfUsecase {
  final IPenilaianSfRepository penilaianSfRepository;
  CheckPenilaianSfUsecase(this.penilaianSfRepository);
  Future<bool> call(PenilaianSf penilaianSf, String idsf) async {
    return await penilaianSfRepository.checkPenilaianSf(penilaianSf, idsf);
  }
}
