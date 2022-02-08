import 'package:hero/module_mt/domain/entity/common/outlet_mt.dart';

import '../../repositories/common/i_outletmt_repository.dart';

class SearchBackCheckingUseCase {
  IOutletMTRepository outletMTRepository;

  SearchBackCheckingUseCase(this.outletMTRepository);

  Future<List<OutletMT>?> getListOutlet(String query) async {
    return await outletMTRepository.cariOutletBackChecking(query);
  }
}
