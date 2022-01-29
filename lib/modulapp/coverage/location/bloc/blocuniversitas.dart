import 'package:hero/http/httplokasi/httpkampus.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/lokasi/universitas.dart';
import 'package:hero/core/domain/entities/tgzlocation.dart';
import 'package:hero/core/data/datasources/location/tgz_location.dart';
import 'package:location/location.dart';
import 'package:rxdart/subjects.dart';

import 'abstractbloclokasi.dart';
import 'controllowner.dart';
import 'controllpic.dart';

class UIUniv {
  late Universitas univ;

  EnumStateWidget? enumStateWidget;
  EnumEditorState? enumEditorState;
}

class BlocUniversitas extends AbsBlocLokasi {
  final HttpKampus _httpController = HttpKampus();
  BlocUniversitas() {
    controllOwner = ControllOwner();
    controllPic = ControllPic();
  }

  ControllOwner? controllOwner;
  ControllPic? controllPic;
  UIUniv? _cacheUiUniv;

  final BehaviorSubject<UIUniv?> _uiUniv = BehaviorSubject();

  Stream<UIUniv?> get uiUniv => _uiUniv.stream;

  UIUniv? getUiUniv() {
    return _cacheUiUniv;
  }

  void firstTimeEdit(String? iduniv) async {
    _cacheUiUniv = UIUniv();
    _cacheUiUniv!.enumEditorState = EnumEditorState.edit;
    _cacheUiUniv!.enumStateWidget = EnumStateWidget.active;
    _firstTimeEditSetup(iduniv).then((value) {
      if (value) {
        controllPic!.firstTimeEdit(_cacheUiUniv!.univ.pic);
        controllOwner!.firstTimeEdit(_cacheUiUniv!.univ.owner);
        _sink(_cacheUiUniv);
      }
    });
  }

  Future<bool> _firstTimeEditSetup(String? iduniv) async {
    List<dynamic>? response = await _httpController.detailUniv(iduniv);
    if (response != null) {
      if (response.isNotEmpty) {
        Map<String, dynamic> map = response[0];
        Universitas univ = Universitas.fromJson(map);
        super.init(EnumEditorState.edit, univ.idkel);
        _cacheUiUniv!.univ = univ;
        return true;
      }
    } else {
      return false;
    }
    return false;
  }

  void firstTimeBaru() {
    super.init(EnumEditorState.baru, null);
    _cacheUiUniv = UIUniv();
    _cacheUiUniv!.enumEditorState = EnumEditorState.baru;
    _cacheUiUniv!.univ = Universitas.kosong();

    controllPic!.firstTimePic();
    controllOwner!.firstTimeOwner();
    setupAsync().then((value) {
      if (value) {
        _sink(_cacheUiUniv);
      }
    });
  }

  Future<bool> setupAsync() async {
    TgzLocationData? position =
        await TgzLocationDataSourceImpl().getCurrentLocationOrNull();
    if (position != null) {
      _cacheUiUniv!.univ.long = position.longitude;
      _cacheUiUniv!.univ.lat = position.latitude;
      return true;
    }
    return false;
  }

  Future<bool> saveUniv() async {
    _cacheUiUniv!.enumStateWidget = EnumStateWidget.loading;
    _sink(_cacheUiUniv);

    Map<String, dynamic>? response =
        await _httpController.createKampus(_cacheUiUniv!.univ);
    _cacheUiUniv!.enumStateWidget = EnumStateWidget.done;
    _sink(_cacheUiUniv);

    if (response != null) {
      if (response['status'] == 201) {
        return true;
      }
      return false;
    }
    return false;
  }

  Future<bool> updateUniv() async {
    _cacheUiUniv!.enumStateWidget = EnumStateWidget.loading;
    _sink(_cacheUiUniv);

    Map<String, dynamic>? response =
        await _httpController.updateKampus(_cacheUiUniv!.univ);
    _cacheUiUniv!.enumStateWidget = EnumStateWidget.done;
    _sink(_cacheUiUniv);
    if (response != null) {
      if (response['status'] == 200) {
        return true;
      }
      return false;
    }
    return false;
  }

  void updateLongLat() {
    TgzLocationDataSourceImpl().getCurrentLocationOrNull().then((value) {
      if (value != null) {
        _cacheUiUniv!.univ.long = value.longitude;
        _cacheUiUniv!.univ.lat = value.latitude;
        _sink(_cacheUiUniv);
      }
    });
  }

  void _sink(UIUniv? item) {
    _uiUniv.sink.add(item);
  }

  void dispose() {
    _uiUniv.close();
  }

  void setNamaUniv(String t) {
    _cacheUiUniv!.univ.nama = t;
  }

  void setNpsn(String t) {
    _cacheUiUniv!.univ.npsn = t;
  }

  void setAlamat(String t) {
    _cacheUiUniv!.univ.alamat = t;
  }

  void setLongitude(String t) {
    if (t.isNotEmpty) {
      _cacheUiUniv!.univ.long = double.tryParse(t);
    }
  }

  void setLatitude(String t) {
    if (t.isNotEmpty) {
      _cacheUiUniv!.univ.lat = double.tryParse(t);
    }
  }

  @override
  void operationCompleted() {
    _sink(_cacheUiUniv);
  }

  @override
  bool isValid() {
    setValueBeforeCreateUpdate();
    return _cacheUiUniv!.univ.isValid();
  }

  @override
  void setValueBeforeCreateUpdate() {
    _cacheUiUniv!.univ.pic = controllPic!.getPic();
    _cacheUiUniv!.univ.owner = controllOwner!.getOwner();
    _cacheUiUniv!.univ.idkel = controllLokasi!.getIdKel();
  }
}
