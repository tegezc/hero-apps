import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/visibility.dart';
import 'package:hero/module_mt/domain/repositories/penilaian_outlet/i_penilaian_out_submit_repository.dart';

class SubmitVisibilityUsecase {
  final IPenilaianOutSubmitRepository penilaianOutSubmitRepository;
  SubmitVisibilityUsecase(this.penilaianOutSubmitRepository);
  Future<bool> call(PenilaianVisibility visibility, String idOutlet) async {
    return await penilaianOutSubmitRepository.submitVisibility(
        visibility, idOutlet);
  }
}
