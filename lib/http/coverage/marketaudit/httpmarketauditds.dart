import 'dart:convert';

import 'package:hero/http/core/httpbase.dart';
import 'package:hero/model/marketaudit/frekuensipaket.dart';
import 'package:hero/model/marketaudit/operator.dart';
import 'package:hero/model/marketaudit/quisioner.dart';
import 'package:hero/util/dateutil.dart';
import 'package:http/http.dart' as http;

import '../../../config/configuration_sf.dart';

class HttpMarketAuditDs extends HttpBase {
  Future<bool> createQuisioner(Quisioner quisioner) async {
    Map<String, String> headers = await getHeader();
    Uri uri =
        configuration.uri('/clockinmarketaudit/marketaudit_create_quisioner');
    http.Response? response;
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: quisioner.toJson(),
      );
      ph(response.body);
      ph(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      ph(e);
      ph(response?.body);
      return false;
    }
  }

  Future<List<Operator>> getListOperator() async {
    List<Operator> lOperator = List.empty(growable: true);
    Uri uri = configuration.uri('/combobox/provider');
    try {
      final Map<String, String> headers = await getHeader();
      final response = await http.get(uri, headers: headers);
      ph(response.body);
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
      ph(e.toString());
      return List.unmodifiable(lOperator);
    }
  }

  Future<List<FrekuensiPaket>> getListFrekuensi() async {
    List<FrekuensiPaket> lFrekuensi = List.empty(growable: true);
    Uri uri = configuration.uri('/combobox/frekuensi_paket');
    try {
      final Map<String, String> headers = await getHeader();
      final response = await http.get(uri, headers: headers);
      ph(response.body);
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
      ph(e.toString());
      return List.unmodifiable(lFrekuensi);
    }
  }

  Future<Quisioner?> getDetailQuisioner(
      {required String jenislokasi,
      required String idloksi,
      required DateTime tgl}) async {
    String strDt = DateUtility.dateToStringParam(tgl);
    Uri uri = configuration.uri(
        '/bottommenumarketaudit/marketaudit_detail_quisioner/$jenislokasi/$idloksi/$strDt');
    try {
      final Map<String, String> headers = await getHeader();
      final response = await http.get(uri, headers: headers);
      ph("${uri.path}: ${response.body} : code ${response.statusCode}");
      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        return _olahJsonToQuisioner(value);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Quisioner? _olahJsonToQuisioner(dynamic value) {
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
