import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hero/module_mt/data/datasources/common/penilaian_out/get_penilaian_outlet.dart';
import 'package:hero/module_mt/data/repositories/penilaian_outlet/penilaian_outlet_repository.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/advokasi.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/availability.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/visibility.dart';
import 'package:hero/module_mt/domain/usecase/common/penilaian/availability/get_availability_data.dart';

part 'statepenilaian_state.dart';

class StatepenilaianCubit extends Cubit<StatepenilaianState> {
  StatepenilaianCubit() : super(StatepenilaianInitial());

  late GetAvailabilityUseCase _penilaianOutletUseCase;

  late Availability cacheAvailibility;
  late PenilaianVisibility cacheVisibility;
  late Advokasi cacheAdvokasi;

  void setupData(String idOutlet) {
    emit(StatepenilaianLoading());
    _setupData(idOutlet).then((_) {});
  }

  Future<void> _setupData(String idOutlet) async {
    PenilaianOutletDataSourceImpl penilaianOutletDataSource =
        await PenilaianOutletDataSourceImpl.create(idOutlet);
    PenilaianOutletRepositoryImpl penilaianOutletRepository =
        PenilaianOutletRepositoryImpl(
            penilaianOutletDataSource: penilaianOutletDataSource);
    _penilaianOutletUseCase = GetAvailabilityUseCase(
        penilaianOutletRepository: penilaianOutletRepository);
    try {
      cacheAdvokasi = _penilaianOutletUseCase.getAdvokasi();
      cacheVisibility = _penilaianOutletUseCase.getVisibility();
      cacheAvailibility = _penilaianOutletUseCase.getAvailability();
      emit(_createStatepenilaianLoaded());
    } catch (e) {
      emit(StatepenilaianError());
    }
  }

  StatepenilaianLoaded _createStatepenilaianLoaded() {
    return StatepenilaianLoaded(
        availability: cacheAvailibility,
        visibility: cacheVisibility,
        advokasi: cacheAdvokasi);
  }
}
