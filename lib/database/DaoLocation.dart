// ignore_for_file: file_names

import 'package:hero/model/lokasi/lokasimodel.dart';
import 'package:hero/util/csvutil.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:developer' as logger;

import 'Database.dart';
import 'stringdb.dart';

class SetupData1 {
  Future<bool> setupData() async {
    try {
      bool isDataExist = await _checkIsExist();
      if (!isDataExist) {
        CSVReader csvReader = new CSVReader();

        List<Provinsi> lprov = await csvReader.getListProvinsi();
        List<Kabupaten> lkab = await csvReader.getListKabupaten();
        List<Kecamatan> lkec = await csvReader.getListKecamatan();
        List<Kelurahan> lkel = await csvReader.getListKelurahan();

        // print('prov: ${lprov.length}'
        //     '|kab: ${lkab.length}'
        //     '|lkec: ${lkec.length}'
        //     '|lkel: ${lkel.length}');

        var dbClient = await (DatabaseHelper().db as Future<Database>);
        await dbClient.transaction((txn) async {
          var batch = txn.batch();

          // insert provinsi
          for (int i = 0; i < lprov.length; i++) {
            Provinsi p = lprov[i];
            batch.insert(TbProv.tableName, p.toMap());
          }

          // insert kabupaten
          for (int i = 0; i < lkab.length; i++) {
            Kabupaten k = lkab[i];
            batch.insert(TbKab.tableName, k.toMap());
          }

          // insert kecamatan
          for (int i = 0; i < lkec.length; i++) {
            Kecamatan k = lkec[i];
            batch.insert(TbKec.tableName, k.toMap());
          }

          // insert Kelurahan
          for (int i = 0; i < lkel.length; i++) {
            Kelurahan k = lkel[i];
            batch.insert(TbKel.tableName, k.toMap());
          }

          var results = await batch.commit(noResult: true);

          return results;
        });
      }
    } catch (err) {
      print('Caught error: $err');
      return false;
    }
    return true;
  }

  Future<bool> _checkIsExist() async {
    var dbClient = await (DatabaseHelper().db as Future<Database>);

    int count = Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM ${TbProv.tableName}'))!;
    return count > 0;
  }
}

class DaoProvinsi1 {
  Provinsi _createObject(Map<String, dynamic> map) {
    return new Provinsi.formDb(
        map[TbProv.id], map[TbProv.realid], map[TbProv.nama]);
  }

  Future<List<Provinsi>> getAllProvinsi() async {
    var dbClient = await (DatabaseHelper().db as Future<Database>);
    List<Map> list =
        await dbClient.rawQuery('SELECT * FROM ${TbProv.tableName}');
    List<Provinsi> lprov = [];

    for (int i = 0; i < list.length; i++) {
      Provinsi prov = this._createObject(list[i] as Map<String, dynamic>);

      lprov.add(prov);
    }
    return lprov;
  }

  Future<Provinsi?> getProvById(String idprov) async {
    var dbClient = await (DatabaseHelper().db as Future<Database>);
    List<Map> list = await dbClient.rawQuery(
        'SELECT * FROM ${TbProv.tableName} WHERE ${TbProv.realid}=\'$idprov\'');

    Provinsi? prov;
    if (list.length > 0) {
      prov = this._createObject(list[0] as Map<String, dynamic>);
    }
    return prov;
  }
}

class DaoKecamatan1 {
  Kecamatan _createObject(Map<String, dynamic> map) {
    return new Kecamatan.fromDb(map[TbKec.id], map[TbKec.realid],
        map[TbKec.idcluster], map[TbKec.idkab], map[TbKec.nama]);
  }

  Future<List<Kecamatan>> getAllKecamatan() async {
    var dbClient = await (DatabaseHelper().db as Future<Database>);
    List<Map> list =
        await dbClient.rawQuery('SELECT * FROM ${TbKec.tableName}');

    List<Kecamatan> lkec = [];
    for (int i = 0; i < list.length; i++) {
      Kecamatan prov = this._createObject(list[i] as Map<String, dynamic>);

      lkec.add(prov);
    }
    return lkec;
  }

