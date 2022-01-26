import 'package:hero/http/httplokasi/http_outlet.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/lokasi/outlet.dart';
import 'package:hero/util/locationutil.dart';
import 'package:location/location.dart';
import 'package:rxdart/subjects.dart';

import 'abstractbloclokasi.dart';
import 'controllowner.dart';
import 'controllpic.dart';

class UIOutlet {
  late Outlet outlet;

  EnumStateWidget? enumStateWidget;
  EnumEditorState? enumEditorState;

  List<ItemComboJenisOutlet>? ljnsoutlet;
  ItemComboJenisOutlet? currentjnsOutlet;
}

class BlocOutlet extends AbsBlocLokasi {
  BlocOutlet() {
    controllOwner = ControllOwner();
    controllPic = ControllPic();
  }

  ControllOwner? controllOwner;
  ControllPic? controllPic;
  UIOutlet? _cacheUioutlet;

  final BehaviorSubject<UIOutlet?> _uioutlet = BehaviorSubject();

  Stream<UIOutlet?> get uioutlet => _uioutlet.stream;

  UIOutlet? getUiOutlet() {
    return _cacheUioutlet;
  }

  void firstTimeEdit(String? idoutlet) async {
    _cacheUioutlet = UIOutlet();
    _cacheUioutlet!.enumEditorState = EnumEditorState.edit;
    _cacheUioutlet!.enumStateWidget = EnumStateWidget.active;
    _firtimeEditSetup(idoutlet).then((value) {
      if (value) {
        controllPic!.firstTimeEdit(_cacheUioutlet!.outlet.pic);
        controllOwner!.firstTimeEdit(_cacheUioutlet!.outlet.owner);
        _sink(_cacheUioutlet);
      }
    });
  }

  Future<bool> _firtimeEditSetup(String? idoutlet) async {
    HttpOutlet httpController = HttpOutlet();
    List<dynamic>? response = await httpController.detailOutlet(idoutlet);
    _cacheUioutlet!.ljnsoutlet = await httpController.comboJenisOutlet();

    if (response != null) {
      if (response.isNotEmpty) {
        Map<String, dynamic> map = response[0];
        Outlet outlet = Outlet.fromJson(map);
        super.init(EnumEditorState.edit, outlet.idkelurahan);
        _cacheUioutlet!.outlet = outlet;
        if (_cacheUioutlet!.ljnsoutlet != null) {
          for (var element in _cacheUioutlet!.ljnsoutlet!) {
            if (outlet.getEnumJenisOUtlet() == element.enumJenisOutlet) {
              _cacheUioutlet!.currentjnsOutlet = element;
            }
          }
        }
        return true;
      }
    } else {
      return false;
    }
    return false;
  }

  void firstTimeBaru() {
    super.init(EnumEditorState.baru, null);
    _cacheUioutlet = UIOutlet();
    _cacheUioutlet!.enumEditorState = EnumEditorState.baru;
    _cacheUioutlet!.outlet = Outlet.kosong();

    controllPic!.firstTimePic();
    controllOwner!.firstTimeOwner();
    setupAsync().then((value) {
      if (value) {
        _sink(_cacheUioutlet);
      }
    });
  }

  Future<bool> setupAsync() async {
    LocationData position = await LocationUtil().getCurrentLocation();
    HttpOutlet httpController = HttpOutlet();
    _cacheUioutlet!.ljnsoutlet = await httpController.comboJenisOutlet();
    _cacheUioutlet!.outlet.long = position.longitude;
    _cacheUioutlet!.outlet.lat = position.latitude;
    return true;
  }

  Future<bool> saveOutlet() async {
    _cacheUioutlet!.enumStateWidget = EnumStateWidget.loading;
    _sink(_cacheUioutlet);

    HttpOutlet httpController = HttpOutlet();
    Map<String, dynamic>? response =
        await httpController.createOutlet(_cacheUioutlet!.outlet);
    _cacheUioutlet!.enumStateWidget = EnumStateWidget.done;
    _sink(_cacheUioutlet);
    if (response != null) {
      if (response['status'] == 201) {
        return true;
      }
      return false;
    }
    return false;
  }

  Future<bool> updateOutlet() async {
    _cacheUioutlet!.enumStateWidget = EnumStateWidget.loading;
    _sink(_cacheUioutlet);

    HttpOutlet httpController = HttpOutlet();
    Map<String, dynamic>? response =
        await httpController.updateOutlet(_cacheUioutlet!.outlet);
    _cacheUioutlet!.enumStateWidget = EnumStateWidget.done;
    _sink(_cacheUioutlet);
    if (response != null) {
      if (response['status'] == 200) {
        return true;
      }
      return false;
    }
    return false;
  }

  void updateLongLat() {
    LocationUtil().getCurrentLocation().then((value) {
      _cacheUioutlet!.outlet.long = value.longitude;
      _cacheUioutlet!.outlet.lat = value.latitude;
      _sink(_cacheUioutlet);
    });
  }

  void _sink(UIOutlet? item) {
    _uioutlet.sink.add(item);
  }

  void dispose() {
    _uioutlet.close();
  }

  void comboJnsOutletOnChange(ItemComboJenisOutlet? item) {
    _cacheUioutlet!.currentjnsOutlet = item;
    _sink(_cacheUioutlet);
  }

  void setNamaOutlet(String t) {
    _cacheUioutlet!.outlet.nama = t;
  }

  void setNors(String t) {
    _cacheUioutlet!.outlet.nors = t;
  }

  void setAlamat(String t) {
    _cacheUioutlet!.outlet.alamat = t;
  }

  void setLongitude(String t) {
    if (t.isNotEmpty) {
      _cacheUioutlet!.outlet.long = double.tryParse(t);
    }
  }

  void setLatitude(String t) {
    if (t.isNotEmpty) {
      _cacheUioutlet!.outlet.lat = double.tryParse(t);
    }
  }

  @override
  void operationCompleted() {
    _sink(_cacheUioutlet);
  }

  @override
  bool isValid() {
    setValueBeforeCreateUpdate();
    return _cacheUioutlet!.outlet.isValid();
  }

  @override
  void setValueBeforeCreateUpdate() {
    _cacheUioutlet!.outlet.pic = controllPic!.getPic();
    _cacheUioutlet!.outlet.owner = controllOwner!.getOwner();
    _cacheUioutlet!.outlet.idkelurahan = controllLokasi!.getIdKel();
    if (_cacheUioutlet!.currentjnsOutlet == null) {
      _cacheUioutlet!.outlet.idJnsOutlet = 0;
    } else {
      _cacheUioutlet!.outlet.idJnsOutlet = _cacheUioutlet!.outlet
          .getJenisOutletByEnum(
              _cacheUioutlet!.currentjnsOutlet!.enumJenisOutlet);
    }
  }

  // @override
  // void finishPickKab(List<Kecamatan> lkab, Kabupaten kab) {
  //   _sink(_cacheUioutlet);
  // }
  //
  // @override
  // void finishPickKec(List<Kelurahan> lkel, Kecamatan kec) {
  //   _sink(_cacheUioutlet);
  // }
  //
  // @override
  // void finishPickKel(Kelurahan kel) {
  //   _sink(_cacheUioutlet);
  // }
  //
  // @override
  // void finishPickProv(List<Kabupaten> lkab, Provinsi prov) {
  //   ph('finish pick prov');
  //   _sink(_cacheUioutlet);
  // }
  //
  // @override
  // void initlokasiComplete(List<Provinsi> lprov) {
  //   _sink(_cacheUioutlet);
  // }
}
