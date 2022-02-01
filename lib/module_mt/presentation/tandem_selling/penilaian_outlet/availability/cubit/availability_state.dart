part of 'availability_cubit.dart';

abstract class AvailabilityState extends Equatable {
  const AvailabilityState();

  @override
  List<Object> get props => [];
}

class AvailabilityInitial extends AvailabilityState {}

class AvailabilityLoaded extends AvailabilityState {}

class AvailabilityLoading extends AvailabilityState {}

class AvailabilityError extends AvailabilityState {}
