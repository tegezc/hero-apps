import 'package:hero/module_mt/data/datasources/get_penilaian_outlet.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/visibility.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/availability.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/advokasi.dart';
import 'package:hero/module_mt/domain/repositories/penilaian_outlet/i_penilaian_outlet_repository.dart';

class PenilaianOutletRepositoryImpl implements IPenilaianOutletRepository {
  final PenilaianOutletDataSource penilaianOutletDataSource;
  PenilaianOutletRepositoryImpl({required this.penilaianOutletDataSource});
  @override
  Advokasi getAdvokasi() {
    return penilaianOutletDataSource.getAdvokasi();
  }

  @override
  Availability getAvailability() {
    return penilaianOutletDataSource.getAvailability();
  }

  @override
  PenilaianVisibility getVisibility() {
    return penilaianOutletDataSource.getVisibility();
  }
}
