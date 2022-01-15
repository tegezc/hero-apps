import 'package:hero/http/httphpsearchds.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/sf/itemsearchoutlet.dart';
import 'package:hero/util/dateutil.dart';
import 'package:rxdart/subjects.dart';

class BlocPageTabDs {
  UIPageTabDs? _cacheItem;
  final HttphpsearchDs _httpPageDs = HttphpsearchDs();

  final BehaviorSubject<UIPageTabDs?> _uihpsurvey = BehaviorSubject();

  Stream<UIPageTabDs?> get uihpretur => _uihpsurvey.stream;

  void firstTime() {
    _cacheItem = UIPageTabDs();
    _cacheItem!.tglAkhir = null;
    _cacheItem!.tglAwal = null;
    _cacheItem!.lLokasi = [];
    _cacheItem!.page = 1;
    _cacheItem!.query = '';
    //  _cacheItem.lcombo = ItemUi.getcombojenislokasi();
    _sinkItem(_cacheItem);
  }

  void searchRangeTanggal(EnumTab enumTab) {
    _cacheItem!.page = 1;
    _httpPageDs
        .getDaftarLokasi(enumTab, _cacheItem!.tglAwal, _cacheItem!.tglAkhir, 1)
        .then((value) {
      if (value != null) {
        UIPageTabDs item = value;
        _cacheItem!.maxrecordperhit = item.maxrecordperhit;
        _cacheItem!.lLokasi!.clear();
        _cacheItem!.lLokasi!.addAll(item.lLokasi!);
        _cacheItem!.total = item.total;
        _sinkItem(_cacheItem);
      }
    });
  }

  void showmore(EnumTab enumTab) {
    _cacheItem!.page = _cacheItem!.page + 1;
    _httpPageDs
        .getDaftarLokasi(enumTab, _cacheItem!.tglAwal, _cacheItem!.tglAkhir,
            _cacheItem!.page)
        .then((value) {
      if (value != null) {
        UIPageTabDs item = value;
        _cacheItem!.lLokasi!.addAll(item.lLokasi!);
        _sinkItem(_cacheItem);
      }
    });
  }

  void searchByQuery(EnumTab enumTab, String query) {
    _cacheItem!.page = 0;
    _httpPageDs
        .cariLokasi(enumTab, _cacheItem!.tglAwal, _cacheItem!.tglAkhir, query)
        .then((value) {
      if (value != null) {
        _cacheItem!.lLokasi = value;
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

  // void pickComboJenisLokasi(ItemComboJenisLokasi clok) {
  //   _cacheItem.currentLokasi = clok;
  //   _sinkItem(_cacheItem);
  // }

  void _sinkItem(UIPageTabDs? item) {
    _uihpsurvey.sink.add(item);
  }

  void dispose() {
    _uihpsurvey.close();
  }
}

class UIPageTabDs {
  List<LokasiSearch>? lLokasi;
  DateTime? tglAwal;
  DateTime? tglAkhir;
  int page = 1;
  int? total = 0;
  int? maxrecordperhit = 0;
//  ItemComboJenisLokasi currentLokasi;
  String query = '';
  // List<ItemComboJenisLokasi> lcombo;

  int getCountList() {
    if (lLokasi == null) {
      return 0;
    }

    if (isShowmoreVisible()) {
      return lLokasi!.length + 1;
    }
    return lLokasi!.length;
  }

  bool isShowmoreVisible() {
    if (lLokasi == null) {
      return false;
    }

    if (lLokasi!.isEmpty) {
      return false;
    }

    if (page == 0) {
      return false;
    }

    int hm = lLokasi!.length % 50;
    if (hm == 0) {
      return true;
    }

    return false;
  }

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
}
