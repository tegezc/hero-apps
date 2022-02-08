part of 'penilaianoutlet_cubit.dart';

abstract class PenilaianoutletState {
  final Availability av;
  final PenilaianVisibility vis;
  final Advokasi adv;
  const PenilaianoutletState(
    this.adv,
    this.av,
    this.vis,
  );
}

class PenilaianoutletInitial extends PenilaianoutletState {
  PenilaianoutletInitial(Advokasi adv, Availability av, PenilaianVisibility vis)
      : super(adv, av, vis);
}

class FieldNotValidState extends PenilaianoutletState {
  FieldNotValidState(
    Advokasi adv,
    Availability av,
    PenilaianVisibility vis,
  ) : super(adv, av, vis);
}

class RefreshForm extends PenilaianoutletState {
  RefreshForm(Advokasi adv, Availability av, PenilaianVisibility vis)
      : super(adv, av, vis);
}

class ConfirmSubmit extends PenilaianoutletState {
  final ETabPenilaian eTab;

  ConfirmSubmit(Advokasi adv, Availability av, PenilaianVisibility vis,
      {required this.eTab})
      : super(adv, av, vis);
}

class LoadingSubmitData extends PenilaianoutletState {
  LoadingSubmitData(Advokasi adv, Availability av, PenilaianVisibility vis)
      : super(adv, av, vis);
}

class FinishSubmitSuccessOrNot extends PenilaianoutletState {
  final bool isSuccess;
  final String message;

  FinishSubmitSuccessOrNot(
      Advokasi adv, Availability av, PenilaianVisibility vis,
      {required this.message, required this.isSuccess})
      : super(adv, av, vis);
}
