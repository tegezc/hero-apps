import 'package:hero/module_mt/domain/entity/history/sales/history_sales.dart';

abstract class HistorySalesRepository {
  Future<List<HistorySales>?> getData(
      {required DateTime awal, required DateTime akhir});
}
