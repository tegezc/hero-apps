import 'package:hero/model/lokasi/pic.dart';

class ControllPic {
  Pic? _cachePic;

  void firstTimeEdit(Pic? pic) {
    _cachePic = pic;
  }

  void firstTimePic() {
    _cachePic = Pic.kosong();
  }

  Pic? getPic() {
    return _cachePic;
  }

  void setNamaPic(String t) {
    _cachePic!.nama = t;
  }

  void setNoHp(String t) {
    _cachePic!.nohp = t;
  }

  void setTglLahir(DateTime? dt) {
    _cachePic!.tglLahir = dt;
  }

  void setHobi(String t) {
    _cachePic!.hobi = t;
  }

  void setFb(String t) {
    _cachePic!.fb = t;
  }

  void setIg(String t) {
    _cachePic!.ig = t;
  }
}
