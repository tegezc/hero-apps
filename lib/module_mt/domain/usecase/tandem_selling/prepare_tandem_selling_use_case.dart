import 'package:hero/module_mt/domain/entity/common/cluster.dart';
import 'package:hero/module_mt/domain/entity/common/sales.dart';
import 'package:hero/module_mt/domain/entity/common/tap.dart';
import 'package:hero/module_mt/domain/repositories/common/i_combo_box_repository.dart';

class PrepareTandemSellingUseCase {
  IComboboxRepository comboboxRepository;
  PrepareTandemSellingUseCase({required this.comboboxRepository});
  List<Cluster>? lCluster;
  List<Tap>? lTap;

  Future<List<Cluster>?> getListCluster() async {
    return await comboboxRepository.getComoboboxCluster();
  }

  Future<List<Tap>?> getListTap(String idCluster) async {
    return await comboboxRepository.getComoboboxTap(idCluster);
  }

  Future<List<Sales>?> getListSales(String idTap) async {
    return await comboboxRepository.getComoboboxSales(idTap);
  }
}
