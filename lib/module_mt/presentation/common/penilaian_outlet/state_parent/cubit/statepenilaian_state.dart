part of 'statepenilaian_cubit.dart';

abstract class StatepenilaianState extends Equatable {
  const StatepenilaianState();

  @override
  List<Object> get props => [];
}

class StatepenilaianInitial extends StatepenilaianState {}

class StatepenilaianLoading extends StatepenilaianState {}

class StatepenilaianLoaded extends StatepenilaianState {
  final Availability availability;
  final PenilaianVisibility visibility;
  final Advokasi advokasi;
  final OutletMT outletMT;
  final EKegitatanMt eKegitatanMt;

  const StatepenilaianLoaded(
      {required this.availability,
      required this.visibility,
      required this.advokasi,
      required this.outletMT,
      required this.eKegitatanMt});
}

class StatepenilaianError extends StatepenilaianState {}
