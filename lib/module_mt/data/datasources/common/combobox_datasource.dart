import 'package:dio/dio.dart';
import 'package:hero/config/configuration_sf.dart';
import 'package:hero/module_mt/data/datasources/core/dio_config.dart';
import 'package:hero/module_mt/data/model/cluster_data.dart';
import 'package:hero/module_mt/data/model/sales_model.dart';
import 'package:hero/module_mt/data/model/tap_data.dart';
import 'package:hero/module_mt/domain/entity/common/cluster.dart';
import 'package:hero/module_mt/domain/entity/common/sales.dart';
import 'package:hero/module_mt/domain/entity/common/tap.dart';

abstract class ComboboxDatasource {
  Future<List<Cluster>?> getComoboboxCluster();
  Future<List<Sales>?> getComoboboxSales(String idTap);
  Future<List<Tap>?> getComoboboxTap(String idCluster);
}

class ComboboxDatasourceImpl implements ComboboxDatasource {
  final GetDio getDio = GetDio();
  @override
  Future<List<Cluster>?> getComoboboxCluster() async {
    GetDio getDio = GetDio();
    Dio dio = await getDio.dio();
    var response = await dio.get('/combobox/cluster');
    return _olahJson(response.data);
  }

  List<Cluster>? _olahJson(dynamic data) {
    try {
      Map<String, dynamic> dynMap = data;
      List<Cluster> lCluster = [];
      List<dynamic> lmap = dynMap['data'];
      ph(lmap.length);
      for (int i = 0; i < lmap.length; i++) {
        Map<String, dynamic> map = lmap[i];
        Cluster cluster = ClusterModel.formJson(map);

        if (cluster.isValid()) {
          lCluster.add(cluster);
        }
      }
      return lCluster;
    } catch (e) {
      ph(e);
      return null;
    }
  }

  @override
  Future<List<Sales>?> getComoboboxSales(String idTap) async {
    GetDio getDio = GetDio();
    Dio dio = await getDio.dio();
    var response = await dio.post('/combobox/sales', data: {"id_tap": idTap});
    return _olahJsonSales(response.data);
  }

  List<Sales>? _olahJsonSales(dynamic data) {
    try {
      List<Sales> lSales = [];
      Map<String, dynamic> dynMap = data;
      List<dynamic> lmap = dynMap['data'];
      for (int i = 0; i < lmap.length; i++) {
        Map<String, dynamic> map = lmap[i];

        Sales sales = SalesModel.fromJson(map);
        if (sales.isValid()) lSales.add(sales);
      }
      return lSales;
    } catch (e) {
      ph(e);
      return null;
    }
  }

  @override
  Future<List<Tap>?> getComoboboxTap(String idCluster) async {
    GetDio getDio = GetDio();
    Dio dio = await getDio.dio();
    var response =
        await dio.post('/combobox/tap', data: {"id_cluster": idCluster});
    return _olahJsonTap(response.data);
  }

  List<Tap>? _olahJsonTap(dynamic data) {
    try {
      List<Tap> lTap = [];
      Map<String, dynamic> dynMap = data;

      List<dynamic> lmap = dynMap['data'];

      for (int i = 0; i < lmap.length; i++) {
        Map<String, dynamic> map = lmap[i];

        Tap tap = TapModel.fromJson(map);
        if (tap.isValid()) lTap.add(tap);
      }
      return lTap;
    } catch (e) {
      ph(e);
      return null;
    }
  }
}
