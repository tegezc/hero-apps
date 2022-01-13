import 'package:hero/http/coverage/httpdashboard.dart';
import 'package:hero/http/coverage/httpmerch.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/merchandising/merchandising.dart';
import 'package:hero/model/pjp.dart';
import 'package:hero/modulapp/camera/preferencephoto.dart';
import 'package:hero/util/constapp/accountcontroller.dart';
import 'package:rxdart/subjects.dart';

class UIMerchan {
  // BACKDROP
  // ETALASE
  // PAPAN_NAMA
  // POSTER
  // SPANDUK

  Merchandising? perdana;
  Merchandising? voucherFisik;
  Merchandising? backdrop;
  Merchandising? papanNama;
  Merchandising? poster;
  Merchandising? spanduk;

  bool isLoading = false;

  // bool isValidSelesai() {
  //   return etalase.isServerExist &&
  //       backdrop.isServerExist &&
  //       papanNama.isServerExist &&
  //       poster.isServerExist &&
  //       spanduk.isServerExist;
  // }
}

class BlocMerchandising {
  UIMerchan? _cacheUiMerc;
  late Pjp _cachePjp;

  final BehaviorSubject<UIMerchan?> _uiMerch = BehaviorSubject();

  Stream<UIMerchan?> get uiMerch => _uiMerch.stream;

  void firstTime(Pjp pjp) {
    _cachePjp = pjp;
    _setupFirstime(pjp).then((value) {
      _sink(_cacheUiMerc);
    });
  }

  Future<bool> _setupFirstime(Pjp pjp) async {
    _cacheUiMerc = UIMerchan();
    HttpMerchandising httpm = HttpMerchandising();
    Map<String, Merchandising>? map = await httpm.getDetailMerch(
        pjp.id, DateTime.now(), pjp.getJenisLokasi());
    print('idtempat: ${pjp.id}');
    if (map != null) {
      _cacheUiMerc!.perdana = map[Merchandising.tagPerdana];
      _cacheUiMerc!.voucherFisik = map[Merchandising.tagVoucherFisik];
      _cacheUiMerc!.spanduk = map[Merchandising.tagSpanduk];
      _cacheUiMerc!.poster = map[Merchandising.tagPoster];
      _cacheUiMerc!.papanNama = map[Merchandising.tagPapan];
      _cacheUiMerc!.backdrop = map[Merchandising.tagBackdrop];
    }

    if (_cacheUiMerc!.perdana == null) {
      _cacheUiMerc!.perdana = Merchandising.kosong(pjp, 'PERDANA');
    }
    if (_cacheUiMerc!.voucherFisik == null) {
      _cacheUiMerc!.voucherFisik = Merchandising.kosong(pjp, 'VOUCHER FISIK');
    }
    if (_cacheUiMerc!.backdrop == null) {
      _cacheUiMerc!.backdrop = Merchandising.kosong(pjp, 'BACKDROP');
    }
    if (_cacheUiMerc!.papanNama == null) {
      _cacheUiMerc!.papanNama = Merchandising.kosong(pjp, 'PAPAN_NAMA');
    }
    if (_cacheUiMerc!.poster == null) {
      _cacheUiMerc!.poster = Merchandising.kosong(pjp, 'POSTER');
    }
    if (_cacheUiMerc!.spanduk == null) {
      _cacheUiMerc!.spanduk = Merchandising.kosong(pjp, 'SPANDUK');
    }

    return true;
  }

  Future<FinishMenu> selesai(Pjp pjp) async {
    // _sinkLoading();
    EnumAccount enumAccount = await AccountHore.getAccount();
    HttpMerchandising httpm = HttpMerchandising();
    Map<String, Merchandising>? map = await httpm.getDetailMerch(
        pjp.id, DateTime.now(), pjp.getJenisLokasi());
    FinishMenu vcheckout = FinishMenu(false, null);
    if (map != null) {
      _cacheUiMerc!.perdana = map[Merchandising.tagPerdana];
      _cacheUiMerc!.voucherFisik = map[Merchandising.tagVoucherFisik];
      _cacheUiMerc!.spanduk = map[Merchandising.tagSpanduk];
      _cacheUiMerc!.poster = map[Merchandising.tagPoster];
      _cacheUiMerc!.papanNama = map[Merchandising.tagPapan];
      _cacheUiMerc!.backdrop = map[Merchandising.tagBackdrop];

      // print(_cacheUiMerc!.etalase);
      // print(_cacheUiMerc!.spanduk);
      // print(_cacheUiMerc!.poster);
      // print(_cacheUiMerc!.papanNama);
      // print(_cacheUiMerc!.backdrop);

      // karena wajib diisi semua maka tidak ada yg boleh null
      if (enumAccount == EnumAccount.sf) {
        if (_cacheUiMerc!.perdana == null ||
            _cacheUiMerc!.voucherFisik == null ||
            _cacheUiMerc!.spanduk == null) {
        } else {
          HttpDashboard httpDashboard = HttpDashboard();
          vcheckout = await httpDashboard.finishMenu(EnumTab.merchandising);
          return vcheckout;
        }
      } else {
        if (_cacheUiMerc!.poster == null || _cacheUiMerc!.spanduk == null) {
        } else {
          HttpDashboard httpDashboard = HttpDashboard();
          vcheckout = await httpDashboard.finishMenu(EnumTab.merchandising);
          return vcheckout;
        }
      }
    }
    return vcheckout;
  }

