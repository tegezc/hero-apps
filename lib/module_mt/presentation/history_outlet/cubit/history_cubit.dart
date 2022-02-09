import 'package:bloc/bloc.dart';
import 'package:hero/module_mt/data/datasources/history/history_datasource.dart';
import 'package:hero/module_mt/data/repositories/history/history_repository.dart';
import 'package:hero/module_mt/domain/entity/history/outlet/history_outlet.dart';
import 'package:hero/module_mt/domain/entity/history/sales/history_sales.dart';
import 'package:hero/module_mt/domain/usecase/history/outlet/get_history_outlet_usecase.dart';
import 'package:hero/module_mt/domain/usecase/history/sales/history_sales_usecase.dart';
import 'package:hero/module_mt/presentation/history_outlet/AdapterHistory.dart';
import 'package:hero/module_mt/presentation/history_outlet/adapter_item_history.dart';
import 'package:hero/module_mt/presentation/history_outlet/enum_history.dart';
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

  void search(EHistory eHistory) {
    HistoryDataSourceImpl historyDataSourceImpl = HistoryDataSourceImpl();
    HistoryRepositoryImpl historyOutletRepository =
        HistoryRepositoryImpl(historyDataSourceImpl);
    HistoryOutletUsecase husecaseOutlet =
        HistoryOutletUsecase(historyOutletRepository);
    HistorySalesUsecase husecaseSales =
        HistorySalesUsecase(historyOutletRepository);

    emit(HistoryLoading(adapterHistory));
    switch (eHistory) {
      case EHistory.outlet:
        husecaseOutlet(awal: adapterHistory.awal!, akhir: adapterHistory.akhir!)
            .then((value) {
          if (value != null) {
            adapterHistory.lItem =
                _convertToAdapter<HistoryOutlet>(value, fromOutlet: true);
            print(adapterHistory.lItem);
          }
          emit(SuccessSearchFinish(adapterHistory));
        });
        break;
      case EHistory.sales:
        husecaseSales(adapterHistory.awal!, adapterHistory.akhir!)
            .then((value) {
          if (value != null) {
            adapterHistory.lItem =
                _convertToAdapter<HistorySales>(value, fromOutlet: false);
          }
          emit(SuccessSearchFinish(adapterHistory));
        });
        break;
    }
  }

  List<AdapterHistoryItem> _convertToAdapter<T>(List<T> lo,
      {required bool fromOutlet}) {
    List<AdapterHistoryItem> lad = [];
    for (T t in lo) {
      late AdapterHistoryItem item;
      if (fromOutlet) {
        item = AdapterHistoryItem.fromOutlet(t as HistoryOutlet);
      } else {
        item = AdapterHistoryItem.fromSales(t as HistorySales);
      }

      lad.add(item);
    }
    return lad;
  }
}
