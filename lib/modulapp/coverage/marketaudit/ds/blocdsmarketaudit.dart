import 'package:hero/http/coverage/marketaudit/httpmarketauditds.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/marketaudit/frekuensipaket.dart';
import 'package:hero/model/marketaudit/operator.dart';
import 'package:hero/util/constapp/accountcontroller.dart';
import 'package:rxdart/subjects.dart';

import 'package:hero/model/marketaudit/quisioner.dart';

enum EnumDSMA { nelpon, internet, games }
enum EnumSering { harian, mingguan, bulanan }

class BlocDsQuisioner {
  late ModelUiQuisioner _cacheModelQuisioner;
  BlocDsQuisioner() {
    _cacheModelQuisioner = ModelUiQuisioner();
  }

  final BehaviorSubject<ModelUiQuisioner?> _modelUiQuisioner =
      BehaviorSubject();

  Stream<ModelUiQuisioner?> get modelUiQuisioner => _modelUiQuisioner.stream;

  void firstTime() {
    _cacheModelQuisioner.enumStateWidget = EnumStateWidget.startup;
    _modelUiQuisioner.sink.add(_cacheModelQuisioner);
    _setupInitialData().then((_) {
      _modelUiQuisioner.sink.add(_cacheModelQuisioner);
    });
  }

  Future<void> _setupInitialData() async {
    String? idhistorypjp = await AccountHore.getIdHistoryPjp();
    if (idhistorypjp != null) {
      if (idhistorypjp.trim().isNotEmpty) {
        _cacheModelQuisioner.idhistorypjp = idhistorypjp;
        await setListOperator();
        await setListFrekuensi();
        _cacheModelQuisioner.enumStateWidget = EnumStateWidget.done;
        //_modelUiQuisioner.sink.add(_cacheModelQuisioner);
      } else {
        _cacheModelQuisioner.enumStateWidget = EnumStateWidget.failed;
      }
    } else {
      _cacheModelQuisioner.enumStateWidget = EnumStateWidget.failed;
    }
  }

  Future<void> setListOperator() async {
    HttpMarketAuditDs httpMarketAuditDs = HttpMarketAuditDs();
    List<Operator> listOperator = await httpMarketAuditDs.getListOperator();
    _cacheModelQuisioner.setListOperator(listOperator);
  }

  Future<void> setListFrekuensi() async {
    HttpMarketAuditDs httpMarketAuditDs = HttpMarketAuditDs();
    List<FrekuensiPaket> listFrekuensi =
        await httpMarketAuditDs.getListFrekuensi();
    _cacheModelQuisioner.setListFrekuensi(listFrekuensi);
  }

  Future<bool> submit() async {
    HttpMarketAuditDs httpMarketAuditDs = HttpMarketAuditDs();
    bool issuccess = await httpMarketAuditDs
        .createQuisioner(_cacheModelQuisioner.quisioner!);
    return issuccess;
  }

  void changeComboOperatorNelpon(Operator operator) {
    _cacheModelQuisioner.setOperatorNelpon(operator);
  }

  void changeComboOperatorInternet(Operator operator) {
    _cacheModelQuisioner.setOperatorInternet(operator);
  }

  void changeComboOperatorDigital(Operator operator) {
    _cacheModelQuisioner.setOperatorDigital(operator);
  }

  void changeComboFrekuensi(FrekuensiPaket frekuensiPaket) {
    _cacheModelQuisioner.setFrekuensi(frekuensiPaket);
  }
}

class ModelUiQuisioner {
  late EnumStateWidget enumStateWidget;
  Quisioner? quisioner;
  String? idhistorypjp;
  late List<Operator> _listOperator;
  late List<FrekuensiPaket> _listFrekuensi;
  Operator? _currentOperatorNelpon;
  Operator? _currentOperatorInternet;
  Operator? _currentOperatorDigital;

  FrekuensiPaket? _curretnFrekuensi;

  ModelUiQuisioner() {
    _listOperator = List.empty(growable: true);
    _listFrekuensi = List.empty(growable: true);
  }

  void setQuesioner(
      {required String nama,
      required String msisdnnelpon,
      required String msisdninternet,
      required String msisdndigital,
      required String kuotaperbulan,
      required String pulsaperbulan}) {
    quisioner = Quisioner(
        idhistorypjp: idhistorypjp,
        namaPelanggan: nama,
        opTelp: _currentOperatorNelpon!.idserver,
        opInternet: _currentOperatorInternet!.idserver,
        opDigital: _currentOperatorDigital!.idserver,
        msisdnTelp: msisdnnelpon,
        msisdnInternet: msisdninternet,
        msisdnDigital: msisdndigital,
        frekBeliPaket: _curretnFrekuensi!.idserver,
        kuotaPerBulan: kuotaperbulan,
        pulsaPerbulan: pulsaperbulan);
    quisioner!.idhistorypjp = idhistorypjp;
  }

  void setListOperator(List<Operator> listO) {
    _listOperator = List.unmodifiable(listO);
  }

  void setListFrekuensi(List<FrekuensiPaket> listFrekuensi) {
    _listFrekuensi = List.unmodifiable(listFrekuensi);
  }

  Operator? getCurrentOperatorNelpon() {
    return _currentOperatorNelpon;
  }

  Operator? getCurrentOperatorInternet() {
    return _currentOperatorInternet;
  }

  Operator? getCurrentOperatorDigital() {
    return _currentOperatorDigital;
  }

  void setOperatorNelpon(Operator operator) {
    _currentOperatorNelpon = operator;
  }

  void setOperatorInternet(Operator operator) {
    _currentOperatorInternet = operator;
  }

  void setOperatorDigital(Operator operator) {
    _currentOperatorDigital = operator;
  }

  FrekuensiPaket? getCurrentFrekuensi() {
    return _curretnFrekuensi;
  }

  void setFrekuensi(FrekuensiPaket frekuensiPaket) {
    _curretnFrekuensi = frekuensiPaket;
  }

  List<Operator> getListOperator() {
    return List.unmodifiable(_listOperator);
  }

  List<FrekuensiPaket> getListFrekuensi() {
    return List.unmodifiable(_listFrekuensi);
  }

  bool isQuisionerValidToSubmit() {
    if (quisioner != null) {
      if (quisioner!.idhistorypjp == null ||
          quisioner!.namaPelanggan == null ||
          quisioner!.opTelp == null ||
          quisioner!.msisdnTelp == null ||
          quisioner!.opInternet == null ||
          quisioner!.msisdnInternet == null ||
          quisioner!.opDigital == null ||
          quisioner!.msisdnDigital == null ||
          quisioner!.pulsaPerbulan == null ||
          quisioner!.kuotaPerBulan == null) {
        return false;
      } else {
        if (quisioner!.idhistorypjp!.isEmpty ||
            quisioner!.namaPelanggan!.isEmpty ||
            quisioner!.opTelp!.isEmpty ||
            quisioner!.msisdnTelp!.isEmpty ||
            quisioner!.opInternet!.isEmpty ||
            quisioner!.msisdnInternet!.isEmpty ||
            quisioner!.opDigital!.isEmpty ||
            quisioner!.msisdnDigital!.isEmpty ||
            quisioner!.pulsaPerbulan!.isEmpty ||
            quisioner!.kuotaPerBulan!.isEmpty) {
          return false;
        }
        return true;
      }
    }
    return false;
  }
}
