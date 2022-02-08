import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hero/core/log/printlog.dart';
import 'package:hero/module_mt/data/datasources/common/penilaian_out/submit_penilaian_out_datasource.dart';
import 'package:hero/module_mt/data/repositories/penilaian_outlet/penilaian_out_submit_repository.dart';
import 'package:hero/module_mt/domain/entity/common/outlet_mt.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/advokasi.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/availability.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/param_penilaian.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/visibility.dart';
import 'package:hero/module_mt/domain/usecase/common/penilaian_outlet/advokat/submit_advokat_usecase.dart';
import 'package:hero/module_mt/presentation/common/e_kegiatan_mt.dart';
import 'package:hero/module_mt/presentation/common/hive_mt.dart';

import '../../../../../domain/usecase/common/penilaian_outlet/visibility/submit_visibility_usecase.dart';
import '../../../../../domain/usecase/common/penilaian_outlet/availability/submit_availability_usecase.dart';
import '../../enum_penilaian.dart';

part 'penilaianoutlet_state.dart';

class PenilaianoutletCubit extends Cubit<PenilaianoutletState> {
  Availability availability;
  PenilaianVisibility visibility;
  Advokasi advokasi;
  final OutletMT outletMT;
  final EKegitatanMt eKegitatanMt;
  PenilaianoutletCubit(
      {required this.availability,
      required this.visibility,
      required this.advokasi,
      required this.outletMT,
      required this.eKegitatanMt})
      : super(PenilaianoutletInitial(advokasi, availability, visibility));

  void changeSwitchedToggleAvailibity(int index, bool value) {
    ph('change toggle inded : $index $value');
    availability.question.lquestion[index].isYes = value;
  }

  void changeSwitchedToggleVisibility(bool isBawah, bool value) {
    if (isBawah) {
      visibility.questionBawah.isYes = value;
    } else {
      visibility.questionAtas.isYes = value;
    }
  }

  void changeSwitchedToggleAdvokat(int index, bool value) {
    advokasi.lquestions[index].isYes = value;
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
        ph('masuk poster : $value');
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
    bool isValid = true;
    if (eTab == ETabPenilaian.availability) {
      isValid = availability.isValidToSubmit();
    } else if (eTab == ETabPenilaian.visibility) {
      isValid = visibility.isValidToSubmit();
    } else if (eTab == ETabPenilaian.advokasi) {
      isValid = true;
    }

    if (isValid) {
      emit(ConfirmSubmit(advokasi, availability, visibility, eTab: eTab));
    } else {
      emit(FieldNotValidState(advokasi, availability, visibility));
    }
  }

  void submit(ETabPenilaian eTab) async {
    emit(LoadingSubmitData(advokasi, availability, visibility));
    _prosesSubmit(eTab).then((value) {
      if (value) {
        emit(FinishSubmitSuccessOrNot(advokasi, availability, visibility,
            message: 'Data berhasil di submit', isSuccess: true));
      } else {
        emit(FinishSubmitSuccessOrNot(advokasi, availability, visibility,
            message: 'Data gagal di submit', isSuccess: false));
      }
    });
  }

  Future<bool> _prosesSubmit(ETabPenilaian eTab) async {
    SubmitPenilaianOutDatasourceImpl submitDatasource =
        SubmitPenilaianOutDatasourceImpl();
    PenilaianOutSubmitRepository penilaianOutSubmitRepository =
        PenilaianOutSubmitRepository(submitDatasource);

    bool isSuccess = false;
    try {
      if (eTab == ETabPenilaian.availability) {
        SubmitAvailabilityUsecase sav =
            SubmitAvailabilityUsecase(penilaianOutSubmitRepository);
        isSuccess = await sav(availability, outletMT.idOutlet);
        if (isSuccess) {
          if (eKegitatanMt == EKegitatanMt.backchecking) {
            HiveMT.backchecking(outletMT.idOutlet).setAvailability();
          } else {
            HiveMT.tandem(outletMT.idOutlet, outletMT.idSales)
                .setAvailability();
          }
        }
      } else if (eTab == ETabPenilaian.visibility) {
        SubmitVisibilityUsecase sv =
            SubmitVisibilityUsecase(penilaianOutSubmitRepository);
        isSuccess = await sv(visibility, outletMT.idOutlet);
        if (isSuccess) {
          if (eKegitatanMt == EKegitatanMt.backchecking) {
            HiveMT.backchecking(outletMT.idOutlet).setVisibility();
          } else {
            HiveMT.tandem(outletMT.idOutlet, outletMT.idSales).setVisibility();
          }
        }
      } else if (eTab == ETabPenilaian.advokasi) {
        SubmitAdvokatUsecase ad =
            SubmitAdvokatUsecase(penilaianOutSubmitRepository);
        isSuccess = await ad(advokasi, outletMT.idOutlet);
        if (isSuccess) {
          if (eKegitatanMt == EKegitatanMt.backchecking) {
            HiveMT.backchecking(outletMT.idOutlet).setAdvokat();
          } else {
            HiveMT.tandem(outletMT.idOutlet, outletMT.idSales).setAdvokat();
          }
        }
      }

      return isSuccess;
    } catch (e) {
      return false;
    }
  }

  void refresh() {
    emit(_createPenilaianLoaded());
  }

  RefreshForm _createPenilaianLoaded() {
    return RefreshForm(advokasi, availability, visibility);
  }
}
