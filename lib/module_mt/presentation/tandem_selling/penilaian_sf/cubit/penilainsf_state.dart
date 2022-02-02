part of 'penilainsf_cubit.dart';

abstract class PenilainsfState extends Equatable {
  const PenilainsfState();

  @override
  List<Object> get props => [];
}

class PenilainsfInitial extends PenilainsfState {}

class PenilainsfLoading extends PenilainsfState {}

class PenilainsfLoaded extends PenilainsfState {
  final PenilaianSf penilaianSf;
  const PenilainsfLoaded(this.penilaianSf);
}

class PenilainsfError extends PenilainsfState {
  final String message;
  const PenilainsfError(this.message);
}
