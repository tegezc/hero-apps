import 'package:hero/module_mt/domain/entity/common/cluster.dart';
import 'package:hero/module_mt/domain/entity/common/sales.dart';
import 'package:hero/module_mt/domain/entity/common/tap.dart';
import 'package:hero/module_mt/domain/repositories/common/i_combo_box_repository.dart';

class ComboBoxRepositoryImp implements IComboboxRepository {
  @override
  Future<List<Cluster>?> getComoboboxCluster() {
    // TODO: implement getComoboboxCluster
    throw UnimplementedError();
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
