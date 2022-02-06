import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hero/module_mt/domain/entity/tandem_selling/penilaian_sf.dart';
import 'package:meta/meta.dart';

part 'clpenilaian_sf_state.dart';

class ClpenilaianSfCubit extends Cubit<ClpenilaianSfState> {
  ClpenilaianSfCubit() : super(ClpenilaianSfInitial());

  late PenilaianSf _penilaianSf;
  void trySubmit(PenilaianSf penilaianSf) {
    _penilaianSf = penilaianSf;
  }

  void checkNilai() {}

  void submit() {}
}
