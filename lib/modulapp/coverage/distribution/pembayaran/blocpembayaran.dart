import 'package:hero/core/database/daoserial.dart';
import 'package:hero/http/coverage/httpdistibusi.dart';
import 'package:hero/model/distribusi/datapembeli.dart';
import 'package:hero/model/pjp.dart';
import 'package:hero/model/serialnumber.dart';
import 'package:hero/modulapp/coverage/distribution/pembayaran/pembayarandistribusi.dart';
import 'package:hero/util/constapp/accountcontroller.dart';
import 'package:hero/util/numberconverter.dart';
import 'package:rxdart/subjects.dart';

class BlocPembayaran {
  final UIPembayaran _cachePembelian = UIPembayaran();
  final HttpDIstribution _httpDIstribution = HttpDIstribution();
  final DaoSerial _daoSerial = DaoSerial();

  final BehaviorSubject<UIPembayaran> _uipembayaran = BehaviorSubject();

  Stream<UIPembayaran> get uipembayaran => _uipembayaran.stream;

  void firstime(List<ItemTransaksi>? ltrx, Pjp pjp) {
    setupPembayaran(ltrx, pjp).then((value) {
      if (value) {
        _sink(_cachePembelian);
      }
    });
  }

  Future<bool> setupPembayaran(List<ItemTransaksi>? ltrx, Pjp pjp) async {
    if (ltrx == null) {
      return false;
    }

    _cachePembelian.enumAccount = await AccountHore.getAccount();

    List<ItemPembayaran> lpemb = [];
    for (var element in ltrx) {
      if (element.jumlah! > 0) {
        lpemb.add(ItemPembayaran(element, EnumCaraBayar.lunas));
      }
    }
    _cachePembelian.lpembayaran = lpemb;
    DataPembeli dp = DataPembeli();
    dp.lserial = await _daoSerial.getAllSn();
    _cachePembelian.maxlinkaja = await _httpDIstribution.getSisaLinkaja();
    dp.nohppembeli = pjp.nohp;
    dp.namapembeli = pjp.tempat!.nama;
    dp.idtempat = pjp.id;
    dp.linkaja = 0;
    _cachePembelian.dataPembeli = dp;
    return true;
  }

  void changeRadio(int index, EnumCaraBayar? value) {
    _cachePembelian.lpembayaran![index].groupRadio = value;
    _sink(_cachePembelian);
  }

  void onChagedText(String str) {
    if (str.isNotEmpty) {
      int? tmp = ConverterNumber.stringToInt(str);
      _cachePembelian.dataPembeli.linkaja = tmp;
      _sink(_cachePembelian);
    }
  }

  Future<bool> bayar() async {
    List<SerialNumber> snlunas = [];
    List<SerialNumber> snkonsinyasi = [];

    // cari lunas / konsinyasi
    for (int i = 0; i < _cachePembelian.lpembayaran!.length; i++) {
      ItemPembayaran item = _cachePembelian.lpembayaran![i];
      List<SerialNumber> lsn =
          await _daoSerial.getSerialByIdProduct(item.trx.product!.id);
      if (item.groupRadio == EnumCaraBayar.lunas) {
        snlunas.addAll(lsn);
      } else {
        snkonsinyasi.addAll(lsn);
      }
    }

    DataPembeli pembeliLunas = DataPembeli();
    pembeliLunas.linkaja = _cachePembelian.dataPembeli.linkaja;
    pembeliLunas.nohppembeli = _cachePembelian.dataPembeli.nohppembeli;
    pembeliLunas.namapembeli = _cachePembelian.dataPembeli.namapembeli;
    pembeliLunas.idtempat = _cachePembelian.dataPembeli.idtempat;
    pembeliLunas.lserial = snlunas;

    DataPembeli pembeliKonsinyasi = _cachePembelian.dataPembeli;
    pembeliKonsinyasi.linkaja = 0;
    pembeliKonsinyasi.nohppembeli = _cachePembelian.dataPembeli.nohppembeli;
    pembeliKonsinyasi.namapembeli = _cachePembelian.dataPembeli.namapembeli;
    pembeliKonsinyasi.idtempat = _cachePembelian.dataPembeli.idtempat;
    pembeliKonsinyasi.lserial = snkonsinyasi;

    bool returnvalue = false;
    if (snlunas.isNotEmpty) {
      bool value = await _httpDIstribution.submitLunas(pembeliLunas);

      returnvalue = value;
    }

    if (snkonsinyasi.isNotEmpty) {
      bool value = await _httpDIstribution.submitKonsinyasi(pembeliKonsinyasi);

      returnvalue = value;
    }

    if (returnvalue) {
      int res = await _daoSerial.deleteAllSerial();
      if (res > 0) {}
    }
    return returnvalue;
  }

  Future<EnumDelete> deleteITem(int index) async {
    ItemPembayaran item = _cachePembelian.lpembayaran![index];
    int res = await _daoSerial.deleteSerialByIdProduct(item.trx.product!.id);
    if (res > 0) {
      _cachePembelian.lpembayaran!.removeAt(index);
      if (_cachePembelian.lpembayaran!.isNotEmpty) {
        return EnumDelete.suksessisa;
      } else {
        return EnumDelete.sukseshabis;
      }
    }
    return EnumDelete.gagal;
  }

  /// for ds
  void setNohpPembeli(String nohp) {
    _cachePembelian.dataPembeli.nohppembeli = nohp;
  }

  void refresh() {
    _sink(_cachePembelian);
  }

  void _sink(UIPembayaran item) {
    _uipembayaran.sink.add(item);
  }

  void dispose() {
    _uipembayaran.close();
  }
}

class UIPembayaran {
  late DataPembeli dataPembeli;
  List<ItemPembayaran>? lpembayaran;
  int? maxlinkaja;
  EnumAccount? enumAccount;

  int _totalLunas = 0;
  int _totalKonsinyasi = 0;

  int getTotalPembayaran() {
    return _totalLunas + _totalKonsinyasi + dataPembeli.linkaja!;
  }

  int getTotalLunas() {
    int tmp = 0;
    if (lpembayaran != null) {
      for (var element in lpembayaran!) {
        if (element.groupRadio == EnumCaraBayar.lunas) {
          tmp = tmp + (element.trx.jumlah! * element.trx.product!.hargajual!);
        }
      }
    }
    _totalLunas = tmp;
    return tmp;
  }

  int getTotalKonsinyasi() {
    int tmp = 0;
    if (lpembayaran != null) {
      for (var element in lpembayaran!) {
        if (element.groupRadio == EnumCaraBayar.konsinyasi) {
          tmp = tmp + (element.trx.jumlah! * element.trx.product!.hargajual!);
        }
      }
    }
    _totalKonsinyasi = tmp;
    return tmp;
  }

  bool isvalid() {
    if (dataPembeli.linkaja != null) {
      if (dataPembeli.linkaja! > maxlinkaja!) {
        return false;
      }
    }
    return true;
  }
}

// sukseshabis: delete sukses dan item habis setelah dilakkan delete tersebut
enum EnumDelete { gagal, sukseshabis, suksessisa }
