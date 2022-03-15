import 'package:hero/model/serialnumber.dart';
import 'package:hero/util/numberconverter.dart';

import 'product.dart';

class DataPembeli {
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> ls = [];
    if (lserial != null) {
      for (var element in lserial!) {
        ls.add(element.toJson());
      }
    }
    return {
      "id_tempat": idtempat,
      "nama_pembeli": namapembeli,
      "no_hp_pembeli": nohppembeli,
      "link_aja": '$linkaja',
      "id_jenis_lokasi": idJenisLokasi,
      "data": ls
    };
  }

  String? idtempat;
  String? namapembeli;
  String? nohppembeli;
  String? idJenisLokasi;

  List<SerialNumber>? lserial;
  int? linkaja;
}

class ItemTransaksi {
  // "id_produk": "14",
  // "nama_produk": "KARTU AS REGULER 50K",
  // "harga_jual": "5500.00",
  // "qty": "2"
  Product? product;
  int? jumlah;

  ItemTransaksi(this.product, this.jumlah);
  ItemTransaksi.fromJson(Map<String, dynamic> map) {
    product = Product.fromJson(map);
    jumlah = ConverterNumber.stringToIntOrZero(map['qty']);
  }
}
