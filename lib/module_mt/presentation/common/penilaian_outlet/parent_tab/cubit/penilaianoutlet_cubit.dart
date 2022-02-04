import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hero/core/log/printlog.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/advokasi.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/availability.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/param_penilaian.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/visibility.dart';

import '../../enum_penilaian.dart';

part 'penilaianoutlet_state.dart';

class PenilaianoutletCubit extends Cubit<PenilaianoutletState> {
  Availability availibility;
  PenilaianVisibility visibility;
  Advokasi advokasi;
  int counter = 0;
  PenilaianoutletCubit(
      {required this.availibility,
      required this.visibility,
      required this.advokasi})
      : super(PenilaianoutletInitial());

  void changeSwitchedToggleAvailibity(int index, bool value) {
    ph('change toggle');
    availibility.question.lquestion[index].isYes = value;
  }

  void changeTextPenilaian(int index, String value, EJenisParam eJenisParam) {
    ph('change text');
    switch (eJenisParam) {
      case EJenisParam.perdana:
        _setValueParamPenilaian(index, value, availibility.kategoriVF.lparams);
        break;
      case EJenisParam.vk:
        _setValueParamPenilaian(index, value, availibility.kategoriVF.lparams);
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
    lParam[index].nilai = int.tryParse(value) ?? 0;
  }

  void setPathImage(String pathImage, EPhotoPenilaian ePhotoPenilaian) {
    ph('$pathImage $ePhotoPenilaian');

    switch (ePhotoPenilaian) {
      case EPhotoPenilaian.avPerdana:
        availibility.pathPhotoOperator = pathImage;
        break;
      case EPhotoPenilaian.avVf:
        availibility.pathPhotoVF = pathImage;
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
    ph('${availibility.pathPhotoOperator}');
    ph('${availibility.pathPhotoVF}');
    emit(_createPenilaianLoaded());
  }

  void setQuestionAv(bool value, int index) {
    availibility.question.lquestion[index].isYes = value;
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

  void submit(dynamic obj) {}

  RefreshForm _createPenilaianLoaded() {
    counter++;
    return RefreshForm(
        availability: availibility,
        visibility: visibility,
        advokasi: advokasi,
        counter: counter);
  }
}
