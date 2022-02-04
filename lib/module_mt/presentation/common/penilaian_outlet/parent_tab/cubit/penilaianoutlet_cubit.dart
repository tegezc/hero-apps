import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hero/core/log/printlog.dart';
import 'package:hero/module_mt/data/datasources/common/penilaian_out/submit_penilaian_out_datasource.dart';
import 'package:hero/module_mt/data/repositories/penilaian_outlet/penilaian_out_submit_repository.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/advokasi.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/availability.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/param_penilaian.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/visibility.dart';
import 'package:hero/module_mt/domain/usecase/common/penilaian/availability/submit_availability_usecase.dart';

import '../../enum_penilaian.dart';

part 'penilaianoutlet_state.dart';

class PenilaianoutletCubit extends Cubit<PenilaianoutletState> {
  Availability availability;
  PenilaianVisibility visibility;
  Advokasi advokasi;
  final String idOutlet;
  int counter = 0;
  PenilaianoutletCubit(
      {required this.availability,
      required this.visibility,
      required this.advokasi,
      required this.idOutlet})
      : super(PenilaianoutletInitial(0));

  void changeSwitchedToggleAvailibity(int index, bool value) {
    ph('change toggle inded : $index $value');
    availability.question.lquestion[index].isYes = value;
  }

  void changeTextPenilaian(int index, String value, EJenisParam eJenisParam) {
    ph('change text $eJenisParam');
    switch (eJenisParam) {
      case EJenisParam.perdana:
        _setValueParamPenilaian(
            index, value, availability.kategoriOperator.lparams);
        break;
      case EJenisParam.vk:
        _setValueParamPenilaian(index, value, availability.kategoriVF.lparams);
        break;
      case EJenisParam.poster:
        _setValueParamPenilaian(
            index, value, visibility.kategoriesPoster.lparams);
        break;
      case EJenisParam.layar:
        _setValueParamPenilaian(
            index, value, visibility.kategoriesLayar.lparams);
        break;
    }
  }

  void _setValueParamPenilaian(
      int index, String value, List<ParamPenilaian> lParam) {
    lParam[index].nilai = int.tryParse(value);
  }

  void setPathImage(String pathImage, EPhotoPenilaian ePhotoPenilaian) {
    ph('$pathImage $ePhotoPenilaian');

    switch (ePhotoPenilaian) {
      case EPhotoPenilaian.avPerdana:
        availability.pathPhotoOperator = pathImage;
        break;
      case EPhotoPenilaian.avVf:
        availability.pathPhotoVF = pathImage;
        break;
      case EPhotoPenilaian.etalase:
        visibility.imageEtalase = pathImage;
        break;
      case EPhotoPenilaian.poster:
        visibility.imagePoster = pathImage;
        break;
      case EPhotoPenilaian.layar:
        visibility.imageLayar = pathImage;
        break;
    }
    ph('${availability.pathPhotoOperator}');
    ph('${availability.pathPhotoVF}');
    emit(_createPenilaianLoaded());
  }

  void setQuestionAv(bool value, int index) {
    availability.question.lquestion[index].isYes = value;
  }

  void setQuestionVis(bool value, bool isbawah) {
    if (isbawah) {
      visibility.questionBawah.isYes = value;
    } else {
      visibility.questionAtas.isYes = value;
    }
  }

  void setQuestionAdv(bool value, int index) {
    advokasi.lquestions[index].isYes = value;
  }

  void confirmSubmit(ETabPenilaian eTab) {
    if (eTab == ETabPenilaian.availability) {
      if (availability.isValidToSubmit()) {
        emit(ConfirmSubmit(ETabPenilaian.availability, counter++));
      } else {
        emit(FieldNotValidState(counter++));
      }
    } else if (eTab == ETabPenilaian.visibility) {
    } else if (eTab == ETabPenilaian.advokasi) {}
  }

  void submit(ETabPenilaian eTab) async {
    emit(LoadingSubmitData(counter++));
    _prosesSubmit(eTab).then((value) {
      if (value) {
        emit(FinishSubmitSuccessOrNot(
            message: 'Data berhasil di submit',
            isSuccess: true,
            counter: counter++));
      } else {
        emit(FinishSubmitSuccessOrNot(
            message: 'Data gagal di submit',
            isSuccess: false,
            counter: counter++));
      }
    });
  }

  Future<bool> _prosesSubmit(ETabPenilaian eTab) async {
    SubmitPenilaianOutDatasourceImpl submitDatasource =
        SubmitPenilaianOutDatasourceImpl();
    PenilaianOutSubmitRepository penilaianOutSubmitRepository =
        PenilaianOutSubmitRepository(submitDatasource);
    SubmitAvailabilityUsecase sav =
        SubmitAvailabilityUsecase(penilaianOutSubmitRepository);

    bool isSuccess = false;
    try {
      if (eTab == ETabPenilaian.availability) {
        isSuccess = await sav.call(availability, idOutlet);
      } else if (eTab == ETabPenilaian.visibility) {
      } else if (eTab == ETabPenilaian.advokasi) {}

      return isSuccess;
    } catch (e) {
      return false;
    }
  }

  RefreshForm _createPenilaianLoaded() {
    return RefreshForm(
        availability: availability,
        visibility: visibility,
        advokasi: advokasi,
        counter: counter++);
  }
}
