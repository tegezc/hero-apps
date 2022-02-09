import 'package:dio/dio.dart';
import 'package:hero/module_mt/data/model/history/history_outlet_model.dart';
import 'package:hero/module_mt/data/model/history/history_sales_model.dart';
import 'package:hero/module_mt/domain/entity/history/outlet/history_outlet.dart';
import 'package:hero/module_mt/domain/entity/history/sales/history_sales.dart';
import 'package:hero/util/dateutil.dart';

import '../../../../util/dateutil.dart';
import '../core/dio_config.dart';

abstract class IHistoryDataSource {
  Future<List<HistorySales>?> getSales(DateTime awal, DateTime akhir);
  Future<List<HistoryOutlet>?> getOutlet(DateTime awal, DateTime akhir);
}

class HistoryDataSourceImpl implements IHistoryDataSource {
  @override
  Future<List<HistoryOutlet>?> getOutlet(DateTime awal, DateTime akhir) async {
    String strAwal = DateUtility.dateToStringParam(awal);
    String strAkhir = DateUtility.dateToStringParam(akhir);
    GetDio getDio = GetDio();
    Dio dio = await getDio.dio();
    var response =
        await dio.get('/history/penilaian_outlet/$strAwal/$strAkhir');
    return _jsonOutlet(response.data);
  }

  List<HistoryOutlet>? _jsonOutlet(dynamic json) {
    List<HistoryOutlet>? lo = [];
    try {
      List<dynamic> ld = json['data'];
      for (int i = 0; i < ld.length; i++) {
        Map<String, dynamic> map = ld[i];
        HistoryOutlet ho = HistoryOutletModel.fromJson(map);
        if (ho.isValid()) {
          lo.add(ho);
        }
      }
      return lo;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<HistorySales>?> getSales(DateTime awal, DateTime akhir) async {
    String strAwal = DateUtility.dateToStringParam(awal);
    String strAkhir = DateUtility.dateToStringParam(akhir);
    GetDio getDio = GetDio();
    Dio dio = await getDio.dio();
    var response = await dio.get('/history/penilaian_sf/$strAwal/$strAkhir');
    return _jsonSales(response.data);
  }

  List<HistorySales>? _jsonSales(dynamic json) {
    List<HistorySales>? lh = [];
    try {
      List<dynamic> ld = json['data'];
      for (int i = 0; i < ld.length; i++) {
        Map<String, dynamic> map = ld[i];
        HistorySales hs = HistorySalesModel.fromJson(map);
        lh.add(hs);
      }
      return lh;
    } catch (e) {
      return null;
    }
  }
}