  Future<bool> submit(EnumMerchandising enumMerchandising) async {
    //  _sinkLoading();
    Merchandising? merchandising;
    switch (enumMerchandising) {
      case EnumMerchandising.spanduk:
        merchandising = _cacheUiMerc!.spanduk;
        break;
      case EnumMerchandising.poster:
        merchandising = _cacheUiMerc!.poster;
        break;
      case EnumMerchandising.papan:
        merchandising = _cacheUiMerc!.papanNama;
        break;
      case EnumMerchandising.backdrop:
        merchandising = _cacheUiMerc!.backdrop;
        break;
      case EnumMerchandising.perdana:
        merchandising = _cacheUiMerc!.perdana;
        break;
      case EnumMerchandising.voucherfisik:
        merchandising = _cacheUiMerc!.voucherFisik;
        break;
    }
    HttpMerchandising httpMerchandising = HttpMerchandising();
    bool result = await httpMerchandising.createMerchadising(merchandising!);
    if (result) {
      HttpMerchandising httpm = HttpMerchandising();
      Map<String, Merchandising>? map = await httpm.getDetailMerch(
          _cachePjp.id, DateTime.now(), _cachePjp.getJenisLokasi());
      print('idtempat: ${_cachePjp.id}');
      if (map != null) {
        if (map[Merchandising.tagPerdana] != null) {
          _cacheUiMerc!.perdana = map[Merchandising.tagPerdana];
        }
        if (map[Merchandising.tagVoucherFisik] != null) {
          _cacheUiMerc!.voucherFisik = map[Merchandising.tagVoucherFisik];
        }

        if (map[Merchandising.tagSpanduk] != null) {
          _cacheUiMerc!.spanduk = map[Merchandising.tagSpanduk];
        }

        if (map[Merchandising.tagPoster] != null) {
          _cacheUiMerc!.poster = map[Merchandising.tagPoster];
        }

        if (map[Merchandising.tagPapan] != null) {
          _cacheUiMerc!.papanNama = map[Merchandising.tagPapan];
        }

        if (map[Merchandising.tagBackdrop] != null) {
          _cacheUiMerc!.backdrop = map[Merchandising.tagBackdrop];
        }
      }
    }
    return result;
  }

  void changeText(
    EnumMerchandising enumMerchandising,
    String text,
    EnumOperator enumOperator,
  ) {
    switch (enumMerchandising) {
      case EnumMerchandising.spanduk:
        _cacheUiMerc!.spanduk =
            _textChanged(_cacheUiMerc!.spanduk, enumOperator, text);
        break;
      case EnumMerchandising.poster:
        _cacheUiMerc!.poster =
            _textChanged(_cacheUiMerc!.poster, enumOperator, text);
        break;
      case EnumMerchandising.papan:
        _cacheUiMerc!.papanNama =
            _textChanged(_cacheUiMerc!.papanNama, enumOperator, text);
        break;
      case EnumMerchandising.backdrop:
        _cacheUiMerc!.backdrop =
            _textChanged(_cacheUiMerc!.backdrop, enumOperator, text);
        break;
      case EnumMerchandising.perdana:
        _cacheUiMerc!.backdrop =
            _textChanged(_cacheUiMerc!.perdana, enumOperator, text);
        break;
      case EnumMerchandising.voucherfisik:
        _cacheUiMerc!.backdrop =
            _textChanged(_cacheUiMerc!.voucherFisik, enumOperator, text);
        break;
    }
    //  _sink(_cacheUiMerc);
  }

