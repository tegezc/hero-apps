import 'package:hero/module_mt/domain/entity/history/sales/history_sales.dart';

import '../../../repositories/history/sales/i_history_sales_repository.dart';

class HistorySalesUsecase {
  HistorySalesRepository historySalesRepository;
  HistorySalesUsecase(this.historySalesRepository);
  Future<List<HistorySales>?> call(
      {required DateTime awal, required DateTime akhir}) async {
    return await historySalesRepository.getData(awal: awal, akhir: akhir);
  }
}
