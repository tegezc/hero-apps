import 'package:hero/http/coverage/httpsurvey.dart';
import 'package:hero/model/pjp.dart';
import 'package:hero/modulapp/coverage/merchandising/blocmerchandising.dart';
import 'package:hero/util/constapp/accountcontroller.dart';
import 'package:rxdart/subjects.dart';

class UISurvey {
  List<ItemSurveyVoucher>? lsurveyBroadband;
  List<ItemSurveyVoucher>? lsurveyFisik;
  int? telkomsel;
  int? isat;
  int? xl;
  int? tri;
  int? sf;
  int? axis;
  int? other;

  String? pathphotobelanja;

  late bool isbroadbandsubmitted;
  late bool isfisiksubmitted;
  late bool isbelanjasubmitted;

  Pjp? pjp;

  bool isbelanjabisasubmit() {
    if (telkomsel != null &&
        isat != null &&
        xl != null &&
        tri != null &&
        sf != null &&
        axis != null &&
        other != null &&
        pathphotobelanja != null) {
      return true;
    }
    return false;
  }
}

class BlocSurvey {
  UISurvey? _cacheuisurvey;
  Pjp? _cachePjp;

  final BehaviorSubject<UISurvey?> _uisurvey = BehaviorSubject();

  Stream<UISurvey?> get uisurvey => _uisurvey.stream;
  HttpSurvey _httpSurvey = new HttpSurvey();
  UISurvey? getUiFakultas() {
    return _cacheuisurvey;
  }

  void firstime(Pjp? pjp) {
    _cachePjp = pjp;
    _cacheuisurvey = UISurvey();
    _cacheuisurvey!.lsurveyBroadband = [];
    _cacheuisurvey!.lsurveyFisik = [];
    _cacheuisurvey!.isbroadbandsubmitted = false;
    _cacheuisurvey!.isfisiksubmitted = false;
    _cacheuisurvey!.isbelanjasubmitted = false;
    // _cacheuisurvey.telkomsel = 0;
    // _cacheuisurvey.isat = 0;
    // _cacheuisurvey.xl = 0;
    // _cacheuisurvey.tri = 0;
    // _cacheuisurvey.sf = 0;
    // _cacheuisurvey.axis = 0;
    // _cacheuisurvey.other = 0;
    _cacheuisurvey!.pjp = pjp;
    _cacheuisurvey!.lsurveyBroadband!
        .add(new ItemSurveyVoucher(EnumOperator.telkomsel));
    _cacheuisurvey!.lsurveyBroadband!
        .add(new ItemSurveyVoucher(EnumOperator.isat));
    _cacheuisurvey!.lsurveyBroadband!.add(new ItemSurveyVoucher(EnumOperator.xl));
    _cacheuisurvey!.lsurveyBroadband!
        .add(new ItemSurveyVoucher(EnumOperator.tri));
    _cacheuisurvey!.lsurveyBroadband!.add(new ItemSurveyVoucher(EnumOperator.sf));
    _cacheuisurvey!.lsurveyBroadband!
        .add(new ItemSurveyVoucher(EnumOperator.axis));
    _cacheuisurvey!.lsurveyBroadband!
        .add(new ItemSurveyVoucher(EnumOperator.other));

    _cacheuisurvey!.lsurveyFisik!
        .add(new ItemSurveyVoucher(EnumOperator.telkomsel));
    _cacheuisurvey!.lsurveyFisik!.add(new ItemSurveyVoucher(EnumOperator.isat));
    _cacheuisurvey!.lsurveyFisik!.add(new ItemSurveyVoucher(EnumOperator.xl));
    _cacheuisurvey!.lsurveyFisik!.add(new ItemSurveyVoucher(EnumOperator.tri));
    _cacheuisurvey!.lsurveyFisik!.add(new ItemSurveyVoucher(EnumOperator.sf));
    _cacheuisurvey!.lsurveyFisik!.add(new ItemSurveyVoucher(EnumOperator.axis));
    _cacheuisurvey!.lsurveyFisik!.add(new ItemSurveyVoucher(EnumOperator.other));
    _loadDrInternet().then((value) {
      _sink(_cacheuisurvey);
    });
  }

  Future<bool> _loadDrInternet() async {
    bool b = await _loadDataBelanja();
    b = await _loadDataVoucher(EnumSurvey.fisik);
    b = await _loadDataVoucher(EnumSurvey.broadband);
    print(b);
    return true;
  }

