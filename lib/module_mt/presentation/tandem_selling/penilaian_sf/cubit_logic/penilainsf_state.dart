part of 'penilainsf_cubit.dart';

abstract class PenilainsfState {
  PenilaianSf penilaianSf;
  PenilainsfState(this.penilaianSf);
}

class PenilainsfInitial extends PenilainsfState {
  PenilainsfInitial(PenilaianSf penilaianSf) : super(penilaianSf);
}

class PenilaianSFRefresh extends PenilainsfState {
  PenilaianSFRefresh(PenilaianSf penilaianSf) : super(penilaianSf);
}
