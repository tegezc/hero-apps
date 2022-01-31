class Cluster {
  String idCluster;
  String namaCluster;

  Cluster({required this.idCluster, required this.namaCluster});

  bool isValid() {
    if (idCluster.isNotEmpty && namaCluster.isNotEmpty) {
      return true;
    }
    return false;
  }
}
