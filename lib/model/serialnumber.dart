import 'package:hero/database/stringdb.dart';
import 'package:hero/util/numberconverter.dart';

class SerialNumber {
  // "id_sales": "SSF045",
  // "serial_number": "9000011115",
  // "id_produk": "1",
  // "harga_modal": "5000.00",
  // "harga_jual": "5500.00"

  String? idsales;
  String? serial;
  String? idproduct;
  int? hargamodal;
  int? hargajual;

  // for ui purpose
  bool? ischecked;
  SerialNumber.fromDb(
      {this.serial, this.idproduct, this.hargamodal, this.hargajual});
  SerialNumber.fromJson(Map<String, dynamic> map) {
    ischecked = false;
    idsales = map['id_sales'] == null ? '' : map['id_sales'];
    serial = map['serial_number'] == null ? '' : map['serial_number'];
    idproduct = map['id_produk'] == null ? '' : map['id_produk'];
    hargamodal = ConverterNumber.stringToInt(map['harga_modal']);
    hargajual = ConverterNumber.stringToInt(map['harga_jual']);
  }

  Map<String, dynamic> toJson() {
    // "serial_number" : "9000011122",
    // "id_produk" : "14",
    // "harga_modal" : "5000.00",
    // "harga_jual" : "5500.00"

    return {
      "serial_number": serial,
      "id_produk": idproduct,
      "harga_modal": hargamodal,
      "harga_jual": hargajual
    };
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map[TbSerial.idproduk] = idproduct;
    map[TbSerial.hargajual] = hargajual;
    map[TbSerial.hargamodal] = hargamodal;
    map[TbSerial.serial] = serial;

    return map;
  }

  @override
  bool operator ==(dynamic other) =>
      other != null && other is SerialNumber && serial == other.serial;

  @override
  String toString() {
    return '$serial | $idproduct';
  }
}
