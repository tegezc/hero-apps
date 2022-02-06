part of 'penilainsf_cubit.dart';

abstract class PenilainsfState {
  PenilaianSf penilaianSf;
  PenilainsfState(this.penilaianSf);
}

class PenilainsfInitial extends PenilainsfState {
  PenilainsfInitial(PenilaianSf penilaianSf) : super(penilaianSf);
}

class PenilainsfLoading extends PenilainsfState {
  PenilainsfLoading(PenilaianSf penilaianSf) : super(penilaianSf);
}

class PenilainsfLoaded extends PenilainsfState {
  PenilainsfLoaded(PenilaianSf penilaianSf) : super(penilaianSf);
}

class PenilainsfError extends PenilainsfState {
  final String message;
  PenilainsfError(this.message, PenilaianSf penilaianSf) : super(penilaianSf);
}
