import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/advokasi.dart';
import 'package:hero/module_mt/domain/repositories/penilaian_outlet/i_penilaian_out_submit_repository.dart';

class SubmitAdvokatUsecase {
  final IPenilaianOutSubmitRepository penilaianOutSubmitRepository;
  SubmitAdvokatUsecase(this.penilaianOutSubmitRepository);
  Future<bool> call(Advokasi advokasi, String idOutlet) async {
    return await penilaianOutSubmitRepository.submitAdvokad(advokasi, idOutlet);
  }
}
