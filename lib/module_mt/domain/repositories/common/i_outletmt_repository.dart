import 'package:hero/module_mt/domain/entity/common/outlet_mt.dart';

abstract class IOutletMTRepository {
  Future<List<OutletMT>?> cariOutletTandemSelling(String idSales);
  Future<List<OutletMT>?> cariOutletBackChecking(String q);
}
