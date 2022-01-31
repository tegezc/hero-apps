import 'package:hero/module_mt/domain/entity/common/cluster.dart';
import 'package:hero/module_mt/domain/entity/common/sales.dart';
import 'package:hero/module_mt/domain/entity/common/tap.dart';

abstract class IComboboxRepository {
  Future<List<Cluster>?> getComoboboxCluster();
  Future<List<Tap>?> getComoboboxTap(String idCluster);
  Future<List<Sales>?> getComoboboxSales(String idTap);
}
