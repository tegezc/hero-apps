// import 'package:geolocator/geolocator.dart';
import 'package:hero/http/coverage/httpdashboard.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/pjp.dart';
import 'package:hero/model/profile.dart';
import 'package:hero/util/constapp/accountcontroller.dart';
import 'package:hero/util/dateutil.dart';
import 'package:location/location.dart';
import 'package:rxdart/subjects.dart';

class UIHomeCvrg {
  EnumStateWidget? enumStateWidget;
  late Profile profile;
  EnumAccount? enumAccount;
  late List<Pjp> lpjp;
  int? jmlDone;
  String? strJumlah;

  DateTime? dt;
  String? strTanggal;
}

class BlocHomePageCoverage {
  final Location location = Location();
  UIHomeCvrg? _cacheuicvrg;

  final BehaviorSubject<UIHomeCvrg?> _uihpcvrg = BehaviorSubject();

  Stream<UIHomeCvrg?> get uihpcvrg => _uihpcvrg.stream;
  HttpDashboard _httpDashboard = new HttpDashboard();
  UIHomeCvrg? getUiFakultas() {
    return _cacheuicvrg;
  }

  void firstTime() {
    _setupFirstime().then((value) {
      if (value) {
        this._sink(_cacheuicvrg);
      }
    });
  }

  Future<bool> _setupFirstime() async {
    List<Pjp>? lpjp = await _httpDashboard.getPjpHariIni();
    print("masuk");
    _cacheuicvrg = UIHomeCvrg();
    _cacheuicvrg!.profile = await AccountHore.getProfile();
    _cacheuicvrg!.lpjp = this._filterpjp(lpjp);
    _cacheuicvrg!.enumAccount = await AccountHore.getAccount();
    bool permission = await _setupPermissionlocation();
    if (permission) {
      print('permission lokasi: $permission');
    }
    this._setJumlah(lpjp);
    this._setTgl();

    return true;
  }

  Future<bool> _setupPermissionlocation() async {
    final PermissionStatus permissionGrantedResult =
        await location.hasPermission();
    switch (permissionGrantedResult) {
      case PermissionStatus.granted:
        print('While in use , no permission for background');
        _cacheuicvrg!.enumStateWidget = EnumStateWidget.active;
        return true;
      case PermissionStatus.grantedLimited:
        // nothing (untuk ios)
        break;
      case PermissionStatus.denied:
        {
          print('DENIED');
          // LocationPermission reqLp = await Geolocator.requestPermission();
          // print(reqLp);
          bool isaccept = await requestIjinLokasi();

          if (isaccept) {
            _cacheuicvrg!.enumStateWidget = EnumStateWidget.active;
            return true;
          } else {
            _cacheuicvrg!.enumStateWidget = EnumStateWidget.loading;
            return false;
          }
        }

      case PermissionStatus.deniedForever:
        {
          print('DENIED');
          // LocationPermission reqLp = await Geolocator.requestPermission();
          // print(reqLp);
          bool isaccept = await requestIjinLokasi();

          if (isaccept) {
            _cacheuicvrg!.enumStateWidget = EnumStateWidget.active;
            return true;
          } else {
            _cacheuicvrg!.enumStateWidget = EnumStateWidget.loading;
            return false;
          }
        }
    }

    return false;
  }

  Future<bool> requestIjinLokasi() async {
    final PermissionStatus permissionRequestedResult =
        await location.requestPermission();
    switch (permissionRequestedResult) {
      case PermissionStatus.granted:
        _cacheuicvrg!.enumStateWidget = EnumStateWidget.active;
        this._sink(_cacheuicvrg);
        return true;
      case PermissionStatus.grantedLimited:
        // nothing (only ios)
        break;
      case PermissionStatus.denied:
        _cacheuicvrg!.enumStateWidget = EnumStateWidget.loading;
        break;
      case PermissionStatus.deniedForever:
        _cacheuicvrg!.enumStateWidget = EnumStateWidget.loading;
        break;
    }
    return false;
  }

  List<Pjp> _filterpjp(List<Pjp>? lpjp) {
    bool iscurrent = true;
    List<Pjp> ltmp = [];
    if (lpjp == null) {
      return ltmp;
    }
    lpjp.forEach((element) {
      if (element.isStatusDone()) {
        element.enumPjp = EnumPjp.done;
      } else {
        if (iscurrent) {
          if (element.isAlreadyClockIn()) {
            element.enumPjp = EnumPjp.progress;
          } else {
            element.enumPjp = EnumPjp.notclockinyet;
          }

          iscurrent = false;
        } else {
          element.enumPjp = EnumPjp.belum;
        }
      }
      ltmp.add(element);
    });
    return ltmp;
  }

  void _setJumlah(List<Pjp>? lpjp) {
    if (lpjp == null) {
      _cacheuicvrg!.jmlDone = 0;
      _cacheuicvrg!.strJumlah = '0/0';
    } else {
      int tmpdone = 0;
      lpjp.forEach((element) {
        if (element.enumPjp == EnumPjp.done) {
          tmpdone++;
        }
      });
      _cacheuicvrg!.jmlDone = tmpdone;
      _cacheuicvrg!.strJumlah = '$tmpdone/${lpjp.length}';
    }
  }

  void _setTgl() {
    _cacheuicvrg!.dt = DateTime.now();
    _cacheuicvrg!.strTanggal =
        DateUtility.dateToStringPanjang(_cacheuicvrg!.dt);
  }

  void _sink(UIHomeCvrg? item) {
    _uihpcvrg.sink.add(item);
  }

  void dispose() {
    _uihpcvrg.close();
  }
}
