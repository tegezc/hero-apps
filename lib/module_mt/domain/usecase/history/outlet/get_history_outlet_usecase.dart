import 'package:hero/module_mt/domain/entity/history/outlet/history_outlet.dart';
import 'package:hero/module_mt/domain/repositories/history/outlet/i_history_outlet_repository.dart';

class HistoryOutletUsecase {
  IHistoryOutletRepository historyOutletRepository;
  HistoryOutletUsecase(this.historyOutletRepository);
  Future<List<HistoryOutlet>?> call(
      {required DateTime awal, required DateTime akhir}) async {
    return await historyOutletRepository.getData(awal, akhir);
  }
}
