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
  final String idOutlet;

  const StatepenilaianLoaded(
      {required this.availability,
      required this.visibility,
      required this.advokasi,
      required this.idOutlet});
}

class StatepenilaianError extends StatepenilaianState {}
