import 'package:hero/module_mt/domain/entity/outlet_mt.dart';

abstract class IOutletMTRepository {
  Future<List<OutletMT>?> cariOutletTandemSelling();
  Future<List<OutletMT>?> cariOutletBackChecking();
}