  Future<bool> submitVoucher(EnumSurvey es) async {
    // BELANJA
    // SALES_BROADBAND
    // VOUCHER_FISIK

    String idjenisshare = 'BELANJA';
    List<ItemSurveyVoucher>? lsurvey;
    if (es == EnumSurvey.broadband) {
      idjenisshare = 'SALES_BROADBAND';
      lsurvey = _cacheuisurvey!.lsurveyBroadband;
    } else if (es == EnumSurvey.fisik) {
      idjenisshare = 'VOUCHER_FISIK';
      lsurvey = _cacheuisurvey!.lsurveyFisik;
    }
    String? idhistorypjp = await AccountHore.getIdHistoryPjp();
    Map<String, dynamic> map = {
      "id_history_pjp": idhistorypjp,
      "id_jenis_share": idjenisshare,
      "telkomsel_ld": lsurvey![0].ld.toString(),
      "telkomsel_md": lsurvey[0].md.toString(),
      "telkomsel_hd": lsurvey[0].hd.toString(),
      "isat_ld": lsurvey[1].ld.toString(),
      "isat_md": lsurvey[1].md.toString(),
      "isat_hd": lsurvey[1].hd.toString(),
      "xl_ld": lsurvey[2].ld.toString(),
      "xl_md": lsurvey[2].md.toString(),
      "xl_hd": lsurvey[2].hd.toString(),
      "tri_ld": lsurvey[3].ld.toString(),
      "tri_md": lsurvey[3].md.toString(),
      "tri_hd": lsurvey[3].hd.toString(),
      "smartfren_ld": lsurvey[4].ld.toString(),
      "smartfren_md": lsurvey[4].md.toString(),
      "smartfren_hd": lsurvey[4].hd.toString(),
      "axis_ld": lsurvey[5].ld.toString(),
      "axis_md": lsurvey[5].md.toString(),
      "axis_hd": lsurvey[5].hd.toString(),
      "other_ld": lsurvey[6].ld.toString(),
      "other_md": lsurvey[6].md.toString(),
      "other_hd": lsurvey[6].hd.toString()
    };

    bool result = await _httpSurvey.createSurvey(map);
    if (result) {
      bool b = await this._loadDataVoucher(es);
      print(b);
    }
    return result;
  }

  void setpathphoto(String? path) {
    _cacheuisurvey!.pathphotobelanja = path;
    _sink(_cacheuisurvey);
  }

  Future<bool> submitBelanja() async {
    Map<String, dynamic> map = {
      "id_outlet": _cacheuisurvey!.pjp!.id,
      "id_jenis_share": "BELANJA",
      "telkomsel": _cacheuisurvey!.telkomsel,
      "isat": _cacheuisurvey!.isat,
      "xl": _cacheuisurvey!.xl,
      "tri": _cacheuisurvey!.tri,
      "smartfren": _cacheuisurvey!.sf,
      "axis": _cacheuisurvey!.axis,
      "other": _cacheuisurvey!.other,
      "path": _cacheuisurvey!.pathphotobelanja
    };

    bool result = await _httpSurvey.createSurveyBelanja(map);
    if (result) {
      bool b = await this._loadDataBelanja();
      print(b);
    }
    return result;
  }

  Future<bool> _loadDataBelanja() async {
    String? idtempat = _cachePjp!.id;
    DateTime dt = DateTime.now();
    HttpSurvey httpSurvey = new HttpSurvey();
    UISurvey? item =
        await httpSurvey.getDetailPromotion(EnumSurvey.belanja, idtempat, dt);
    if (item != null) {
      _cacheuisurvey!.telkomsel = item.telkomsel;
      _cacheuisurvey!.isat = item.isat;
      _cacheuisurvey!.xl = item.xl;
      _cacheuisurvey!.tri = item.tri;
      _cacheuisurvey!.axis = item.axis;
      _cacheuisurvey!.other = item.other;
      _cacheuisurvey!.sf = item.sf;
      _cacheuisurvey!.pathphotobelanja = item.pathphotobelanja;
      _cacheuisurvey!.isbelanjasubmitted = true;
    }
    return false;
  }

