import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/advokasi.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/availability.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/visibility.dart';
import 'package:hero/module_mt/domain/repositories/penilaian_outlet/i_penilaian_outlet_repository.dart';

class PenilaianOutletUseCase {
  IPenilaianOutletRepository penilaianOutletRepository;
  PenilaianOutletUseCase({required this.penilaianOutletRepository});

  Advokasi getAdvokasi() {
    return penilaianOutletRepository.getAdvokasi();
  }

  Availability getAvailability() {
    return penilaianOutletRepository.getAvailability();
  }

  PenilaianVisibility getVisibility() {
    return penilaianOutletRepository.getVisibility();
  }
}
