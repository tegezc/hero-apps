class TbProv {
  static final String tableName = 'tb_provinsi';
  static final String id = 'id';
  static final String realid = 'realid';
  static final String nama = 'nama';
}

class TbKab {
  static final String tableName = 'tb_kabupaten';
  static final String id = 'id';
  static final String realid = 'realid';
  static final String idprov = 'idprov';
  static final String nama = 'nama';
}

class TbKec {
  static final String tableName = 'tb_kecamatan';
  static final String id = 'id';
  static final String idcluster = 'idcluster';
  static final String realid = 'realid';
  static final String idkab = 'idkab';
  static final String nama = 'nama';
}

class TbKel {
  static final String tableName = 'tb_kelurahan';
  static final String id = 'id';
  static final String idkec = 'idkec';
  static final String idkel = 'idkel';
  static final String nama = 'nama';
}

class TbSerial {
  static final String tableName = 'tb_serial';
  static final String id = 'id';
  static final String idproduk = 'idproduk';
  static final String hargamodal = 'hargamodal';
  static final String hargajual = 'hargajual';
  static final String serial = 'serial';
}

class TbLongLat {
  static final String tableName = 'tb_longlat';
  static final String id = 'id';
  static final String long = 'long';
  static final String lat = 'lat';
  static final String tgl = 'tgl';
}
