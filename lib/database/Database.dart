import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'stringdb.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db;

    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    //   Sqflite.devSetDebugModeOn(true);
//    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
//    String path = join(documentsDirectory.path, "keuangan.db");
    var theDb = await openDatabase(join(await getDatabasesPath(), 'hore.db'),
        version: 1, onCreate: _onCreate);
    return theDb;
  }

//  void _onUpgrade(Database db, int versio) async {
//    await db.execute("DROP TABLE ${GSD.tableSpecialDay}");
//    await db.execute(
//        "CREATE TABLE ${GSD.tableSpecialDay}(${GSD.sdId} INTEGER PRIMARY KEY, ${GSD.sdTanggal} TEXT,${GSD.sdArrayTanggal} TEXT, ${GSD.sdStringTanggal} TEXT)");
//  }

  void _onCreate(Database db, int version) async {
    // await db.execute("CREATE TABLE "
    //     "${TbProv.tableName}(${TbProv.id} INTEGER PRIMARY KEY, "
    //     "${TbProv.realid} TEXT,"
    //     "${TbProv.nama} TEXT)");
    // await db.execute(
    //     "CREATE TABLE ${TbKab.tableName}(${TbKab.id} INTEGER PRIMARY KEY, "
    //     "${TbKab.realid} TEXT,"
    //     "${TbKab.idprov} TEXT, "
    //     "${TbKab.nama} TEXT)");
    // await db.execute(
    //     "CREATE TABLE ${TbKec.tableName}(${TbKec.id} INTEGER PRIMARY KEY, "
    //     "${TbKec.realid} TEXT,"
    //     "${TbKec.idcluster} TEXT, "
    //     "${TbKec.idkab} TEXT, "
    //     "${TbKec.nama} TEXT)");
    // await db.execute(
    //     "CREATE TABLE ${TbKel.tableName}(${TbKel.id} INTEGER PRIMARY KEY, "
    //     "${TbKel.idkec} TEXT, "
    //     "${TbKel.idkel} TEXT, "
    //     "${TbKel.nama} TEXT)");

    await db.execute(
        "CREATE TABLE ${TbSerial.tableName}(${TbSerial.id} INTEGER PRIMARY KEY, "
        "${TbSerial.idproduk} TEXT, "
        "${TbSerial.hargamodal} INTEGER,"
        "${TbSerial.hargajual} INTEGER,"
        "${TbSerial.serial} TEXT)");
    await db.execute(
        "CREATE TABLE ${TbLongLat.tableName}(${TbLongLat.id} INTEGER PRIMARY KEY, "
        "${TbLongLat.long} TEXT, "
        "${TbLongLat.lat} TEXT,"
        "${TbLongLat.tgl} TEXT)");
  }
}
