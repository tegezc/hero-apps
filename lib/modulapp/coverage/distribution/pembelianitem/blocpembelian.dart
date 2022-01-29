import 'package:hero/core/data/datasources/database/daoserial.dart';
import 'package:hero/http/coverage/httpdistibusi.dart';
import 'package:hero/model/distribusi/datapembeli.dart';
import 'package:hero/model/serialnumber.dart';
import 'package:rxdart/subjects.dart';

class BlocPembelian {
  final UIPembelian _cachePembelian = UIPembelian();
  List<SerialNumber>? _cacheLsn;
  final HttpDIstribution _httpDIstribution = HttpDIstribution();
  final DaoSerial _daoSerial = DaoSerial();

  final BehaviorSubject<UIPembelian> _uiPembelian = BehaviorSubject();

  Stream<UIPembelian> get uiPembelian => _uiPembelian.stream;

  void firstTime(ItemTransaksi? transaksi) {
    _cachePembelian.trx = transaksi;
    _cachePembelian.lserial = [];
    _cachePembelian.lserialChecked = [];
    _sink(_cachePembelian);
  }

  void semuaSerial() async {
    _semuaSerial().then((value) {
      if (value) {
        _sink(_cachePembelian);
      }
    });
  }

  Future<bool> _semuaSerial() async {
    List<SerialNumber>? allsn = await _httpDIstribution
        .getAllDaftarSn(_cachePembelian.trx!.product!.id);
    _cachePembelian.lserialChecked =
        await _daoSerial.getSerialByIdProduct(_cachePembelian.trx!.product!.id);
    if (allsn != null) {
      _cacheLsn = List.from(allsn);
      for (var element in _cachePembelian.lserialChecked!) {
        int index = allsn.indexOf(element);
        allsn[index].ischecked = true;
      }
      _cachePembelian.lserial = allsn;
    }
    return true;
  }

  void cariSerial(String snawal, String snakhir) async {
    _olahPencarian(snawal, snakhir).then((value) {
      if (value) {
        _sink(_cachePembelian);
      }
    });
  }

  Future<bool> _olahPencarian(String snawal, String snakhir) async {
    List<SerialNumber>? lsn = await _httpDIstribution.getDaftarSn(
        _cachePembelian.trx!.product!.id, snawal, snakhir);
    _cachePembelian.lserialChecked =
        await _daoSerial.getSerialByIdProduct(_cachePembelian.trx!.product!.id);

    if (lsn != null) {
      _cacheLsn = List.from(lsn);
      for (var element in lsn) {
        int index = lsn.indexOf(element);
        lsn[index].ischecked = true;
      }
      for (var element in _cachePembelian.lserialChecked!) {
        int index = lsn.indexOf(element);
        lsn[index].ischecked = true;
      }
      _cachePembelian.lserial = List.from(lsn);
    }
    return true;
  }

  void changeRadio(int index, bool value) {
    _cachePembelian.lserial[index].ischecked = value;
    SerialNumber serial = _cachePembelian.lserial[index];
    if (value) {
      _cachePembelian.lserialChecked!.add(serial);
    } else {
      _cachePembelian.lserialChecked!.remove(serial);
    }

    List<SerialNumber> lsn = List.from(_cacheLsn!);
    for (var element in _cachePembelian.lserialChecked!) {
      int index = lsn.indexOf(element);
      lsn[index].ischecked = true;
    }
    _cachePembelian.lserial = lsn;
    _sink(_cachePembelian);
  }

  Future<bool> beli() async {
    int res = await _daoSerial
        .deleteSerialByIdProduct(_cachePembelian.trx!.product!.id);
    if (res >= 0) {}
    bool result = await _daoSerial.batchInsert(_cachePembelian.lserialChecked);
    return result;
  }

  void _sink(UIPembelian item) {
    _uiPembelian.sink.add(item);
  }

  void dispose() {
    _uiPembelian.close();
  }
}

class UIPembelian {
  ItemTransaksi? trx;
  late List<SerialNumber> lserial;

  List<SerialNumber>? lserialChecked;

  String getTotal() {
    return '${lserialChecked!.length}/${lserial.length}';
  }

  bool isSafetosubmit() {
    if (lserialChecked == null) {
      return false;
    }
    if (lserialChecked!.isNotEmpty) {
      return true;
    }
    return false;
  }
}
