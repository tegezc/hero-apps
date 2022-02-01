import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/advokasi.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/availability.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/visibility.dart';

abstract class IPenilaianOutletRepository {
  Availability getAvailability();
  PenilaianVisibility getVisibility();
  Advokasi getAdvokasi();
}
