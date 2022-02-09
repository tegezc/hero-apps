import 'package:hero/module_mt/domain/entity/history/outlet/history_outlet.dart';
import 'package:hero/module_mt/domain/repositories/history/i_history_outlet_repository.dart';

class HistoryOutletUsecase {
  IHistoryRepository iHistoryRepository;
  HistoryOutletUsecase(this.iHistoryRepository);
  Future<List<HistoryOutlet>?> call(
      {required DateTime awal, required DateTime akhir}) async {
    return await iHistoryRepository.getDataOutlet(awal, akhir);
  }
}
