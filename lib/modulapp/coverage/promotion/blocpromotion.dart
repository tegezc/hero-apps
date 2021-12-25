import 'package:hero/http/coverage/httppromotion.dart';
import 'package:hero/model/pjp.dart';
import 'package:hero/model/promotion/promotion.dart';
import 'package:rxdart/subjects.dart';

class UIPromotion {
  List<Promotion>? lprom = [];
  int jmlfinish = 0;
}

class BlocPromotion {
  UIPromotion? _cacheUiMerc;
  HttpPromotion _httpPromotion = new HttpPromotion();
  final BehaviorSubject<UIPromotion?> _uiProm = BehaviorSubject();

  Stream<UIPromotion?> get uiProm => _uiProm.stream;

  void reloadDataFromInternet(Pjp? pjp) {
    _cacheUiMerc = UIPromotion();
    _setupPromotion().then((value) {
      this._sink(_cacheUiMerc);
    });
  }

  Future<bool> _setupPromotion() async {
    _cacheUiMerc!.lprom = await _httpPromotion.getDaftarPromotion();
    List<Promotion>? lp = await _httpPromotion.getPromotionFinish();
    if (lp != null && _cacheUiMerc!.lprom != null) {
      _cacheUiMerc!.jmlfinish = lp.length;
      lp.forEach((a) {
        for (int i = 0; i < _cacheUiMerc!.lprom!.length; i++) {
          Promotion p = _cacheUiMerc!.lprom![i];
          if (a.idjnsweekly == p.idjnsweekly) {
            _cacheUiMerc!.lprom![i].isVideoExist = true;
          }
        }
      });
    }

    return true;
  }

  void _sink(UIPromotion? item) {
    _uiProm.sink.add(item);
  }

  void dispose() {
    _uiProm.close();
  }
}
