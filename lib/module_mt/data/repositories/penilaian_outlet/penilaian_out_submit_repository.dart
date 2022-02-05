import 'package:hero/module_mt/data/datasources/common/penilaian_out/submit_penilaian_out_datasource.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/advokasi.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/availability.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/visibility.dart';
import 'package:hero/module_mt/domain/repositories/penilaian_outlet/i_penilaian_out_submit_repository.dart';

class PenilaianOutSubmitRepository implements IPenilaianOutSubmitRepository {
  final ISubmitPenilaianOutDatasource submitPenilaianOutDatasource;
  PenilaianOutSubmitRepository(this.submitPenilaianOutDatasource);
  @override
  Future<bool> submitAdvokad(Advokasi advokasi, String idOutlet) async {
    return await submitPenilaianOutDatasource.submitAdvokat(advokasi, idOutlet);
  }

  @override
  Future<bool> submitAvailability(
      Availability availability, String idOutlet) async {
    return await submitPenilaianOutDatasource.submitAvailability(
        availability, idOutlet);
  }

  @override
  Future<bool> submitVisibility(
      PenilaianVisibility visibility, String idOutlet) async {
    return await submitPenilaianOutDatasource.submitVisibility(
        visibility, idOutlet);
  }
}
