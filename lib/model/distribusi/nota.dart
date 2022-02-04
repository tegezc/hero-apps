// "no_nota": "SSF045L-1",
// "pembayaran": "LUNAS"
import 'package:hero/util/numberconverter.dart';

import 'datapembeli.dart';

class Nota {
  String? noNota;
  String? pembayaran;
  late bool isShared;

  Nota.fromJson(Map<String, dynamic> map) {
    isShared = false;
    noNota = map['no_nota'] ?? '';
    pembayaran = map['pembayaran'] ?? '';
  }
}

class DetailNota {
  // {
  // "status": 200,
  // "data_pembeli": [{
  // "mitra_ad": "PT. Selular Media Infotama",
  // "nama_sales": "EDI SUPRIANTO",
  // "tgl_transaksi": "2020-12-13",
  // "nama_jenis_lokasi": "OUTLET",
  // "nama_pembeli": "RORIANTI CELL",
  // "no_hp_pembeli": "087876564325",
  // "pembayaran": "LUNAS"
  // }],
  // "data_produk": [{
  // "id_produk": "14",
  // "nama_produk": "KARTU AS REGULER 50K",
  // "harga_jual": "5500.00",
  // "qty": "2"
  // }],
  // "data_link_aja": [{
  // "link_aja": "5000000.00"
  // }]
  // }
  String? mitra;
  String? namasales;
  String? tgl;
  String? jenislokasi;
  String? namapembeli;
  String? nohppembeli;
  String? jnspembayaran;

  List<ItemTransaksi>? ltrax;

  int? linkaja;

  DetailNota.fromJson(dynamic value) {
    try {
      Map<String, dynamic> md = value;
      if (md['data_pembeli'] != null) {
        List<dynamic> ld = md['data_pembeli'];
        if (ld.isNotEmpty) {
          Map<String, dynamic> mapp = ld[0];
          mitra = mapp['mitra_ad'] ?? '';
          namasales = mapp['nama_sales'] ?? '';
          tgl = mapp['tgl_transaksi'] ?? '';
          jenislokasi = mapp['nama_jenis_lokasi'] ?? '';
          namapembeli = mapp['nama_pembeli'] ?? '';
          nohppembeli = mapp['no_hp_pembeli'] ?? '';
          jnspembayaran = mapp['pembayaran'] ?? '';
        }
      }

      if (md['data_produk'] != null) {
        ltrax = [];
        List<dynamic> ld = md['data_produk'];
        for (int i = 0; i < ld.length; i++) {
          Map<String, dynamic> map = ld[i];
          ItemTransaksi item = ItemTransaksi.fromJson(map);
          ltrax!.add(item);
        }
      }

      if (md['data_link_aja'] != null) {
        List<dynamic> ld = md['data_link_aja'];
        if (ld.isNotEmpty) {
          Map<String, dynamic> map = ld[0];
          linkaja = ConverterNumber.stringToIntOrZero(map['link_aja']);
        }
      }
    } catch (e) {}
  }
}
