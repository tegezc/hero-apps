part of 'logic_cubit.dart';

@immutable
abstract class LogicState {
  const LogicState(this.vor);
  final VoiceOfReseller vor;
}

class LogicInitial extends LogicState {
  const LogicInitial(VoiceOfReseller vor) : super(vor);
}

class AllCommboNotPickedYet extends LogicState {
  const AllCommboNotPickedYet(VoiceOfReseller vor) : super(vor);
}

class ConfirmSubmit extends LogicState {
  const ConfirmSubmit(VoiceOfReseller vor) : super(vor);
}

class LoadingSubmitData extends LogicState {
  const LoadingSubmitData(VoiceOfReseller vor) : super(vor);
}

class RefreshForSetPathVideo extends LogicState {
  const RefreshForSetPathVideo(VoiceOfReseller vor) : super(vor);
}

class SubmitSuccessOrNot extends LogicState {
  final bool isSuccess;
  final String message;
  const SubmitSuccessOrNot(VoiceOfReseller vor,
      {required this.isSuccess, required this.message})
      : super(vor);
}

class ChangeCombobox extends LogicState {
  const ChangeCombobox(VoiceOfReseller vor) : super(vor);
}
