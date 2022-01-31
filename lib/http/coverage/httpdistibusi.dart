import 'dart:convert';
import 'dart:io';

import 'package:hero/http/core/httpbase.dart';
import 'package:hero/model/distribusi/datapembeli.dart';
import 'package:hero/model/distribusi/nota.dart';
import 'package:hero/model/distribusi/rekomendasi.dart';
import 'package:hero/model/pjp.dart';
import 'package:hero/model/distribusi/product.dart';
import 'package:hero/model/serialnumber.dart';
import 'package:hero/util/constapp/accountcontroller.dart';
import 'package:hero/util/dateutil.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../config/configuration_sf.dart';

class HttpDIstribution extends HttpBase {
  Future<List<Product>?> getDaftarProduct() async {
    Uri uri = configuration.uri('/clockindistribusi/penjualan_daftar_produk');
    try {
      final Map<String, String> headers = await getHeader();
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        return _olahDaftarProduct(value);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<int?> getSisaLinkaja() async {
    Uri uri = configuration.uri('/clockindistribusi/penjualan_limit_linkaja');
    try {
      final Map<String, String> headers = await getHeader();
      final response = await http.get(uri, headers: headers);
      //  ph(response.body);
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
      //  ph(e.toString());
      return 0;
    }
  }

  Future<DetailNota?> getDetailNota(String? nota) async {
    Uri uri =
        configuration.uri('/clockindistribusi/distribusi_detail_nota/$nota');
    try {
      final Map<String, String> headers = await getHeader();
      final response = await http.get(uri, headers: headers);
      //  ph("detail nota: ${response.body}");
      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        return DetailNota.fromJson(value);
      }
      return null;
    } catch (e) {
      // ph(e.toString());
      return null;
    }
  }

  Future<List<Nota>?> getDaftarNota(Pjp pjp) async {
    try {
      String tglparam = DateUtility.dateToStringParam(DateTime.now());
      Uri uri = configuration
          .uri('/clockindistribusi/distribusi_daftar_nota/${pjp.id}/$tglparam');
      final Map<String, String> headers = await getHeader();
      final response = await http.get(uri, headers: headers);
      //  ph("daftar nota: ${response.body}");

      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        return _olahDaftarNota(value);
      }
      return null;
    } catch (e) {
      // ph(e.toString());
      return null;
    }
  }

  Future<Rekomendasi?> getRekomendasi(Pjp pjp) async {
    Map<String, String> headers = await getHeader();

    Map map = {"id_tempat": pjp.tempat!.id};

    Uri uri =
        configuration.uri('/clockindistribusi/distribusi_history_rekomendasi');
    http.Response? response;
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );
      // ph(response.body);
      // ph(response.statusCode);
      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        return _olahRekomendasi(value);
      } else {
        return null;
      }
    } catch (e) {
      // ph(e);
      // ph(response?.body);
      return null;
    }
  }

  Future<List<SerialNumber>?> getAllDaftarSn(String? idproduct) async {
    Map<String, String> headers = await getHeader();

    Map map = {
      "id_produk": idproduct,
    };

    Uri uri = configuration.uri('/clockindistribusi/penjualan_daftar_sn_all');

    http.Response? response;
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );
      // ph(response.body);
      // ph(response.statusCode);
      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        return _olahDaftarSn(value);
      } else {
        return null;
      }
    } catch (e) {
      // ph(e);
      // ph(response?.body);
      return null;
    }
  }

  Future<List<SerialNumber>?> getDaftarSn(
      String? idproduct, String serialawal, String serialakhir) async {
    Map<String, String> headers = await getHeader();

    Map map = {
      "id_produk": idproduct,
      "sn_awal": serialawal,
      "sn_akhir": serialakhir
    };

    Uri uri = configuration.uri('/clockindistribusi/penjualan_daftar_sn');
    // ph("URL DAFTAR SERIAL NUMBER: ${uri.path}");

    http.Response? response;
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );
      // ph(response.body);
      // ph(response.statusCode);
      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        return _olahDaftarSn(value);
      } else {
        return null;
      }
    } catch (e) {
      // ph(e);
      // ph(response?.body);
      return null;
    }
  }

  Future<bool> submitKonsinyasi(DataPembeli dataPembeli) async {
    Map<String, String> headers = await getHeader();
    Uri uri =
        configuration.uri('/clockindistribusi/penjualan_bayar_konsinyasi');
    http.Response? response;
    ph(dataPembeli.toJson());
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(dataPembeli.toJson()),
      );
      ph("Submit kosinyansi");
      ph(response.body);
      ph(response.statusCode);
      ph("=========");
      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        return _olahCreateSuccess(value);
      }
      return false;
    } catch (e) {
      ph(e);
      ph(response?.body);
      return false;
    }
  }

  Future<bool> uploadPhoto(String filepath, {required bool isclose}) async {
    Map<String, String> headers = await getHeader();
    String? idhitory = await AccountHore.getIdHistoryPjp();
    String url = '';
    // ph(isclose);
    if (isclose) {
      url = '/clockout/pjp_upload_foto';
    } else {
      url = '/clockindistribusi/distribusi_foto';
    }

    ///===================================
    var request = http.MultipartRequest('POST', configuration.uri(url));
    request.headers.addAll(headers);
    request.fields['id_history_pjp'] = idhitory!;
    //  ph('url: ${configuration.uri(url).path}');
    request.files.add(http.MultipartFile.fromBytes(
      'myfile1', File(filepath).readAsBytesSync(),
      // filename: filepath.split("/").last,
      contentType: MediaType('image', 'jpg'),
      filename: 'myfile1',
    ));
    var res = await request.send();
    var response = await http.Response.fromStream(res);
    // ph('idhistory:$idhitory');
    // ph(filepath);
    // ph(response.body);
    // ph(response.statusCode);
    if (response.statusCode == 200) {
      dynamic value = json.decode(response.body);
      return _olahCreateSuccess(value);
    }
    return false;
  }

  Future<bool> submitLunas(DataPembeli dataPembeli) async {
    Map<String, String> headers = await getHeader();
    Uri uri = configuration.uri('/clockindistribusi/penjualan_bayar_lunas');
    http.Response? response;
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(dataPembeli.toJson()),
      );
      ph("Submit LUNAS");
      ph(response.body);
      ph(response.statusCode);
      ph("=========");
      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        return _olahCreateSuccess(value);
      }
      return false;
    } catch (e) {
      ph(e);
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

        if (ld.isNotEmpty) {
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

        if (ld.isNotEmpty) {
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
          if (litem.isNotEmpty) {
            // ph('2 : ${litem.length}');
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

  bool _olahCreateSuccess(dynamic value) {
    try {
      Map<String, dynamic> map = value;
      if (map['status'] is String) {
        int? i = int.tryParse(map['status']);
        ph('nilai status berapa $i');
        if (i == 1) {
          return true;
        }
      } else if (map['status'] is int) {
        if (map['status'] == 1) {
          return true;
        }
      }

      return false;
    } catch (e) {
      ph(e.toString());
      return false;
    }
  }
}
