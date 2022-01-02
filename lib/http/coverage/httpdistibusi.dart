import 'dart:convert';
import 'dart:io';

import 'package:hero/model/distribusi/datapembeli.dart';
import 'package:hero/model/distribusi/nota.dart';
import 'package:hero/model/distribusi/rekomendasi.dart';
import 'package:hero/model/pjp.dart';
import 'package:hero/model/distribusi/product.dart';
import 'package:hero/model/serialnumber.dart';
import 'package:hero/util/constapp/accountcontroller.dart';
import 'package:hero/util/constapp/constapp.dart';
import 'package:hero/util/dateutil.dart';
import 'package:hero/util/numberconverter.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../httputil.dart';

class HttpDIstribution {
  Future<List<Product>?> getDaftarProduct() async {
    Uri uri = ConstApp.uri('/clockindistribusi/penjualan_daftar_produk');
    try {
      final Map<String, String> headers = await HttpUtil.getHeader();
      final response = await http.get(uri, headers: headers);
      print(response.body);
      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        return this._olahDaftarProduct(value);
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<int?> getSisaLinkaja() async {
    Uri uri = ConstApp.uri('/clockindistribusi/penjualan_limit_linkaja');
    try {
      final Map<String, String> headers = await HttpUtil.getHeader();
      final response = await http.get(uri, headers: headers);
      print(response.body);
      if (response.statusCode == 200) {
        //"status": 200,
        // "data": 10000000

        Map<String, dynamic> value = json.decode(response.body);
        if (value['data'] != null) {
          return value['data'];
        }

        return 0;
      }
      return 0;
    } catch (e) {
      print(e.toString());
      return 0;
    }
  }

  Future<DetailNota?> getDetailNota(String? nota) async {
    Uri uri = ConstApp.uri('/clockindistribusi/distribusi_detail_nota/$nota');
    try {
      final Map<String, String> headers = await HttpUtil.getHeader();
      final response = await http.get(uri, headers: headers);
      print("detail nota: ${response.body}");
      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        return DetailNota.fromJson(value);
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<Nota>?> getDaftarNota(Pjp pjp) async {
    try {
      String tglparam = DateUtility.dateToStringParam(DateTime.now());
      Uri uri = ConstApp.uri(
          '/clockindistribusi/distribusi_daftar_nota/${pjp.id}/$tglparam');
      final Map<String, String> headers = await HttpUtil.getHeader();
      final response = await http.get(uri, headers: headers);
      print("daftar nota: ${response.body}");

      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        return this._olahDaftarNota(value);
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Rekomendasi?> getRekomendasi(Pjp pjp) async {
    Map<String, String> headers = await HttpUtil.getHeader();

    Map map = {"id_tempat": pjp.tempat!.id};

    Uri uri = ConstApp.uri('/clockindistribusi/distribusi_history_rekomendasi');
    http.Response? response;
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );
      // print(response.body);
      // print(response.statusCode);
      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        return _olahRekomendasi(value);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      print(response?.body);
      return null;
    }
  }

  Future<List<SerialNumber>?> getDaftarSn(
      String? idproduct, String serialawal, String serialakhir) async {
    Map<String, String> headers = await HttpUtil.getHeader();

    Map map = {
      "id_produk": idproduct,
      "sn_awal": serialawal,
      "sn_akhir": serialakhir
    };

    Uri uri = ConstApp.uri('/clockindistribusi/penjualan_daftar_sn');

    http.Response? response;
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        return _olahDaftarSn(value);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      print(response?.body);
      return null;
    }
  }

  Future<bool> submitKonsinyasi(DataPembeli dataPembeli) async {
    Map<String, String> headers = await HttpUtil.getHeader();
    Uri uri = ConstApp.uri('/clockindistribusi/penjualan_bayar_konsinyasi');
    http.Response? response;
    print(dataPembeli.toJson());
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(dataPembeli.toJson()),
      );
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      print(response?.body);
      return false;
    }
  }

  Future<bool> uploadPhoto(String filepath, bool isclose) async {
    Map<String, String> headers = await HttpUtil.getHeader();
    String? idhitory = await AccountHore.getIdHistoryPjp();
    String url = '';
    print(isclose);
    if (isclose) {
      url = 'clockout/pjp_upload_foto';
    } else {
      url = 'clockindistribusi/distribusi_foto';
    }

    String uri = '${ConstApp.domain}/$url';

    ///===================================
    var request = http.MultipartRequest('POST', Uri.parse(uri));
    request.headers.addAll(headers);
    request.fields['id_history_pjp'] = idhitory!;
    request.files.add(http.MultipartFile.fromBytes(
      'myfile1', File(filepath).readAsBytesSync(),
      filename: filepath.split("/").last,
      contentType: MediaType('application', 'jpeg'),
      //      filename: 'myfile1'),
    ));
    var res = await request.send();
    var response = await http.Response.fromStream(res);
    print('idhistory:$idhitory');
    print(filepath);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      int? i = ConverterNumber.stringToInt(map['status']);
      if (i == 1) {
        return true;
      }
    }
    return false;
  }

