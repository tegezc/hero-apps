import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hero/module_mt/data/datasources/tandem/penilaian_sf_datasource.dart';
import 'package:hero/module_mt/data/repositories/penilaian_sf/penilaian_sf_repository.dart';
import 'package:hero/module_mt/domain/entity/tandem_selling/penilaian_sf.dart';
import 'package:hero/module_mt/domain/usecase/tandem_selling/penilaian_sf/check_penilaian_sf.dart';
import 'package:hero/module_mt/domain/usecase/tandem_selling/penilaian_sf/submit_penilaian_sf_usecase.dart';
import 'package:meta/meta.dart';

import '../../../../../core/log/printlog.dart';
import '../../../common/hive_mt.dart';

part 'clpenilaian_sf_state.dart';

class ClpenilaianSfCubit extends Cubit<ClpenilaianSfState> {
  ClpenilaianSfCubit() : super(ClpenilaianSfInitial());

  late PenilaianSf _penilaianSf;
  late String idSales;

  void trySubmit(PenilaianSf penilaianSf, String idsf) {
    _penilaianSf = penilaianSf;
    idSales = idsf;
    confirmedSubmit();
  }

  void tryToCheckNilai(PenilaianSf penilaianSf, String idsf) {
    _penilaianSf = penilaianSf;
    idSales = idsf;
    confirmedCheckNilai();
  }

  void confirmedSubmit() {
    if (_penilaianSf.isValidToSubmit()) {
      emit(SubmitConfirmed());
    } else {
      emit(FieldNotCompletedYet(message: "Seluruh pertanyaan harus di jawab."));
    }
  }

  void confirmedCheckNilai() {
    if (_penilaianSf.isValidToSubmit()) {
      checkNilai();
    } else {
      emit(FieldNotCompletedYet(message: "Seluruh pertanyaan harus di jawab."));
    }
  }

  void checkNilai() {
    emit(LoadingSubmitOrCheckNilai());
    _prosesCheckNilai().then((value) {
      ph('nilai di bloc listener : $value');
      emit(CheckNilaiSuccessOrNot(true, value));
    });
  }

  void submit() async {
    emit(LoadingSubmitOrCheckNilai());
    _prosesSubmit().then((value) {
      if (value) {
        HiveMT.penilaiansf(idSales).setPenilaianSf();
        emit(SubmitSuccessOrNot(true, 'Data berhasil di submit'));
      } else {
        emit(SubmitSuccessOrNot(false, 'Data gagal disubmit'));
      }
    });
  }

  Future<bool> _prosesSubmit() async {
    PenilaianSfDataSourceImpl penilaianSfDataSourceImpl =
        PenilaianSfDataSourceImpl();
    PenilaianSfRepositoryImpl penilaianSfRepository =
        PenilaianSfRepositoryImpl(penilaianSfDataSourceImpl);
    SubmitPenilaianSFUsecase pusecase =
        SubmitPenilaianSFUsecase(penilaianSfRepository);

    return pusecase(_penilaianSf, idSales);
  }

  Future<double> _prosesCheckNilai() async {
    PenilaianSfDataSourceImpl penilaianSfDataSourceImpl =
        PenilaianSfDataSourceImpl();
    PenilaianSfRepositoryImpl penilaianSfRepository =
        PenilaianSfRepositoryImpl(penilaianSfDataSourceImpl);
    CheckPenilaianSfUsecase cn = CheckPenilaianSfUsecase(penilaianSfRepository);

    return cn(_penilaianSf);
  }
}
