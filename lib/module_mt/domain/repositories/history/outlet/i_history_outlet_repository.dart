import 'package:hero/module_mt/domain/entity/history/outlet/history_outlet.dart';

abstract class IHistoryOutletRepository {
  Future<List<HistoryOutlet>?> getData(DateTime awal, DateTime akhir);
}
