part of 'clpenilaian_sf_cubit.dart';

@immutable
abstract class ClpenilaianSfState {}

class ClpenilaianSfInitial extends ClpenilaianSfState {}

class TryToSubmit extends ClpenilaianSfState {}

class FieldNotCompletedYet extends ClpenilaianSfState {}

class SubmitConfirm extends ClpenilaianSfState {}
