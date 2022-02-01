import 'package:equatable/equatable.dart';

class Cluster extends Equatable {
  final String idCluster;
  final String namaCluster;

  const Cluster({required this.idCluster, required this.namaCluster});

  bool isValid() {
    if (idCluster.isNotEmpty && namaCluster.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  String toString() {
    return namaCluster;
  }

  @override
  List<Object?> get props => [idCluster];
}
