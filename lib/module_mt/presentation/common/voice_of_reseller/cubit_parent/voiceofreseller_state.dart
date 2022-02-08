part of 'voiceofreseller_cubit.dart';

abstract class VoiceofresellerState {
  const VoiceofresellerState();
}

class VoiceofresellerInitial extends VoiceofresellerState {}

class VoiceofresellerLoading extends VoiceofresellerState {}

class VoiceofresellerLoaded extends VoiceofresellerState {
  final VoiceOfReseller? voiceOfReseller;
  final OutletMT outletMT;
  const VoiceofresellerLoaded(
      {required this.voiceOfReseller, required this.outletMT});
}

class VoiceofresellerError extends VoiceofresellerState {
  final String message;
  const VoiceofresellerError({required this.message});
}
