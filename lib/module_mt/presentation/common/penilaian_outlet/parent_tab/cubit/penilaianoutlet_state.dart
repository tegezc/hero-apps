part of 'penilaianoutlet_cubit.dart';

abstract class PenilaianoutletState extends Equatable {
  const PenilaianoutletState();

  @override
  List<Object> get props => [];
}

class PenilaianoutletInitial extends PenilaianoutletState {}

class PenilaianoutletLoading extends PenilaianoutletState {}

class PenilaianoutletLoaded extends PenilaianoutletState {
  final Availability availability;
  final PenilaianVisibility visibility;
  final Advokasi advokasi;

  const PenilaianoutletLoaded(
      {required this.availability,
      required this.visibility,
      required this.advokasi});
}

class PenilaianoutletError extends PenilaianoutletState {}
