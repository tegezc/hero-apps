import 'package:hero/database/stringdb.dart';
import 'package:hero/model/serialnumber.dart';
import 'package:sqflite/sqflite.dart';

import 'Database.dart';

class DaoSerial {
  Future<bool> batchInsert(List<SerialNumber>? lserial) async {
    try {
      if (lserial != null) {
        var dbClient = await DatabaseHelper().db;
        await dbClient!.transaction((txn) async {
          var batch = txn.batch();

          for (int i = 0; i < lserial.length; i++) {
            SerialNumber p = lserial[i];
            batch.insert(TbSerial.tableName, p.toMap());
          }

          var results = await batch.commit(noResult: true);

          return results;
        });
      }
    } catch (err) {
      return false;
    }
    return true;
  }

  Future<int?> getCountByIdProduct(String? idproduct) async {
    var dbClient = await (DatabaseHelper().db);

    int? count = Sqflite.firstIntValue(await dbClient!.rawQuery(
        'SELECT COUNT(*) FROM ${TbSerial.tableName} WHERE ${TbSerial.idproduk}=$idproduct'));

    return count;
  }

  Future<List<SerialNumber>> getSerialByIdProduct(String? idproduct) async {
    var dbClient = await (DatabaseHelper().db);
    List<Map> list = await dbClient!.rawQuery(
        'SELECT * FROM ${TbSerial.tableName} WHERE ${TbSerial.idproduk}=$idproduct');

    List<SerialNumber> lseri = [];
    for (int i = 0; i < list.length; i++) {
      SerialNumber serial = _createSeri(list[i] as Map<String, dynamic>);
      serial.ischecked = true;

      lseri.add(serial);
    }

    return lseri;
  }

  Future<List<SerialNumber>> getAllSn() async {
    var dbClient = await DatabaseHelper().db;
    List<Map> list =
        await dbClient!.rawQuery('SELECT * FROM ${TbSerial.tableName}');

    List<SerialNumber> lseri = [];
    for (int i = 0; i < list.length; i++) {
      SerialNumber serial = _createSeri(list[i] as Map<String, dynamic>);

      lseri.add(serial);
    }

    return lseri;
  }

  SerialNumber _createSeri(Map<String, dynamic> map) {
    return SerialNumber.fromDb(
      serial: map[TbSerial.serial],
      hargajual: map[TbSerial.hargajual],
      hargamodal: map[TbSerial.hargamodal],
      idproduct: map[TbSerial.idproduk],
    );
  }

  Future<int> deleteAllSerial() async {
    var dbClient = await (DatabaseHelper().db);
    int res = await dbClient!.rawDelete('DELETE FROM ${TbSerial.tableName}');
    return res;
  }

  Future<int> deleteSerialByIdProduct(String? idproduct) async {
    var dbClient = await DatabaseHelper().db;
    int res = await dbClient!.rawDelete(
        'DELETE FROM ${TbSerial.tableName} WHERE ${TbSerial.idproduk}=$idproduct');
    return res;
  }
}
