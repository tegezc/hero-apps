import 'package:hero/core/data/datasources/database/daoserial.dart';
import 'package:hero/http/coverage/httpdistibusi.dart';
import 'package:hero/model/distribusi/datapembeli.dart';
import 'package:hero/model/distribusi/product.dart';
import 'package:rxdart/subjects.dart';

class BlocDaftarProduct {
  final UIDaftarProduct _cacheuiproduct = UIDaftarProduct();

  final BehaviorSubject<UIDaftarProduct> _uiproduct = BehaviorSubject();

  Stream<UIDaftarProduct> get uiproduct => _uiproduct.stream;
  final DaoSerial _daoSerial = DaoSerial();
  final HttpDIstribution _httpDIstribution = HttpDIstribution();

  void loadData() {
    _setupdata().then((value) {
      if (value) {
        _sink(_cacheuiproduct);
      }
    });
  }

  Future<bool> _setupdata() async {
    List<ItemTransaksi> litem = [];
    List<Product>? lp = await _httpDIstribution.getDaftarProduct();
    int totalkeranjang = 0;
    if (lp != null) {
      for (int i = 0; i < lp.length; i++) {
        Product p = lp[i];

        int? qty = await _daoSerial.getCountByIdProduct(p.id);
        ItemTransaksi item = ItemTransaksi(p, qty);
        litem.add(item);
      }

      for (var element in litem) {
        totalkeranjang = totalkeranjang + element.jumlah!;
      }
      _cacheuiproduct.litemtrx = litem;
      _cacheuiproduct.jmlkeranjang = totalkeranjang;
      return true;
    }
    return false;
  }

  void reloadDaftarProduct() {
    _reloadDataLocal().then((value) {
      if (value) {
        _sink(_cacheuiproduct);
      }
    });
  }

  Future<bool> _reloadDataLocal() async {
    int totalKeranjang = 0;
    for (int i = 0; i < _cacheuiproduct.litemtrx!.length; i++) {
      ItemTransaksi item = _cacheuiproduct.litemtrx![i];
      Product p = item.product!;

      int? qty = await _daoSerial.getCountByIdProduct(p.id);
      _cacheuiproduct.litemtrx![i].jumlah = qty;
    }

    for (var element in _cacheuiproduct.litemtrx!) {
      totalKeranjang = totalKeranjang + element.jumlah!;
    }

    _cacheuiproduct.jmlkeranjang = totalKeranjang;
    return true;
  }

  void _sink(UIDaftarProduct item) {
    _uiproduct.sink.add(item);
  }

  void dispose() {
    _uiproduct.close();
  }
}

class UIDaftarProduct {
  List<ItemTransaksi>? litemtrx;
  int? jmlkeranjang;
}
