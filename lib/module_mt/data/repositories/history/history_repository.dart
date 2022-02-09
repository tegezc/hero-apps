import 'package:hero/module_mt/data/datasources/history/history_datasource.dart';
import 'package:hero/module_mt/domain/entity/history/outlet/history_outlet.dart';
import 'package:hero/module_mt/domain/entity/history/sales/history_sales.dart';
import 'package:hero/module_mt/domain/repositories/history/i_history_outlet_repository.dart';

class HistoryRepositoryImpl implements IHistoryRepository {
  IHistoryDataSource historyDataSource;
  HistoryRepositoryImpl(this.historyDataSource);
  @override
  Future<List<HistoryOutlet>?> getDataOutlet(
      DateTime awal, DateTime akhir) async {
    return await historyDataSource.getOutlet(awal, akhir);
  }

  @override
  Future<List<HistorySales>?> getDataSales(
      DateTime awal, DateTime akhir) async {
    return await historyDataSource.getSales(awal, akhir);
  }
}
