part of 'penilaianoutlet_cubit.dart';

abstract class PenilaianoutletState extends Equatable {
  final int counter;
  const PenilaianoutletState(this.counter);

  @override
  List<Object> get props => [counter];
}

class PenilaianoutletInitial extends PenilaianoutletState {
  PenilaianoutletInitial(int counter) : super(counter);
}

class FieldNotValidState extends PenilaianoutletState {
  FieldNotValidState(int counter) : super(counter);
}

class RefreshForm extends PenilaianoutletState {
  final Availability availability;
  final PenilaianVisibility visibility;
  final Advokasi advokasi;

  const RefreshForm(
      {required this.availability,
      required this.visibility,
      required this.advokasi,
      required int counter})
      : super(counter);

  @override
  List<Object> get props => [counter];
}

class ConfirmSubmit extends PenilaianoutletState {
  final ETabPenilaian eTab;
  ConfirmSubmit(this.eTab, int counter) : super(counter);
}

class LoadingSubmitData extends PenilaianoutletState {
  LoadingSubmitData(int counter) : super(counter);
}

class FinishSubmitSuccessOrNot extends PenilaianoutletState {
  final bool isSuccess;
  final String message;

  FinishSubmitSuccessOrNot(
      {required this.isSuccess, required this.message, required int counter})
      : super(0);
}
