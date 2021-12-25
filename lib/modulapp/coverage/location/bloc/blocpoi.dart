import 'package:hero/http/httplokasi/httpPoi.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/lokasi/poi.dart';
import 'package:hero/util/locationutil.dart';
import 'package:location/location.dart';
import 'package:rxdart/subjects.dart';

import 'abstractbloclokasi.dart';

class UIPoi {
  late Poi poi;

  EnumStateWidget? enumStateWidget;
  EnumEditorState? enumEditorState;
}

class BlocPoi extends AbsBlocLokasi {
  UIPoi? _cacheUipoi;

  final BehaviorSubject<UIPoi?> _uipoi = BehaviorSubject();

  Stream<UIPoi?> get uipoi => _uipoi.stream;

  UIPoi? getUipoi() {
    return _cacheUipoi;
  }

  void firstTimeEdit(String? idpoi) async {
    //super.init(EnumEditorState.edit);
    _cacheUipoi = new UIPoi();
    _cacheUipoi!.enumEditorState = EnumEditorState.edit;
    _cacheUipoi!.enumStateWidget = EnumStateWidget.active;
    _firtimeEditSetup(idpoi).then((value) {
      if (value) {
        this._sink(_cacheUipoi);
      }
    });
  }

  Future<bool> _firtimeEditSetup(String? idpoi) async {
    HttpPoi httpController = new HttpPoi();
    List<dynamic>? response = await httpController.detailPoi(idpoi);
    if (response != null) {
      if (response.length > 0) {
        Map<String, dynamic> map = response[0];
        Poi poi = Poi.fromJson(map);

        super.init(EnumEditorState.edit, poi.idkel);
        _cacheUipoi!.poi = poi;
        return true;
      }
    } else {
      return false;
    }
    return false;
  }

  void firstTimeBaru() {
    super.init(EnumEditorState.baru, null);
    _cacheUipoi = new UIPoi();
    _cacheUipoi!.enumEditorState = EnumEditorState.baru;
    _cacheUipoi!.poi = Poi.kosong();
    setupAsync().then((value) {
      print(value);
      if (value) {
        this._sink(_cacheUipoi);
      }
    });
  }

  Future<bool> setupAsync() async {
    LocationData position = await LocationUtil.getCurrentLocation();
    _cacheUipoi!.poi.long = position.longitude;
    _cacheUipoi!.poi.lat = position.latitude;
    return true;
  }

  void updateLongLat() {
    LocationUtil.getCurrentLocation().then((value) {
      _cacheUipoi!.poi.long = value.longitude;
      _cacheUipoi!.poi.lat = value.latitude;
      this._sink(_cacheUipoi);
    });
  }

  Future<bool> savePoi() async {
    _cacheUipoi!.enumStateWidget = EnumStateWidget.loading;
    this._sink(_cacheUipoi);

    HttpPoi httpController = new HttpPoi();
    Map<String, dynamic>? response =
        await httpController.createPoi(_cacheUipoi!.poi);
    _cacheUipoi!.enumStateWidget = EnumStateWidget.done;
    this._sink(_cacheUipoi);
    if (response != null) {
      if (response['status'] == 201) {
        return true;
      }
      return false;
    }
    return false;
  }

  Future<bool> updatePoi() async {
    print('update');
    _cacheUipoi!.enumStateWidget = EnumStateWidget.loading;
    this._sink(_cacheUipoi);

    HttpPoi httpController = new HttpPoi();
    Map<String, dynamic>? response =
        await httpController.updatePoi(_cacheUipoi!.poi);
    _cacheUipoi!.enumStateWidget = EnumStateWidget.done;
    this._sink(_cacheUipoi);
    if (response != null) {
      if (response['status'] == 200) {
        return true;
      }
      return false;
    }
    return false;
  }

  void _sink(UIPoi? item) {
    _uipoi.sink.add(item);
  }

  void dispose() {
    _uipoi.close();
  }

  void setNamaPoi(String t) {
    _cacheUipoi!.poi.nama = t;
  }

  void setAlamat(String t) {
    _cacheUipoi!.poi.alamat = t;
  }

  void setLongitude(String t) {
    if (t.length > 0) {
      _cacheUipoi!.poi.long = double.tryParse(t);
    }
  }

  void setLatitude(String t) {
    if (t.length > 0) {
      _cacheUipoi!.poi.lat = double.tryParse(t);
    }
  }

  @override
  void operationCompleted() {
    this._sink(_cacheUipoi);
  }

  @override
  bool isValid() {
    this.setValueBeforeCreateUpdate();
    return _cacheUipoi!.poi.isValid();
  }

  @override
  void setValueBeforeCreateUpdate() {
    _cacheUipoi!.poi.idkel = controllLokasi!.getIdKel();
  }
}
