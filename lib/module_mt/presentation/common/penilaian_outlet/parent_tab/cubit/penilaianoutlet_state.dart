part of 'penilaianoutlet_cubit.dart';

abstract class PenilaianoutletState extends Equatable {
  const PenilaianoutletState();

  @override
  List<Object> get props => [];
}

class PenilaianoutletInitial extends PenilaianoutletState {}

class FieldNotValidState extends PenilaianoutletState {}

class RefreshForm extends PenilaianoutletState {
  final Availability availability;
  final PenilaianVisibility visibility;
  final Advokasi advokasi;
  final int counter;

  const RefreshForm(
      {required this.availability,
      required this.visibility,
      required this.advokasi,
      required this.counter});

  @override
  List<Object> get props => [counter];
}

class ConfirmSubmit extends PenilaianoutletState {
  final ETabPenilaian eTab;
  const ConfirmSubmit(this.eTab);
}

class LoadingSubmitData extends PenilaianoutletState {}

class FinishSubmitSuccessOrNot extends PenilaianoutletState {}
