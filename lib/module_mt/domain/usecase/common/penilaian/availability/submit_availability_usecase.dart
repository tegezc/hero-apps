import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/availability.dart';
import 'package:hero/module_mt/domain/repositories/penilaian_outlet/i_penilaian_out_submit_repository.dart';

class SubmitAvailabilityUsecase {
  final IPenilaianOutSubmitRepository penilaianOutSubmitRepository;
  SubmitAvailabilityUsecase(this.penilaianOutSubmitRepository);
  Future<bool> call(Availability availability, String idOutlet) async {
    return await penilaianOutSubmitRepository.submitAvailability(
        availability, idOutlet);
  }
}
