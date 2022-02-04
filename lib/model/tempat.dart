class Tempat {
  String? nama;
  String? id;
  Tempat(this.id, this.nama);
  Tempat.kosong();

  ///  {
  //         "id_outlet": "1",
  //         "id_digipos": "1",
  //         "nama_outlet": "OUTLET 11",
  //         "no_rs": "NO RS 11"
  //     }
  Tempat.fromJson(Map<String, dynamic> map) {
    id = map['id_digipos'] ?? '';
    nama = map['nama_outlet'] ?? '';
  }
}
