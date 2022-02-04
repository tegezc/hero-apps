import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/advokasi.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/availability.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/visibility.dart';
import 'package:hero/module_mt/domain/repositories/penilaian_outlet/i_penilaian_out_submit_repository.dart';

class PenilaianOutSubmitRepository implements IPenilaianOutSubmitRepository {
  @override
  Future<bool> submitAdvokad(Advokasi advokasi, String idOutlet) {
    // TODO: implement submitAdvokad
    throw UnimplementedError();
  }

  @override
  Future<bool> submitAvailability(Availability availability, String idOutlet) {
    // TODO: implement submitAvailability
    throw UnimplementedError();
  }

  @override
  Future<bool> submitVisibility(
      PenilaianVisibility visibility, String idOutlet) {
    // TODO: implement submitVisibility
    throw UnimplementedError();
  }
}
