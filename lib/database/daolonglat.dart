import 'package:hero/database/stringdb.dart';
import 'package:hero/model/serialnumber.dart';
import 'package:hero/util/dateutil.dart';

import 'database.dart';

class DaoSerial {
  Future<int> saveLongLat(String long, String lat) async {
    String tgl = DateUtility.dateToStringLengkap(DateTime.now());
    var dbClient = await DatabaseHelper().db;
    int res = await dbClient!.insert(TbLongLat.tableName,
        {TbLongLat.lat: lat, TbLongLat.long: long, TbLongLat.tgl: tgl});
    return res;
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
    var dbClient = await DatabaseHelper().db;
    int res = await dbClient!.rawDelete('DELETE FROM ${TbSerial.tableName}');
    return res;
  }
}
