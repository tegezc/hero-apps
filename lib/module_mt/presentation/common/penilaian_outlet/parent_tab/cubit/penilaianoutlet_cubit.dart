import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hero/core/log/printlog.dart';
import 'package:hero/module_mt/data/datasources/get_penilaian_outlet.dart';
import 'package:hero/module_mt/data/repositories/penilaian_outlet/penilaian_outlet_repository.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/advokasi.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/availability.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/visibility.dart';
import 'package:hero/module_mt/domain/usecase/tandem_selling/penilaian/penilaian_outlet_usecase.dart';

part 'penilaianoutlet_state.dart';

class PenilaianoutletCubit extends Cubit<PenilaianoutletState> {
  PenilaianoutletCubit() : super(PenilaianoutletInitial());

  late PenilaianOutletUseCase _penilaianOutletUseCase;

  late Availability cacheAvailibility;
  late PenilaianVisibility cacheVisibility;
  late Advokasi cacheAdvokasi;

  void setupData(String idOutlet) {
    emit(PenilaianoutletLoading());
    _setupData(idOutlet).then((_) {});
  }

  Future<void> _setupData(String idOutlet) async {
    PenilaianOutletDataSourceImpl penilaianOutletDataSource =
        await PenilaianOutletDataSourceImpl.create(idOutlet);
    PenilaianOutletRepositoryImpl penilaianOutletRepository =
        PenilaianOutletRepositoryImpl(
            penilaianOutletDataSource: penilaianOutletDataSource);
    _penilaianOutletUseCase = PenilaianOutletUseCase(
        penilaianOutletRepository: penilaianOutletRepository);
    cacheAdvokasi = _penilaianOutletUseCase.getAdvokasi();
    cacheVisibility = _penilaianOutletUseCase.getVisibility();
    cacheAvailibility = _penilaianOutletUseCase.getAvailability();
    emit(_createPenilaianLoaded());
  }

  void changeSwitchedToggleAvailibity(int index, bool value) {
    ph('change toggle');
    cacheAvailibility.question.lquestion[index].isYes = value;
  }

  void changeTextAvailibity(int index, String value, EJenisParam eJenisParam) {
    ph('change text');
    switch (eJenisParam) {
      case EJenisParam.perdana:
        cacheAvailibility.kategoriOperator.lparams[index].nilai =
            int.tryParse(value);
        break;
      case EJenisParam.VK:
        cacheAvailibility.kategoriVF.lparams[index].nilai = int.tryParse(value);
        break;
      case EJenisParam.poster:
        // TODO: Handle this case.
        break;
      case EJenisParam.layar:
        // TODO: Handle this case.
        break;
    }
  }

  PenilaianoutletLoaded _createPenilaianLoaded() {
    return PenilaianoutletLoaded(
        availability: cacheAvailibility,
        visibility: cacheVisibility,
        advokasi: cacheAdvokasi);
  }
}

enum EJenisParam { perdana, VK, poster, layar }
