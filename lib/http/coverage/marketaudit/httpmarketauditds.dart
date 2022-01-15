import 'dart:convert';

import 'package:hero/model/marketaudit/frekuensipaket.dart';
import 'package:hero/model/marketaudit/operator.dart';
import 'package:hero/model/marketaudit/quisioner.dart';
import 'package:hero/util/constapp/constapp.dart';
import 'package:hero/util/dateutil.dart';
import 'package:http/http.dart' as http;

import '../../httputil.dart';

class HttpMarketAuditDs {
  Future<bool> createQuisioner(Quisioner quisioner) async {
    Map<String, String> headers = await HttpUtil.getHeader();
    Uri uri = ConstApp.uri('/clockinmarketaudit/marketaudit_create_quisioner');
    http.Response? response;
    try {
      print("json di kirim: ${quisioner.toJson()}");
      response = await http.post(
        uri,
        headers: headers,
        body: quisioner.toJson(),
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

  Future<List<Operator>> getListOperator() async {
    List<Operator> lOperator = List.empty(growable: true);
    Uri uri = ConstApp.uri('/combobox/provider');
    try {
      final Map<String, String> headers = await HttpUtil.getHeader();
      final response = await http.get(uri, headers: headers);
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> value = json.decode(response.body);
        if (value.isNotEmpty) {
          for (Map<String, dynamic> o in value) {
            Operator operator = Operator.fromMap(o);
            if (operator.isValid()) {
              lOperator.add(operator);
            }
          }
        }
      }
      return List.unmodifiable(lOperator);
    } catch (e) {
      print(e.toString());
      return List.unmodifiable(lOperator);
    }
  }

  Future<List<FrekuensiPaket>> getListFrekuensi() async {
    List<FrekuensiPaket> lFrekuensi = List.empty(growable: true);
    Uri uri = ConstApp.uri('/combobox/frekuensi_paket');
    try {
      final Map<String, String> headers = await HttpUtil.getHeader();
      final response = await http.get(uri, headers: headers);
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> value = json.decode(response.body);
        if (value.isNotEmpty) {
          for (Map<String, dynamic> o in value) {
            FrekuensiPaket operator = FrekuensiPaket.fromMap(o);
            if (operator.isValid()) {
              lFrekuensi.add(operator);
            }
          }
        }
      }
      return List.unmodifiable(lFrekuensi);
    } catch (e) {
      print(e.toString());
      return List.unmodifiable(lFrekuensi);
    }
  }

  Future<Quisioner?> getDetailQuisioner(
      {required String jenislokasi,
      required String idloksi,
      required DateTime tgl}) async {
    String strDt = DateUtility.dateToStringParam(tgl);
    Uri uri = ConstApp.uri(
        '/bottommenumarketaudit/marketaudit_detail_quisioner/$jenislokasi/$idloksi/$strDt');
    try {
      final Map<String, String> headers = await HttpUtil.getHeader();
      final response = await http.get(uri, headers: headers);
      print("${uri.path}: ${response.body} : code ${response.statusCode}");
      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        return _olahJsonToQuisioner(value);
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Quisioner? _olahJsonToQuisioner(dynamic value) {
    var contoh = {
      "status": 200,
      "data": [
        {
          "nama_pelanggan": "silasila",
          "op_telepon": "telkomsel",
          "msisdn_telepon": "08523565356",
          "op_internet": "telkomsel",
          "msisdn_internet": "0852365287",
          "op_digital": "xl",
          "msisdn_digital": "086328624554",
          "jenis": "Bulanan",
          "kuota_per_bulan": "30",
          "pulsa_per_bulan": "100000"
        }
      ]
    };

    if (value == null) {
      return null;
    }

    Map<String, dynamic> map = value;
    if (map["data"] != null) {
      List<dynamic> ld = map['data'];
      if (ld.isNotEmpty) {
        Map<String, dynamic> mapdata = ld[0];
        return Quisioner.fromMap(mapdata);
      }
    }
    return null;
  }
}
