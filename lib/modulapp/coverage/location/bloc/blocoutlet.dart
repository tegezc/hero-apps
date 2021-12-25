import 'package:hero/http/httplokasi/httpOutlet.dart';
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
    _cacheUioutlet = new UIOutlet();
    _cacheUioutlet!.enumEditorState = EnumEditorState.edit;
    _cacheUioutlet!.enumStateWidget = EnumStateWidget.active;
    _firtimeEditSetup(idoutlet).then((value) {
      if (value) {
        print('masuk');

        print(_cacheUioutlet!.outlet.owner);
        controllPic!.firstTimeEdit(_cacheUioutlet!.outlet.pic);
        controllOwner!.firstTimeEdit(_cacheUioutlet!.outlet.owner);
        this._sink(_cacheUioutlet);
      }
    });
  }

  Future<bool> _firtimeEditSetup(String? idoutlet) async {
    HttpOutlet httpController = new HttpOutlet();
    List<dynamic>? response = await httpController.detailOutlet(idoutlet);
    _cacheUioutlet!.ljnsoutlet = await httpController.comboJenisOutlet();

    if (response != null) {
      if (response.length > 0) {
        Map<String, dynamic> map = response[0];
        Outlet outlet = Outlet.fromJson(map);
        super.init(EnumEditorState.edit, outlet.idkelurahan);
        _cacheUioutlet!.outlet = outlet;
        if (_cacheUioutlet!.ljnsoutlet != null) {
          _cacheUioutlet!.ljnsoutlet!.forEach((element) {
            if (outlet.getEnumJenisOUtlet() == element.enumJenisOutlet) {
              _cacheUioutlet!.currentjnsOutlet = element;
            }
          });
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
    _cacheUioutlet = new UIOutlet();
    _cacheUioutlet!.enumEditorState = EnumEditorState.baru;
    _cacheUioutlet!.outlet = Outlet.kosong();

    controllPic!.firstTimePic();
    controllOwner!.firstTimeOwner();
    setupAsync().then((value) {
      print(value);
      if (value) {
        this._sink(_cacheUioutlet);
      }
    });
  }

  Future<bool> setupAsync() async {
    LocationData position = await LocationUtil.getCurrentLocation();
    HttpOutlet httpController = new HttpOutlet();
    _cacheUioutlet!.ljnsoutlet = await httpController.comboJenisOutlet();
    _cacheUioutlet!.outlet.long = position.longitude;
    _cacheUioutlet!.outlet.lat = position.latitude;
    return true;
  }

  Future<bool> saveOutlet() async {
    _cacheUioutlet!.enumStateWidget = EnumStateWidget.loading;
    this._sink(_cacheUioutlet);

    HttpOutlet httpController = new HttpOutlet();
    Map<String, dynamic>? response =
        await httpController.createOutlet(_cacheUioutlet!.outlet);
    _cacheUioutlet!.enumStateWidget = EnumStateWidget.done;
    this._sink(_cacheUioutlet);
    if (response != null) {
      if (response['status'] == 201) {
        return true;
      }
      return false;
    }
    return false;
  }

  Future<bool> updateOutlet() async {
    print('update');
    _cacheUioutlet!.enumStateWidget = EnumStateWidget.loading;
    this._sink(_cacheUioutlet);

    HttpOutlet httpController = new HttpOutlet();
    Map<String, dynamic>? response =
        await httpController.updateOutlet(_cacheUioutlet!.outlet);
    _cacheUioutlet!.enumStateWidget = EnumStateWidget.done;
    this._sink(_cacheUioutlet);
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
      _cacheUioutlet!.outlet.long = value.longitude;
      _cacheUioutlet!.outlet.lat = value.latitude;
      this._sink(_cacheUioutlet);
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
    this._sink(_cacheUioutlet);
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
    if (t.length > 0) {
      _cacheUioutlet!.outlet.long = double.tryParse(t);
    }
  }

  void setLatitude(String t) {
    if (t.length > 0) {
      _cacheUioutlet!.outlet.lat = double.tryParse(t);
    }
  }

  @override
  void operationCompleted() {
    this._sink(_cacheUioutlet);
  }

  @override
  bool isValid() {
    this.setValueBeforeCreateUpdate();
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
  //   this._sink(_cacheUioutlet);
  // }
  //
  // @override
  // void finishPickKec(List<Kelurahan> lkel, Kecamatan kec) {
  //   this._sink(_cacheUioutlet);
  // }
  //
  // @override
  // void finishPickKel(Kelurahan kel) {
  //   this._sink(_cacheUioutlet);
  // }
  //
  // @override
  // void finishPickProv(List<Kabupaten> lkab, Provinsi prov) {
  //   print('finish pick prov');
  //   this._sink(_cacheUioutlet);
  // }
  //
  // @override
  // void initlokasiComplete(List<Provinsi> lprov) {
  //   this._sink(_cacheUioutlet);
  // }
}
