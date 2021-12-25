import 'package:hero/util/numberconverter.dart';

class Product {
  String? id;
  String? nama;
  int? stock;
  int? hargajual;
  int? hargamodal;
  // "id_produk": "14",
  // "nama_produk": "KARTU AS REGULER 50K",
  // "harga_jual": "5500.00",
  // "harga_modal": "5000.00",
  // "jumlah_stock": "23"

  Product.fromJson(Map<String, dynamic> map) {
    id = map['id_produk'] == null ? '' : map['id_produk'];
    nama = map['nama_produk'] == null ? '' : map['nama_produk'];
    hargajual = ConverterNumber.stringToInt(map['harga_jual']);
    hargamodal = ConverterNumber.stringToInt(map['harga_modal']);
    stock = ConverterNumber.stringToInt(map['jumlah_stock']);
  }

  Map toJson() {
    return {};
  }

  Product(this.nama, this.stock, this.hargajual);
}
