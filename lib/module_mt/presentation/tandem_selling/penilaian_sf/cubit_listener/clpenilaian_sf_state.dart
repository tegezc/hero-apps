part of 'clpenilaian_sf_cubit.dart';

@immutable
abstract class ClpenilaianSfState {}

class ClpenilaianSfInitial extends ClpenilaianSfState {}

class FieldNotCompletedYet extends ClpenilaianSfState {
  final String message;
  FieldNotCompletedYet({required this.message});
}

class SubmitConfirmed extends ClpenilaianSfState {}

class CheckNilaiConfirmed extends ClpenilaianSfState {}

class LoadingSubmitOrCheckNilai extends ClpenilaianSfState {}

class SubmitSuccessOrNot extends ClpenilaianSfState {
  final bool isSuccess;
  final String message;
  SubmitSuccessOrNot(this.isSuccess, this.message);
}

class CheckNilaiSuccessOrNot extends ClpenilaianSfState {
  final bool isSuccess;
  double nilai;
  CheckNilaiSuccessOrNot(this.isSuccess, this.nilai);
}
