import 'package:hero/module_mt/domain/entity/common/outlet_mt.dart';

import '../../entity/tandem_selling/pencarian_tandem_selling.dart';

abstract class IOutletMTRepository {
  Future<PencarianTandemSelling?> cariOutletTandemSelling(String idSales);
  Future<List<OutletMT>?> cariOutletBackChecking(String q);
}
