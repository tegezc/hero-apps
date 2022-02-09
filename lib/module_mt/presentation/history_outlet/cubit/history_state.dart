part of 'history_cubit.dart';

@immutable
abstract class HistoryState {
  final AdapterHistory adapterHistory;
  HistoryState(this.adapterHistory);
}

class HistoryInitial extends HistoryState {
  HistoryInitial(AdapterHistory adapterHistory) : super(adapterHistory);
}

class HistoryLoading extends HistoryState {
  HistoryLoading(AdapterHistory adapterHistory) : super(adapterHistory);
}

class SuccessSearchFinish extends HistoryState {
  SuccessSearchFinish(AdapterHistory adapterHistory) : super(adapterHistory);
}

class HistoryRefresh extends HistoryState {
  HistoryRefresh(AdapterHistory adapterHistory) : super(adapterHistory);
}
