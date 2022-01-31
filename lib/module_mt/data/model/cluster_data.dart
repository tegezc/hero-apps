import 'package:hero/module_mt/domain/entity/common/cluster.dart';

class ClusterModel extends Cluster {
  ClusterModel({required String idCluster, required String namaCluster})
      : super(idCluster: idCluster, namaCluster: namaCluster);

  factory ClusterModel.formJson(Map<String, dynamic> json) {
    return ClusterModel(
        namaCluster: json['nama_cluster'] ?? '',
        idCluster: json['id_cluster'] ?? '');
  }
}
