part of 'home_back_checking_cubit.dart';

@immutable
abstract class HomeBackCheckingState {}

class HomeBackCheckingInitial extends HomeBackCheckingState {}

class HomeBackCheckingError extends HomeBackCheckingState {
  final String message;
  HomeBackCheckingError({required this.message});
}

class HomeBackCheckingLoading extends HomeBackCheckingState {}

class HomeBackCheckingLoaded extends HomeBackCheckingState {
  List<OutletMT>? lOutlet;
  HomeBackCheckingLoaded(this.lOutlet);
}