  Future<bool> submitLunas(DataPembeli dataPembeli) async {
    Map<String, String> headers = await HttpUtil.getHeader();
    Uri uri = ConstApp.uri('/clockindistribusi/penjualan_bayar_lunas');
    http.Response? response;
    try {
      print("data pembeli: ${jsonEncode(dataPembeli.toJson())}");
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(dataPembeli.toJson()),
      );
      print("submit lunas: ${response.body}");
      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      print(response?.body);
      return false;
    }
  }

  // {
  // "status": 200,
  // "data": [{
  // "id_produk": "14",
  // "nama_produk": "KARTU AS REGULER 50K",
  // "harga_jual": "5500.00",
  // "harga_modal": "5000.00",
  // "jumlah_stock": "23"
  // },
  // {
  // "id_produk": "15",
  // "nama_produk": "KARTU AS 50GB",
  // "harga_jual": "10500.00",
  // "harga_modal": "10000.00",
  // "jumlah_stock": "143"
  // }
  // ]
  // }
  List<Product> _olahDaftarProduct(dynamic value) {
    List<Product> lproduct = [];
    try {
      Map<String, dynamic> md = value;
      if (md['data'] != null) {
        List<dynamic> ld = md['data'];

        if (ld.length > 0) {
          for (int i = 0; i < ld.length; i++) {
            Map<String, dynamic> map = ld[i];

            Product p = Product.fromJson(map);

            lproduct.add(p);
          }
        }
      }

      return lproduct;
    } catch (e) {
      return lproduct;
    }
  }

  List<Nota> _olahDaftarNota(dynamic value) {
    List<Nota> lnota = [];
    try {
      Map<String, dynamic> md = value;
      if (md['data'] != null) {
        List<dynamic> ld = md['data'];

        if (ld.length > 0) {
          for (int i = 0; i < ld.length; i++) {
            Map<String, dynamic> map = ld[i];

            Nota n = Nota.fromJson(map);

            lnota.add(n);
          }
        }
      }

      return lnota;
    } catch (e) {
      return lnota;
    }
  }

  Rekomendasi? _olahRekomendasi(dynamic value) {
    Rekomendasi rekomendasi = Rekomendasi();
    List<String> nama = ['segel', 'sa', 'vointernet', 'vogames'];
    try {
      Map<String, dynamic> md = value;
      if (md['data'] == null) {
        return null;
      }

      Map<String, dynamic>? ld = md['data'];

      for (int i = 0; i < nama.length; i++) {
        String tag = nama[i];

        if (ld![tag] != null) {
          List<ItemRekomendasi> litemrek = [];
          List<dynamic> litem = ld[tag];
          if (litem.length > 0) {
            print('2 : ${litem.length}');
            for (int i = 0; i < litem.length; i++) {
              Map<String, dynamic> map = litem[i];
              ItemRekomendasi n = ItemRekomendasi.fromJson(map);
              litemrek.add(n);
            }
            if (tag == 'segel') {
              rekomendasi.lsegel = litemrek;
            } else if (tag == 'sa') {
              rekomendasi.lsa = litemrek;
            } else if (tag == 'vointernet') {
              rekomendasi.lvointernet = litemrek;
            } else if (tag == 'vogames') {
              rekomendasi.lvogames = litemrek;
            }
          }
        }
      }
      return rekomendasi;
    } catch (e) {
      return null;
    }
  }
  //{
  // "status": 200,
  // "data": [
  // {
  // "id_produk": "14",
  // "harga_jual": "5500.00",
  // "harga_modal": "5000.00",
  // "serial_number": "9000011118"
  // },
  // {
  // "id_produk": "14",
  // "harga_jual": "5500.00",
  // "harga_modal": "5000.00",
  // "serial_number": "9000011119"
  // }
  // ]
  // }

  List<SerialNumber> _olahDaftarSn(dynamic value) {
    List<SerialNumber> lsn = [];

    try {
      Map<String, dynamic> mv = value;
      if (mv['data'] != null) {
        List<dynamic> ld = mv['data'];

        for (int i = 0; i < ld.length; i++) {
          Map<String, dynamic> map = ld[i];
          SerialNumber serialNumber = SerialNumber.fromJson(map);
          lsn.add(serialNumber);
        }
      }
      return lsn;
    } catch (e) {
      return lsn;
    }
  }
}
