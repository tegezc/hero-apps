import 'package:hero/http/retur/httpretur.dart';
import 'package:hero/model/retur.dart';
import 'package:hero/util/dateutil.dart';
import 'package:rxdart/subjects.dart';

class BlocHpRetur {
  UIHpRetur? _cacheItem;
  final HttpRetur _httpRetur = HttpRetur();

  final BehaviorSubject<UIHpRetur?> _uihpretur = BehaviorSubject();

  Stream<UIHpRetur?> get uihpretur => _uihpretur.stream;

  void firstTime() {
    _cacheItem = UIHpRetur();
    _cacheItem!.tglAkhir = null;
    _cacheItem!.tglAwal = null;
    _cacheItem!.lretur = [];
    _cacheItem!.page = 1;
    _sinkItem(_cacheItem);
  }

  void searchRangeTanggal() {
    _cacheItem!.page = 1;
    _httpRetur
        .getRetur(_cacheItem!.tglAwal, _cacheItem!.tglAkhir, 1)
        .then((value) {
      if (value != null) {
        _cacheItem!.lretur = value;
        _sinkItem(_cacheItem);
      }
    });
    // _cacheItem.lretur = _dummy();
    // this._sinkItem(_cacheItem);
  }

  // List<Retur> _dummy() {
  //   List<Retur> lretur = List();
  //   Map<String, dynamic> map = {
  //     "serial_number": "9000011113",
  //     "tgl_retur": "2020-12-08",
  //     "tgl_approval": "0000-00-00",
  //     "status": "WAITING APPROVAL"
  //   };
  //   for (int i = 0; i < 50; i++) {
  //     lretur.add(Retur.fromJson(map));
  //   }
  //   return lretur;
  // }

  void showMore() {
    _cacheItem!.page = _cacheItem!.page! + 1;
    _httpRetur
        .getRetur(_cacheItem!.tglAwal, _cacheItem!.tglAkhir, _cacheItem!.page)
        .then((value) {
      if (value != null) {
        _cacheItem!.lretur!.addAll(value);
        _sinkItem(_cacheItem);
      }
    });

    // _cacheItem.lretur.addAll(_dummy());
    // this._sinkItem(_cacheItem);
  }

  void searchBySerial(String serial) {
    _cacheItem!.page = 0;
    _httpRetur
        .cariRetur(_cacheItem!.tglAwal, _cacheItem!.tglAkhir, serial)
        .then((value) {
      if (value != null) {
        _cacheItem!.lretur = value;
        _sinkItem(_cacheItem);
      }
    });
  }

  void pickComboAwal(DateTime dt) {
    _cacheItem!.tglAwal = dt;
    if (_cacheItem!.tglAkhir != null) {
      bool ok = _cacheItem!.tglAkhir!.isBefore(_cacheItem!.tglAwal!);

      if (ok) {
        _cacheItem!.tglAkhir = _cacheItem!.tglAwal;
      }
    }
    _sinkItem(_cacheItem);
  }

  void pickComboAkhir(DateTime dt) {
    _cacheItem!.tglAkhir = dt;
    _sinkItem(_cacheItem);
  }

  void _sinkItem(UIHpRetur? item) {
    _uihpretur.sink.add(item);
  }

  void dispose() {
    _uihpretur.close();
  }
}

class UIHpRetur {
  List<Retur>? lretur;
  DateTime? tglAwal;
  DateTime? tglAkhir;
  int? page;

  String getStrAwal() {
    if (tglAwal == null) {
      return 'Tanggal Awal';
    }
    return DateUtility.dateToStringDdMmYyyy(tglAwal);
  }

  String getStrAkhir() {
    if (tglAkhir == null) {
      return 'Tanggal Akhir';
    }
    return DateUtility.dateToStringDdMmYyyy(tglAkhir);
  }

  bool isRangeValid() {
    if (tglAwal != null && tglAkhir != null) {
      return true;
    }
    return false;
  }

  int getCountList() {
    if (lretur == null) {
      return 0;
    }

    if (isShowmoreVisible()) {
      return lretur!.length + 1;
    }
    return lretur!.length;
  }

  bool isShowmoreVisible() {
    if (lretur == null) {
      return false;
    }

    if (lretur!.isEmpty) {
      return false;
    }

    if (page == 0) {
      return false;
    }

    int hm = lretur!.length % 50;
    if (hm == 0) {
      return true;
    }

    return false;
  }
}
