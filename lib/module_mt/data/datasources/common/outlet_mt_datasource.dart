import 'package:dio/dio.dart';
import 'package:hero/core/log/printlog.dart';
import 'package:hero/module_mt/data/datasources/core/dio_config.dart';
import 'package:hero/module_mt/data/model/common/outletmt_model.dart';
import 'package:hero/module_mt/domain/entity/common/outlet_mt.dart';

import '../../../domain/entity/tandem_selling/pencarian_tandem_selling.dart';

abstract class OutletMTDatasource {
  Future<PencarianTandemSelling?> cariOutletMTBySales(String idSales);
  Future<List<OutletMT>?> cariOutletMTByQueryOutlet(String q);
}

class OutletMTDatasourceImpl implements OutletMTDatasource {
  @override
  Future<List<OutletMT>?> cariOutletMTByQueryOutlet(String q) async {
    GetDio getDio = GetDio();
    Dio dio = await getDio.dio();
    var response = await dio.post('/combobox/cari_outlet', data: {"cari": q});
    return _olahJsonByQuery(response.data);
  }

  @override
  Future<PencarianTandemSelling?> cariOutletMTBySales(String idSales) async {
    GetDio getDio = GetDio();
    Dio dio = await getDio.dio();
    var response = await dio.get('/pjp/pjp_daftar/$idSales');
    try {
      return _olahJsonSales(response.data);
    } catch (e) {
      return null;
    }
  }

  PencarianTandemSelling? _olahJsonSales(dynamic data) {
    try {
      List<OutletMT> lOutlet = [];
      Map<String, dynamic> map = data;
      bool isPenilaianSfSubmitted = false;
      List<dynamic> lmap = map['data'];
      String status = map['status'];
      for (int i = 0; i < lmap.length; i++) {
        Map<String, dynamic> map = lmap[i];

        OutletMT outletMt = OutletMTData.fromJson(map);
        if (outletMt.isValid()) lOutlet.add(outletMt);
      }

      if (status == "1") {
        isPenilaianSfSubmitted = true;
      }
      PencarianTandemSelling psf =
          PencarianTandemSelling(lOutlet, isPenilaianSfSubmitted);
      return psf;
    } catch (e) {
      ph(e);
      return null;
    }
  }

  List<OutletMT>? _olahJsonByQuery(dynamic data) {
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
