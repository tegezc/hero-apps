import 'package:hero/module_mt/domain/entity/common/outlet_mt.dart';
import 'package:hero/module_mt/domain/repositories/common/i_outletmt_repository.dart';

class SearchTandemUseCase {
  IOutletMTRepository outletMTRepository;
  SearchTandemUseCase({required this.outletMTRepository});
  Future<List<OutletMT>?> getListOutletMTTandemSelling(String idSf) async {
    return await outletMTRepository.cariOutletTandemSelling(idSf);
  }
}
