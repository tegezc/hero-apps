import 'package:hero/http/httplokasi/httpfakultas.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/lokasi/Fakultas.dart';
import 'package:hero/model/lokasi/universitas.dart';
import 'package:hero/util/locationutil.dart';
import 'package:location/location.dart';
import 'package:rxdart/subjects.dart';

import 'abstractbloclokasi.dart';
import 'controllowner.dart';
import 'controllpic.dart';

class UIFakultas {
  late Fakultas fakultas;
  List<Universitas>? luniv;

  EnumStateWidget? enumStateWidget;
  EnumEditorState? enumEditorState;
  Universitas? currentUniversitas;
}

class BlocFakultas extends AbsBlocLokasi {
  BlocFakultas() {
    controllOwner = ControllOwner();
    controllPic = ControllPic();
  }

  ControllOwner? controllOwner;
  ControllPic? controllPic;
  UIFakultas? _cacheUiFakultas;
  HttpFakultas _httpController = new HttpFakultas();

  final BehaviorSubject<UIFakultas?> _uifakultas = BehaviorSubject();

  Stream<UIFakultas?> get uifakultas => _uifakultas.stream;

  UIFakultas? getUiFakultas() {
    return _cacheUiFakultas;
  }

  void firstTimeEdit(String? idfak) async {
    _cacheUiFakultas = new UIFakultas();
    _cacheUiFakultas!.enumEditorState = EnumEditorState.edit;
    _cacheUiFakultas!.enumStateWidget = EnumStateWidget.active;
    _firtimeEditSetup(idfak).then((value) {
      if (value) {
        controllPic!.firstTimeEdit(_cacheUiFakultas!.fakultas.pic);
        controllOwner!.firstTimeEdit(_cacheUiFakultas!.fakultas.dekan);
        this._sink(_cacheUiFakultas);
      }
    });
  }

  Future<bool> _firtimeEditSetup(String? idsekolah) async {
    List<dynamic>? response = await _httpController.detailFakultas(idsekolah);
    _cacheUiFakultas!.luniv = await _httpController.getComboUniv();
    if (response != null) {
      if (response.length > 0) {
        Map<String, dynamic> map = response[0];
        Fakultas fakultas = Fakultas.fromJson(map);
        super.init(EnumEditorState.edit, fakultas.idkel);
        _cacheUiFakultas!.fakultas = fakultas;

        _cacheUiFakultas!.currentUniversitas = _cacheUiFakultas!.luniv!
            .firstWhere((element) => element.iduniv == fakultas.iduniv);
        return true;
      }
    } else {
      return false;
    }
    return false;
  }

  void firstTimeBaru() {
    super.init(EnumEditorState.baru, null);
    _cacheUiFakultas = new UIFakultas();
    _cacheUiFakultas!.enumEditorState = EnumEditorState.baru;
    _cacheUiFakultas!.fakultas = Fakultas.kosong();

    controllPic!.firstTimePic();
    controllOwner!.firstTimeOwner();
    setupAsync().then((value) {
      print(value);
      if (value) {
        this._sink(_cacheUiFakultas);
      }
    });
  }

  Future<bool> setupAsync() async {
    _cacheUiFakultas!.luniv = await _httpController.getComboUniv();
    // Position position = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);

    LocationData position = await LocationUtil.getCurrentLocation();

    _cacheUiFakultas!.fakultas.long = position.longitude;
    _cacheUiFakultas!.fakultas.lat = position.latitude;
    return true;
  }

  Future<bool> saveFakultas() async {
    _cacheUiFakultas!.enumStateWidget = EnumStateWidget.loading;
    this._sink(_cacheUiFakultas);
    Map<String, dynamic>? response =
        await _httpController.createFakultas(_cacheUiFakultas!.fakultas);
    _cacheUiFakultas!.enumStateWidget = EnumStateWidget.done;
    this._sink(_cacheUiFakultas);
    if (response != null) {
      if (response['status'] == 201) {
        return true;
      }
      return false;
    }
    return false;
  }

  Future<bool> updateFakultas() async {
    _cacheUiFakultas!.enumStateWidget = EnumStateWidget.loading;
    this._sink(_cacheUiFakultas);

    Map<String, dynamic>? response =
        await _httpController.updateFakultas(_cacheUiFakultas!.fakultas);
    _cacheUiFakultas!.enumStateWidget = EnumStateWidget.done;
    this._sink(_cacheUiFakultas);
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
      _cacheUiFakultas!.fakultas.long = value.longitude;
      _cacheUiFakultas!.fakultas.lat = value.latitude;
      this._sink(_cacheUiFakultas);
    });
  }

  void _sink(UIFakultas? item) {
    _uifakultas.sink.add(item);
  }

  void dispose() {
    _uifakultas.close();
  }

  void comboUniv(Universitas? item) {
    _cacheUiFakultas!.currentUniversitas = item;
    this._sink(_cacheUiFakultas);
  }

  void setNamaFak(String t) {
    _cacheUiFakultas!.fakultas.nama = t;
  }

  void setAlamat(String t) {
    _cacheUiFakultas!.fakultas.alamat = t;
  }

  void setLongitude(String t) {
    if (t.length > 0) {
      _cacheUiFakultas!.fakultas.long = double.tryParse(t);
    }
  }

  void setLatitude(String t) {
    if (t.length > 0) {
      _cacheUiFakultas!.fakultas.lat = double.tryParse(t);
    }
  }

  void setJmlDosen(String str) {
    _cacheUiFakultas!.fakultas.jmlDosen =
        int.tryParse(str) == null ? 0 : int.tryParse(str);
  }

  void setJmlMahasiswa(String str) {
    _cacheUiFakultas!.fakultas.jmlMahasiswa =
        int.tryParse(str) == null ? 0 : int.tryParse(str);
  }

  @override
  void operationCompleted() {
    this._sink(_cacheUiFakultas);
  }

  @override
  bool isValid() {
    this.setValueBeforeCreateUpdate();
    return _cacheUiFakultas!.fakultas.isValid();
  }

  @override
  void setValueBeforeCreateUpdate() {
    _cacheUiFakultas!.fakultas.pic = controllPic!.getPic();
    _cacheUiFakultas!.fakultas.dekan = controllOwner!.getOwner();
    _cacheUiFakultas!.fakultas.idkel = controllLokasi!.getIdKel();

    _cacheUiFakultas!.fakultas.iduniv =
        _cacheUiFakultas!.currentUniversitas == null
            ? null
            : _cacheUiFakultas!.currentUniversitas!.iduniv;
  }
}
