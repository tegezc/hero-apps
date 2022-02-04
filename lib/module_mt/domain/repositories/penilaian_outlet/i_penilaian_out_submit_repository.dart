import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/advokasi.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/availability.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/visibility.dart';

abstract class IPenilaianOutSubmitRepository {
  Future<bool> submitAvailability(Availability availability, String idOutlet);
  Future<bool> submitVisibility(
      PenilaianVisibility visibility, String idOutlet);
  Future<bool> submitAdvokad(Advokasi advokasi, String idOutlet);
}
