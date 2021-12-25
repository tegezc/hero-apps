import 'package:hero/http/retur/httpretur.dart';
import 'package:hero/model/retur.dart';
import 'package:hero/model/serialnumber.dart';

import 'package:rxdart/subjects.dart';

class BlocReturEditor {
  UIReturEditor? _cacheItem;
  HttpRetur _httpRetur = HttpRetur();

  final BehaviorSubject<UIReturEditor?> _uiretureditor = BehaviorSubject();

  Stream<UIReturEditor?> get uiretureditor => _uiretureditor.stream;

  void firstTime() {
    _cacheItem = UIReturEditor();
    _cacheItem!.lserialChecked = [];
    _cacheItem!.lserial = [];
    _httpRetur.comboAlasanRetur().then((value) {
      _cacheItem!.comboAlasan = value;
      this._sinkItem(_cacheItem);
    });
  }

  void searchSerialNumber(String seriawal, String seriakhir) {
    _httpRetur.getSerialnumberByRange(seriawal, seriakhir).then((value) {
      _cacheItem!.lserial = value;
      _cacheItem!.lserialChecked = [];
      this._sinkItem(_cacheItem);
    });
  }

  Future<bool> submitRetur() async {
    bool hasil = await _httpRetur.submitRetur(
        _cacheItem!.lserialChecked, '${_cacheItem!.currentAlasan!.id}');
    return hasil;
  }

  void comboAlasan(AlasanRetur? alasanRetur) {
    _cacheItem!.currentAlasan = alasanRetur;
    this._sinkItem(_cacheItem);
  }

  void checkRadio(int index, bool ischecked) {
    _cacheItem!.lserial![index].ischecked = ischecked;
    SerialNumber serial = _cacheItem!.lserial![index];
    if (ischecked) {
      _cacheItem!.lserialChecked.add(serial);
    } else {
      _cacheItem!.lserialChecked.remove(serial);
    }
    this._sinkItem(_cacheItem);
  }

  void _sinkItem(UIReturEditor? item) {
    _uiretureditor.sink.add(item);
  }

  void dispose() {
    _uiretureditor.close();
  }
}

class UIReturEditor {
  List<AlasanRetur>? comboAlasan;
  List<SerialNumber>? lserial;
  late List<SerialNumber> lserialChecked;
  AlasanRetur? currentAlasan;

  String getTotal() {
    return '${lserialChecked.length}/${lserial!.length}';
  }

  bool isSafetosubmit() {
    if (currentAlasan != null && lserialChecked.length > 0) {
      return true;
    }
    return false;
  }
}
