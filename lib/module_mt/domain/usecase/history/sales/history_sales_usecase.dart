import 'package:hero/module_mt/domain/entity/history/sales/history_sales.dart';
import 'package:hero/module_mt/domain/repositories/history/i_history_outlet_repository.dart';

class HistorySalesUsecase {
  IHistoryRepository historyRepository;
  HistorySalesUsecase(this.historyRepository);
  Future<List<HistorySales>?> call(DateTime awal, DateTime akhir) async {
    return await historyRepository.getDataSales(awal, akhir);
  }
}
