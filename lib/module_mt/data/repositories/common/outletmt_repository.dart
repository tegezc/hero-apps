import 'package:hero/module_mt/data/datasources/common/outlet_mt_datasource.dart';
import 'package:hero/module_mt/domain/entity/common/outlet_mt.dart';
import 'package:hero/module_mt/domain/repositories/common/i_outletmt_repository.dart';

class OutletMTRepository implements IOutletMTRepository {
  OutletMTDatasource outletMTDatasource;
  OutletMTRepository({required this.outletMTDatasource});
  @override
  Future<List<OutletMT>?> cariOutletBackChecking(String q) async {
    return await outletMTDatasource.cariOutletMTByQueryOutlet(q);
  }

  @override
  Future<List<OutletMT>?> cariOutletTandemSelling(String idSales) async {
    return await outletMTDatasource.cariOutletMTBySales(idSales);
  }
}
