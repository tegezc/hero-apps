import 'package:dio/dio.dart';
import 'package:hero/config/configuration_sf.dart';
import 'package:hero/module_mt/data/datasources/core/dio_config.dart';
import 'package:hero/module_mt/data/model/common/outletmt_model.dart';
import 'package:hero/module_mt/domain/entity/common/outlet_mt.dart';

abstract class OutletMTDatasource {
  Future<List<OutletMT>?> cariOutletMTBySales(String idSales);
  Future<List<OutletMT>?> cariOutletMTByQueryOutlet(String q);
}

class OutletMTDatasourceImpl implements OutletMTDatasource {
  @override
  Future<List<OutletMT>?> cariOutletMTByQueryOutlet(String q) async {
    GetDio getDio = GetDio();
    Dio dio = await getDio.dio();
    var response = await dio.post('/combobox/cari_outlet', data: {"cari": q});
    return _olahJsonSales(response.data);
  }

  @override
  Future<List<OutletMT>?> cariOutletMTBySales(String idSales) async {
    GetDio getDio = GetDio();
    Dio dio = await getDio.dio();
    var response = await dio.get('/pjp/pjp_daftar/$idSales');
    try {
      Map<String, dynamic> map = response.data;
      return _olahJsonSales(map['data']);
    } catch (e) {
      return null;
    }
  }

  List<OutletMT>? _olahJsonSales(dynamic data) {
    try {
      List<OutletMT> lOutlet = [];
      List<dynamic> lmap = data;
      for (int i = 0; i < lmap.length; i++) {
        Map<String, dynamic> map = lmap[i];

        OutletMT outletMt = OutletMTData.fromJson(map);
        if (outletMt.isValid()) lOutlet.add(outletMt);
      }
      return lOutlet;
    } catch (e) {
      ph(e);
      return null;
    }
  }
}
