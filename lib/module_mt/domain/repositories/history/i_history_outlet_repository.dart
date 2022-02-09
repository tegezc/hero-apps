import 'package:hero/module_mt/domain/entity/history/outlet/history_outlet.dart';
import 'package:hero/module_mt/domain/entity/history/sales/history_sales.dart';

abstract class IHistoryRepository {
  Future<List<HistoryOutlet>?> getDataOutlet(DateTime awal, DateTime akhir);
  Future<List<HistorySales>?> getDataSales(DateTime awal, DateTime akhir);
}
