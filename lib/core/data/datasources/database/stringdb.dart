class TbProv {
  static const String tableName = 'tb_provinsi';
  static const String id = 'id';
  static const String realid = 'realid';
  static const String nama = 'nama';
}

class TbKab {
  static const String tableName = 'tb_kabupaten';
  static const String id = 'id';
  static const String realid = 'realid';
  static const String idprov = 'idprov';
  static const String nama = 'nama';
}

class TbKec {
  static const String tableName = 'tb_kecamatan';
  static const String id = 'id';
  static const String idcluster = 'idcluster';
  static const String realid = 'realid';
  static const String idkab = 'idkab';
  static const String nama = 'nama';
}

class TbKel {
  static const String tableName = 'tb_kelurahan';
  static const String id = 'id';
  static const String idkec = 'idkec';
  static const String idkel = 'idkel';
  static const String nama = 'nama';
}

class TbSerial {
  static const String tableName = 'tb_serial';
  static const String id = 'id';
  static const String idproduk = 'idproduk';
  static const String hargamodal = 'hargamodal';
  static const String hargajual = 'hargajual';
  static const String serial = 'serial';
}

class TbLongLat {
  static const String tableName = 'tb_longlat';
  static const String id = 'id';
  static const String long = 'long';
  static const String lat = 'lat';
  static const String tgl = 'tgl';
}
