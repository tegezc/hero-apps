import 'package:hero/http/httplokasi/http_poi.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/lokasi/poi.dart';
import 'package:hero/core/domain/entities/tgzlocation.dart';
import 'package:hero/core/data/datasources/location/tgz_location.dart';
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
    _cacheUipoi = UIPoi();
    _cacheUipoi!.enumEditorState = EnumEditorState.edit;
    _cacheUipoi!.enumStateWidget = EnumStateWidget.active;
    _firtimeEditSetup(idpoi).then((value) {
      if (value) {
        _sink(_cacheUipoi);
      }
    });
  }

  Future<bool> _firtimeEditSetup(String? idpoi) async {
    HttpPoi httpController = HttpPoi();
    List<dynamic>? response = await httpController.detailPoi(idpoi);
    if (response != null) {
      if (response.isNotEmpty) {
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
    _cacheUipoi = UIPoi();
    _cacheUipoi!.enumEditorState = EnumEditorState.baru;
    _cacheUipoi!.poi = Poi.kosong();
    setupAsync().then((value) {
      if (value) {
        _sink(_cacheUipoi);
      }
    });
  }

  Future<bool> setupAsync() async {
    TgzLocationData? position =
        await TgzLocationDataSourceImpl().getCurrentLocationOrNull();
    if (position != null) {
      _cacheUipoi!.poi.long = position.longitude;
      _cacheUipoi!.poi.lat = position.latitude;
      return true;
    }
    return false;
  }

  void updateLongLat() {
    TgzLocationDataSourceImpl().getCurrentLocationOrNull().then((value) {
      if (value != null) {
        _cacheUipoi!.poi.long = value.longitude;
        _cacheUipoi!.poi.lat = value.latitude;
        _sink(_cacheUipoi);
      }
    });
  }

  Future<bool> savePoi() async {
    _cacheUipoi!.enumStateWidget = EnumStateWidget.loading;
    _sink(_cacheUipoi);

    HttpPoi httpController = HttpPoi();
    Map<String, dynamic>? response =
        await httpController.createPoi(_cacheUipoi!.poi);
    _cacheUipoi!.enumStateWidget = EnumStateWidget.done;
    _sink(_cacheUipoi);
    if (response != null) {
      if (response['status'] == 201) {
        return true;
      }
      return false;
    }
    return false;
  }

  Future<bool> updatePoi() async {
    _cacheUipoi!.enumStateWidget = EnumStateWidget.loading;
    _sink(_cacheUipoi);

    HttpPoi httpController = HttpPoi();
    Map<String, dynamic>? response =
        await httpController.updatePoi(_cacheUipoi!.poi);
    _cacheUipoi!.enumStateWidget = EnumStateWidget.done;
    _sink(_cacheUipoi);
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
    if (t.isNotEmpty) {
      _cacheUipoi!.poi.long = double.tryParse(t);
    }
  }

  void setLatitude(String t) {
    if (t.isNotEmpty) {
      _cacheUipoi!.poi.lat = double.tryParse(t);
    }
  }

  @override
  void operationCompleted() {
    _sink(_cacheUipoi);
  }

  @override
  bool isValid() {
    setValueBeforeCreateUpdate();
    return _cacheUipoi!.poi.isValid();
  }

  @override
  void setValueBeforeCreateUpdate() {
    _cacheUipoi!.poi.idkel = controllLokasi!.getIdKel();
  }
}
