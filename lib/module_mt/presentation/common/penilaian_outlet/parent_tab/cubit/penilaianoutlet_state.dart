part of 'penilaianoutlet_cubit.dart';

abstract class PenilaianoutletState {
  final Availability av;
  final PenilaianVisibility vis;
  final Advokasi adv;
  final ProgressPenilaianOutet progres;
  const PenilaianoutletState(this.adv, this.av, this.vis, this.progres);
}

class PenilaianoutletInitial extends PenilaianoutletState {
  PenilaianoutletInitial(Advokasi adv, Availability av, PenilaianVisibility vis,
      ProgressPenilaianOutet progress)
      : super(adv, av, vis, progress);
}

class FieldNotValidState extends PenilaianoutletState {
  FieldNotValidState(Advokasi adv, Availability av, PenilaianVisibility vis,
      ProgressPenilaianOutet progress)
      : super(adv, av, vis, progress);
}

class RefreshForm extends PenilaianoutletState {
  RefreshForm(Advokasi adv, Availability av, PenilaianVisibility vis,
      ProgressPenilaianOutet progress)
      : super(adv, av, vis, progress);
}

class ConfirmSubmit extends PenilaianoutletState {
  final ETabPenilaian eTab;

  ConfirmSubmit(Advokasi adv, Availability av, PenilaianVisibility vis,
      ProgressPenilaianOutet progress,
      {required this.eTab})
      : super(adv, av, vis, progress);
}

class LoadingSubmitData extends PenilaianoutletState {
  LoadingSubmitData(Advokasi adv, Availability av, PenilaianVisibility vis,
      ProgressPenilaianOutet progress)
      : super(adv, av, vis, progress);
}

class FinishSubmitSuccessOrNot extends PenilaianoutletState {
  final bool isSuccess;
  final String message;

  FinishSubmitSuccessOrNot(Advokasi adv, Availability av,
      PenilaianVisibility vis, ProgressPenilaianOutet progress,
      {required this.message, required this.isSuccess})
      : super(adv, av, vis, progress);
}
