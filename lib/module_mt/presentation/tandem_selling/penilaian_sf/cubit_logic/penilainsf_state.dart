part of 'penilainsf_cubit.dart';

abstract class PenilainsfState {
  final PenilaianSf penilaianSf;
  final double? nilai;
  final bool isSubmitted;
  PenilainsfState(this.penilaianSf, this.nilai, this.isSubmitted);
}

class PenilainsfInitial extends PenilainsfState {
  PenilainsfInitial(PenilaianSf penilaianSf, double? nilai)
      : super(penilaianSf, nilai, false);
}

class PenilaianSFRefresh extends PenilainsfState {
  final bool isSubmitted;
  PenilaianSFRefresh(PenilaianSf penilaianSf, double? nilai, this.isSubmitted)
      : super(penilaianSf, nilai, isSubmitted);
}
