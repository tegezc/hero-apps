import 'package:hero/http/httplokasi/httpsekolah.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/itemui.dart';
import 'package:hero/model/lokasi/sekolah.dart';
import 'package:hero/util/locationutil.dart';
import 'package:location/location.dart';
import 'package:rxdart/subjects.dart';

import 'abstractbloclokasi.dart';
import 'controllowner.dart';
import 'controllpic.dart';

class UISekolah {
  late Sekolah sekolah;

  EnumStateWidget? enumStateWidget;
  EnumEditorState? enumEditorState;

  JenjangSekolah? currentJenjang;
}

class BlocSekolah extends AbsBlocLokasi {
  BlocSekolah() {
    controllOwner = ControllOwner();
    controllPic = ControllPic();
  }

  ControllOwner? controllOwner;
  ControllPic? controllPic;
  UISekolah? _cacheUisekolah;

  final BehaviorSubject<UISekolah?> _uisekolah = BehaviorSubject();

  Stream<UISekolah?> get uisekolah => _uisekolah.stream;

  UISekolah? getUiSekolah() {
    return _cacheUisekolah;
  }

  void firstTimeEdit(String? idsekolah) async {
    _cacheUisekolah = UISekolah();
    _cacheUisekolah!.enumEditorState = EnumEditorState.edit;
    _cacheUisekolah!.enumStateWidget = EnumStateWidget.active;
    _firtimeEditSetup(idsekolah).then((value) {
      if (value) {
        // ph('masuk');
        _cacheUisekolah!.currentJenjang = ItemUi.getJenjangSekolah()[
            _cacheUisekolah!.sekolah.jenjang!.getIntJenjang()];
        //  ph(_cacheUisekolah.sekolah.owner);
        controllPic!.firstTimeEdit(_cacheUisekolah!.sekolah.pic);
        controllOwner!.firstTimeEdit(_cacheUisekolah!.sekolah.owner);
        _sink(_cacheUisekolah);
      }
    });
  }

  Future<bool> _firtimeEditSetup(String? idsekolah) async {
    HttpSekolah httpController = HttpSekolah();
    List<dynamic>? response = await httpController.detailSekolah(idsekolah);
    if (response != null) {
      if (response.isNotEmpty) {
        Map<String, dynamic> map = response[0];
        Sekolah sekolah = Sekolah.fromJson(map);
        super.init(EnumEditorState.edit, sekolah.idkel);
        _cacheUisekolah!.sekolah = sekolah;
        return true;
      }
    } else {
      return false;
    }
    return false;
  }

  void firstTimeBaru() {
    super.init(EnumEditorState.baru, null);
    _cacheUisekolah = UISekolah();
    _cacheUisekolah!.enumEditorState = EnumEditorState.baru;
    _cacheUisekolah!.sekolah = Sekolah.kosong();

    controllPic!.firstTimePic();
    controllOwner!.firstTimeOwner();
    setupAsync().then((value) {
      //   ph(value);
      if (value) {
        _sink(_cacheUisekolah);
      }
    });
  }

  Future<bool> setupAsync() async {
    LocationData position = await LocationUtil.getCurrentLocation();
    _cacheUisekolah!.sekolah.long = position.longitude;
    _cacheUisekolah!.sekolah.lat = position.latitude;
    return true;
  }

  Future<bool> saveSekolah() async {
    _cacheUisekolah!.enumStateWidget = EnumStateWidget.loading;
    _sink(_cacheUisekolah);

    HttpSekolah httpController = HttpSekolah();
    Map<String, dynamic>? response =
        await httpController.createSekolah(_cacheUisekolah!.sekolah);
    _cacheUisekolah!.enumStateWidget = EnumStateWidget.done;
    _sink(_cacheUisekolah);
    if (response != null) {
      if (response['status'] == 201) {
        return true;
      }
      return false;
    }
    return false;
  }

  Future<bool> updateSekolah() async {
    // ph('update');
    _cacheUisekolah!.enumStateWidget = EnumStateWidget.loading;
    _sink(_cacheUisekolah);

    HttpSekolah httpController = HttpSekolah();
    Map<String, dynamic>? response =
        await httpController.updateSekolah(_cacheUisekolah!.sekolah);
    _cacheUisekolah!.enumStateWidget = EnumStateWidget.done;
    _sink(_cacheUisekolah);
    if (response != null) {
      if (response['status'] == 200) {
        return true;
      }
      return false;
    }
    return false;
  }

  void updateLongLat() {
    LocationUtil.getCurrentLocation().then((value) {
      _cacheUisekolah!.sekolah.long = value.longitude;
      _cacheUisekolah!.sekolah.lat = value.latitude;
      _sink(_cacheUisekolah);
    });
  }

  void _sink(UISekolah? item) {
    _uisekolah.sink.add(item);
  }

  void dispose() {
    _uisekolah.close();
  }

  void comboJenjang(JenjangSekolah? item) {
    _cacheUisekolah!.currentJenjang = item;
    _sink(_cacheUisekolah);
  }

  void setNamaSekolah(String t) {
    _cacheUisekolah!.sekolah.nama = t;
  }

  void setNPSN(String t) {
    _cacheUisekolah!.sekolah.noNpsn = t;
  }

  void setAlamat(String t) {
    _cacheUisekolah!.sekolah.alamat = t;
  }

  void setLongitude(String t) {
    if (t.isNotEmpty) {
      _cacheUisekolah!.sekolah.long = double.tryParse(t);
    }
  }

  void setLatitude(String t) {
    if (t.isNotEmpty) {
      _cacheUisekolah!.sekolah.lat = double.tryParse(t);
    }
  }

  void setJJmlGuru(String str) {
    _cacheUisekolah!.sekolah.jmlGuru =
        int.tryParse(str) == null ? 0 : int.tryParse(str);
  }

  void setJJmlSiswa(String str) {
    _cacheUisekolah!.sekolah.jmlMurid =
        int.tryParse(str) == null ? 0 : int.tryParse(str);
  }

  @override
  void operationCompleted() {
    _sink(_cacheUisekolah);
  }

  @override
  bool isValid() {
    setValueBeforeCreateUpdate();
    return _cacheUisekolah!.sekolah.isValid();
  }

  @override
  void setValueBeforeCreateUpdate() {
    _cacheUisekolah!.sekolah.pic = controllPic!.getPic();
    _cacheUisekolah!.sekolah.owner = controllOwner!.getOwner();
    _cacheUisekolah!.sekolah.idkel = controllLokasi!.getIdKel();

    _cacheUisekolah!.sekolah.jenjang = _cacheUisekolah!.currentJenjang;
  }
}