  void setPhotoPath(EnumMerchandising merchandising, String? path) {
    switch (merchandising) {
      case EnumMerchandising.spanduk:
        switch (_cacheUiMerc!.spanduk!.getPhotoKe()) {
          case EnumNumber.satu:
            _cacheUiMerc!.spanduk!.pathPhoto1 = path;
            break;
          case EnumNumber.dua:
            _cacheUiMerc!.spanduk!.pathPhoto2 = path;
            break;
          case EnumNumber.tiga:
            _cacheUiMerc!.spanduk!.pathPhoto3 = path;
            break;
          default:
        }
        break;
      case EnumMerchandising.poster:
        switch (_cacheUiMerc!.poster!.getPhotoKe()) {
          case EnumNumber.satu:
            _cacheUiMerc!.poster!.pathPhoto1 = path;
            break;
          case EnumNumber.dua:
            _cacheUiMerc!.poster!.pathPhoto2 = path;
            break;
          case EnumNumber.tiga:
            _cacheUiMerc!.poster!.pathPhoto3 = path;
            break;
          default:
        }
        break;
      case EnumMerchandising.papan:
        switch (_cacheUiMerc!.papanNama!.getPhotoKe()) {
          case EnumNumber.satu:
            _cacheUiMerc!.papanNama!.pathPhoto1 = path;
            break;
          case EnumNumber.dua:
            _cacheUiMerc!.papanNama!.pathPhoto2 = path;
            break;
          case EnumNumber.tiga:
            _cacheUiMerc!.papanNama!.pathPhoto3 = path;
            break;
          default:
        }
        break;
      case EnumMerchandising.backdrop:
        switch (_cacheUiMerc!.backdrop!.getPhotoKe()) {
          case EnumNumber.satu:
            _cacheUiMerc!.backdrop!.pathPhoto1 = path;
            break;
          case EnumNumber.dua:
            _cacheUiMerc!.backdrop!.pathPhoto2 = path;
            break;
          case EnumNumber.tiga:
            _cacheUiMerc!.backdrop!.pathPhoto3 = path;
            break;
          default:
        }
        break;
      case EnumMerchandising.perdana:
        switch (_cacheUiMerc!.perdana!.getPhotoKe()) {
          case EnumNumber.satu:
            _cacheUiMerc!.perdana!.pathPhoto1 = path;
            break;
          case EnumNumber.dua:
            _cacheUiMerc!.perdana!.pathPhoto2 = path;
            break;
          case EnumNumber.tiga:
            _cacheUiMerc!.perdana!.pathPhoto3 = path;
            break;
          default:
        }
        break;
      case EnumMerchandising.voucherfisik:
        switch (_cacheUiMerc!.voucherFisik!.getPhotoKe()) {
          case EnumNumber.satu:
            _cacheUiMerc!.voucherFisik!.pathPhoto1 = path;
            break;
          case EnumNumber.dua:
            _cacheUiMerc!.voucherFisik!.pathPhoto2 = path;
            break;
          case EnumNumber.tiga:
            _cacheUiMerc!.voucherFisik!.pathPhoto3 = path;
            break;
          default:
        }
        break;
    }
    _sink(_cacheUiMerc);
  }

  Merchandising? _textChanged(
      Merchandising? merchandising, EnumOperator enumOperator, String str) {
    int? value;
    if (str.trim().isNotEmpty) {
      value = int.tryParse(str);
    }

    switch (enumOperator) {
      case EnumOperator.telkomsel:
        merchandising!.telkomsel = value;
        break;
      case EnumOperator.tri:
        merchandising!.tri = value;
        break;
      case EnumOperator.isat:
        merchandising!.isat = value;
        break;
      case EnumOperator.xl:
        merchandising!.xl = value;
        break;
      case EnumOperator.sf:
        merchandising!.sf = value;
        break;
      case EnumOperator.axis:
        merchandising!.axis = value;
        break;
      case EnumOperator.other:
        merchandising!.other = value;
        break;
    }

    return merchandising;
  }

  void refreshPage() {
    _sink(_cacheUiMerc);
  }

  // void _sinkLoading(){
  //   _cacheUiMerc.isLoading = true;
  //   _uiMerch.sink.add(_cacheUiMerc);
  // }

  void _sink(UIMerchan? item) {
    _cacheUiMerc!.isLoading = false;
    _uiMerch.sink.add(item);
  }

  void dispose() {
    _uiMerch.close();
  }
}

enum EnumOperator { telkomsel, tri, isat, xl, sf, axis, other }
