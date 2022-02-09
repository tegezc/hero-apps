import 'package:bloc/bloc.dart';
import 'package:hero/module_mt/presentation/history_outlet/AdapterHistory.dart';
import 'package:meta/meta.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit()
      : super(HistoryInitial(AdapterHistory(
            lItem: null, isButtonMoreShowing: false, awal: null, akhir: null)));
  late AdapterHistory adapterHistory;

  void setupData() {
    adapterHistory = AdapterHistory(
        lItem: null, isButtonMoreShowing: false, awal: null, akhir: null);
    emit(HistoryRefresh(adapterHistory));
  }

  void changeTglAwal(DateTime awal) {
    adapterHistory.awal = awal;

    emit(HistoryRefresh(adapterHistory));
  }

  void chageTglAkhir(DateTime akhir) {
    adapterHistory.akhir = akhir;
    emit(HistoryRefresh(adapterHistory));
  }
}