  Future<bool> _loadDataVoucher(EnumSurvey enumSurvey) async {
    String? idtempat = _cachePjp!.id;
    DateTime dt = DateTime.now();
    HttpSurvey httpSurvey = new HttpSurvey();
    if (enumSurvey == EnumSurvey.fisik) {
      UISurvey? item =
          await httpSurvey.getDetailPromotion(EnumSurvey.fisik, idtempat, dt);
      if (item != null) {
        _cacheuisurvey!.lsurveyFisik = item.lsurveyFisik;
        _cacheuisurvey!.isfisiksubmitted = true;
      }
    } else {
      UISurvey? item = await httpSurvey.getDetailPromotion(
          EnumSurvey.broadband, idtempat, dt);
      if (item != null) {
        _cacheuisurvey!.lsurveyBroadband = item.lsurveyBroadband;
        _cacheuisurvey!.isbroadbandsubmitted = true;
      }
    }

    return true;
  }

  void changedText(int index, String str, EnumSurvey enumSurvey) {
    List<ItemSurveyVoucher>? lsurvey;
    if (enumSurvey == EnumSurvey.fisik) {
      lsurvey = _cacheuisurvey!.lsurveyFisik;
    } else {
      lsurvey = _cacheuisurvey!.lsurveyBroadband;
    }

    int? value = int.tryParse(str);

    switch (index) {
      case 0:
        lsurvey![0].ld = value;
        break;
      case 1:
        lsurvey![0].md = value;
        break;
      case 2:
        lsurvey![0].hd = value;
        break;
      case 3:
        lsurvey![1].ld = value;
        break;
      case 4:
        lsurvey![1].md = value;
        break;
      case 5:
        lsurvey![1].hd = value;
        break;
      case 6:
        lsurvey![2].ld = value;
        break;
      case 7:
        lsurvey![2].md = value;
        break;
      case 8:
        lsurvey![2].hd = value;
        break;
      case 9:
        lsurvey![3].ld = value;
        break;
      case 10:
        lsurvey![3].md = value;
        break;
      case 11:
        lsurvey![3].hd = value;
        break;
      case 12:
        lsurvey![4].ld = value;
        break;
      case 13:
        lsurvey![4].md = value;
        break;
      case 14:
        lsurvey![4].hd = value;
        break;
      case 15:
        lsurvey![5].ld = value;
        break;
      case 16:
        lsurvey![5].md = value;
        break;
      case 17:
        lsurvey![5].hd = value;
        break;
      case 18:
        lsurvey![6].ld = value;
        break;
      case 19:
        lsurvey![6].md = value;
        break;
      case 20:
        lsurvey![6].hd = value;
        break;
    }

    if (enumSurvey == EnumSurvey.fisik) {
      _cacheuisurvey!.lsurveyFisik = lsurvey;
    } else {
      _cacheuisurvey!.lsurveyBroadband = lsurvey;
    }
  }

  void changeTextBelanja(String str, EnumOperator enumOperator) {
    int? value = int.tryParse(str);
    switch (enumOperator) {
      case EnumOperator.telkomsel:
        _cacheuisurvey!.telkomsel = value;
        break;
      case EnumOperator.tri:
        _cacheuisurvey!.tri = value;
        break;
      case EnumOperator.isat:
        _cacheuisurvey!.isat = value;
        break;
      case EnumOperator.xl:
        _cacheuisurvey!.xl = value;
        break;
      case EnumOperator.sf:
        _cacheuisurvey!.sf = value;
        break;
      case EnumOperator.axis:
        _cacheuisurvey!.axis = value;
        break;
      case EnumOperator.other:
        _cacheuisurvey!.other = value;
        break;
    }
  }

  void refresh() {
    if (!_isDisposed) {
      _uisurvey.sink.add(_cacheuisurvey);
    }
  }

  void _sink(UISurvey? item) {
    if (!_isDisposed) {
      _uisurvey.sink.add(item);
    }
  }

  bool _isDisposed = false;
  void dispose() {
    _uisurvey.close();
    _isDisposed = true;
  }
}

class ItemSurveyVoucher {
  EnumOperator eo;
  int? ld;
  int? md;
  int? hd;

  ItemSurveyVoucher(this.eo);

  String? getNama() {
    String? nama;
    switch (eo) {
      case EnumOperator.telkomsel:
        nama = 'Telkomsel';
        break;
      case EnumOperator.isat:
        nama = 'Isat';
        break;
      case EnumOperator.xl:
        nama = 'XL';
        break;
      case EnumOperator.tri:
        nama = '3';
        break;
      case EnumOperator.sf:
        nama = 'Smartfren';
        break;
      case EnumOperator.axis:
        nama = 'Axis';
        break;
      case EnumOperator.other:
        nama = 'Other';
        break;
    }
    return nama;
  }
}

enum EnumSurvey { belanja, broadband, fisik }
