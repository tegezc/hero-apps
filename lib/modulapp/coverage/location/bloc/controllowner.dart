import 'package:hero/model/lokasi/owner.dart';

class ControllOwner {
  Owner? _cahceOwner;

  void firstTimeEdit(Owner? owner) {
    _cahceOwner = owner;
  }

  void firstTimeOwner() {
    _cahceOwner = new Owner.kosong();
  }

  Owner? getOwner() {
    return _cahceOwner;
  }

  void setNamaOwner(String t) {
    _cahceOwner!.nama = t;
  }

  void setNoHp(String t) {
    _cahceOwner!.nohp = t;
  }

  void setTglLahir(DateTime? dt) {
    _cahceOwner!.tglLahir = dt;
  }

  void setHobi(String t) {
    _cahceOwner!.hobi = t;
  }

  void setFb(String t) {
    _cahceOwner!.fb = t;
  }

  void setIg(String t) {
    _cahceOwner!.ig = t;
  }
}