  Future<List<Kecamatan>> getKecamatanByKabupaten(String idkab) async {
    var dbClient = await (DatabaseHelper().db as Future<Database>);
    List<Map> list = await dbClient.rawQuery(
        'SELECT * FROM ${TbKec.tableName} WHERE ${TbKec.idkab}=\'$idkab\'');

    List<Kecamatan> lkec = [];
    for (int i = 0; i < list.length; i++) {
      Kecamatan prov = this._createObject(list[i] as Map<String, dynamic>);

      lkec.add(prov);
    }
    return lkec;
  }

  Future<Kecamatan?> getKecById(String idkec) async {
    var dbClient = await (DatabaseHelper().db as Future<Database>);
    List<Map> list = await dbClient.rawQuery(
        'SELECT * FROM ${TbKec.tableName} WHERE ${TbKec.realid}=\'$idkec\'');

    Kecamatan? kec;
    if (list.length > 0) {
      kec = _createObject(list[0] as Map<String, dynamic>);
    }
    return kec;
  }
}

class DaoKabupaten1 {
  Kabupaten _createObject(Map<String, dynamic> map) {
    return new Kabupaten.formDb(
        map[TbKab.id], map[TbKab.realid], map[TbKab.idprov], map[TbKab.nama]);
  }

  Future<List<Kabupaten>> getAllKabupaten() async {
    var dbClient = await (DatabaseHelper().db as Future<Database>);
    List<Map> list =
        await dbClient.rawQuery('SELECT * FROM ${TbKab.tableName}');

    List<Kabupaten> lkab = [];
    for (int i = 0; i < list.length; i++) {
      Kabupaten prov = this._createObject(list[i] as Map<String, dynamic>);

      lkab.add(prov);
    }
    return lkab;
  }

  Future<List<Kabupaten>> getKabupatenByProvid(String provid) async {
    var dbClient = await (DatabaseHelper().db as Future<Database>);
    List<Map> list = await dbClient.rawQuery(
        'SELECT * FROM ${TbKab.tableName} WHERE ${TbKab.idprov}=\'$provid\'');

    List<Kabupaten> lkab = [];
    for (int i = 0; i < list.length; i++) {
      Kabupaten prov = this._createObject(list[i] as Map<String, dynamic>);

      lkab.add(prov);
    }
    return lkab;
  }

  Future<Kabupaten?> getKabById(String idkab) async {
    var dbClient = await (DatabaseHelper().db as Future<Database>);
    List<Map> list = await dbClient.rawQuery(
        'SELECT * FROM ${TbKab.tableName} WHERE ${TbKab.realid}=\'$idkab\'');

    Kabupaten? kab;
    if (list.length > 0) {
      kab = this._createObject(list[0] as Map<String, dynamic>);
    }
    return kab;
  }
}

class DaoKelurahan1 {
  Kelurahan _createObject(Map<String, dynamic> map) {
    return new Kelurahan.fromDb(
        map[TbKel.id], map[TbKel.idkec], map[TbKel.idkel], map[TbKel.nama]);
  }

  Future<List<Kelurahan>> getAllKelurahan() async {
    var dbClient = await (DatabaseHelper().db as Future<Database>);
    List<Map> list =
        await dbClient.rawQuery('SELECT * FROM ${TbKel.tableName}');
    //print('kab: ${list.length}');
    logger.log('kab: ${list.length}');
    List<Kelurahan> lkel = [];
    for (int i = 0; i < list.length; i++) {
      Kelurahan kel = this._createObject(list[i] as Map<String, dynamic>);

      lkel.add(kel);
    }
    return lkel;
  }

  Future<List<Kelurahan>> getKelByKecId(String kecId) async {
    var dbClient = await (DatabaseHelper().db as Future<Database>);
    List<Map> list = await dbClient.rawQuery(
        'SELECT * FROM ${TbKel.tableName} WHERE ${TbKel.idkec}=\'$kecId\'');

    List<Kelurahan> lkel = [];
    for (int i = 0; i < list.length; i++) {
      Kelurahan kel = this._createObject(list[i] as Map<String, dynamic>);

      lkel.add(kel);
    }
    return lkel;
  }

  Future<Kelurahan?> getKelById(String kelid) async {
    var dbClient = await (DatabaseHelper().db as Future<Database>);
    List<Map> list = await dbClient.rawQuery(
        'SELECT * FROM ${TbKel.tableName} WHERE ${TbKel.idkel}=\'$kelid\'');

    Kelurahan? kel;
    if (list.length > 0) {
      kel = this._createObject(list[0] as Map<String, dynamic>);
    }
    return kel;
  }
}
