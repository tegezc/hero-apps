import 'package:hero/module_mt/domain/repositories/common/i_outletmt_repository.dart';

import '../../entity/tandem_selling/pencarian_tandem_selling.dart';

class SearchTandemUseCase {
  IOutletMTRepository outletMTRepository;
  SearchTandemUseCase({required this.outletMTRepository});
  Future<PencarianTandemSelling?> getListOutletMTTandemSelling(
      String idSf) async {
    return await outletMTRepository.cariOutletTandemSelling(idSf);
  }
}
