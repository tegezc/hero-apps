import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'availability_state.dart';

class AvailabilityCubit extends Cubit<AvailabilityState> {
  AvailabilityCubit() : super(AvailabilityInitial());
}
