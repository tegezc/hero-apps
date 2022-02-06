part of 'voiceofreseller_cubit.dart';

abstract class VoiceofresellerState extends Equatable {
  const VoiceofresellerState();

  @override
  List<Object> get props => [];
}

class VoiceofresellerInitial extends VoiceofresellerState {}

class VoiceofresellerLoading extends VoiceofresellerState {}

class VoiceofresellerLoaded extends VoiceofresellerState {
  final VoiceOfReseller? voiceOfReseller;
  const VoiceofresellerLoaded({required this.voiceOfReseller});
}

class VoiceofresellerError extends VoiceofresellerState {
  final String message;
  const VoiceofresellerError({required this.message});
}
