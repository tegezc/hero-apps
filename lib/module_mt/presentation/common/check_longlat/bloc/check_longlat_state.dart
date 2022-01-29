part of 'check_longlat_cubit.dart';

@immutable
abstract class CheckLonglatState {}

class CheckLonglatInitial extends CheckLonglatState {}

class CheckLongLatLoaded extends CheckLonglatState {
  final String currentRadius;
  final String validRadius;
  final List<Marker> lmarkers;
  final LatLng lokasiOutlet;
  final bool isValid;
  CheckLongLatLoaded(
      {required this.isValid,
      required this.validRadius,
      required this.currentRadius,
      required this.lmarkers,
      required this.lokasiOutlet});
  String getKet() {
    return currentRadius;
  }
}

class CheckLonglatError extends CheckLonglatState {
  final String message;
  CheckLonglatError({required this.message});
}
