import 'package:hero/module_mt/data/datasources/common/combobox_datasource.dart';
import 'package:hero/module_mt/domain/entity/common/cluster.dart';
import 'package:hero/module_mt/domain/entity/common/sales.dart';
import 'package:hero/module_mt/domain/entity/common/tap.dart';
import 'package:hero/module_mt/domain/repositories/common/i_combo_box_repository.dart';

class ComboBoxRepositoryImp implements IComboboxRepository {
  ComboboxDatasource comboboxDatasource;
  ComboBoxRepositoryImp({required this.comboboxDatasource});
  @override
  Future<List<Cluster>?> getComoboboxCluster() async {
    return await comboboxDatasource.getComoboboxCluster();
  }

  @override
  Future<List<Sales>?> getComoboboxSales(String idTap) async {
    return await comboboxDatasource.getComoboboxSales(idTap);
  }

  @override
  Future<List<Tap>?> getComoboboxTap(String idCluster) async {
    return await comboboxDatasource.getComoboboxTap(idCluster);
  }
}
