import 'package:dio/dio.dart';
import 'package:hero/module_mt/data/datasources/common/dio_config.dart';
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

    return null;
  }

  @override
  Future<List<Sales>?> getComoboboxSales(String idTap) {
    // TODO: implement getComoboboxSales
    throw UnimplementedError();
  }

  @override
  Future<List<Tap>?> getComoboboxTap(String idCluster) {
    // TODO: implement getComoboboxTap
    throw UnimplementedError();
  }
}
