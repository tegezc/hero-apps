class Profile {
  String? id;
  String? role;
  String? idtap;
  String? namaTap;
  String? namaSales;
  String? idcluster;
  String? namaCluster;
  String? token;

  //
  // "status": 200,
  // "message": "Successfully login.",
  // "id": "SSF045",
  // "role": "5",
  // "nama_sales": "EDI SUPRIANTO",
  // "id_tap": "TAP007",
  // "nama_tap": "TAP JEBUS",
  // "id_cluster": "CTR011",
  // "nama_cluster": "Bangka Belitung",
  // "token": "42161abe0e883fc49c2938e37ada860f"
  //

  Profile.kosong();
  Profile.lengkap(
      {required this.id,
      required this.role,
      required this.namaCluster,
      required this.token,
      required this.idcluster,
      required this.namaTap,
      required this.idtap,
      required this.namaSales});

  Profile.fromJson(Map<String, dynamic> map) {
    if (map['status'] == 200) {
      id = map['id'] == null ? '' : map['id'];
      role = map['role'] == null ? '' : map['role'];
      namaSales = map['nama_sales'] == null ? '' : map['nama_sales'];
      idtap = map['id_tap'] == null ? '' : map['id_tap'];
      namaTap = map['nama_tap'] == null ? '' : map['nama_tap'];
      idcluster = map['id_cluster'] == null ? '' : map['id_cluster'];
      namaCluster = map['nama_cluster'] == null ? '' : map['nama_cluster'];
      token = map['token'] == null ? '' : map['token'];
    }
  }

  bool isValid() {
    ///-header 'User-ID: SSF045' \
    // --header 'Auth-session: f7baaa64480b14443dab3134ecf4727c' \
    // --header 'Id-Level: 5' \
    // --header 'Nama-Sales: EDI SUPRIANTO' \
    // --header 'Id-Tap: TAP007' \
    // --header 'Nama-Tap: TAP JEBUS' \
    // --header 'Id-Cluster: CTR011' \
    // --header 'Nama-Cluster: Bangka Belitung' \
    if (id == null ||
        namaSales == null ||
        role == null ||
        token == null ||
        idtap == null ||
        namaTap == null ||
        idcluster == null ||
        namaCluster == null) {
      return false;
    }
    if (['5', '6', '7'].contains(role)) {
      return true;
    }
    return false;
  }

  @override
  String toString() {
    return 'id:$id | role: $role | idtap: $idtap | namaTap: $namaTap '
        '| namasales: $namaSales | idcluster: $idcluster | namacluster: $namaCluster '
        '| token: $token';
  }
}
