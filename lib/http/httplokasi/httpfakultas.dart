import 'dart:convert';

import 'package:hero/http/core/httpbase.dart';
import 'package:hero/model/lokasi/Fakultas.dart';
import 'package:hero/model/lokasi/universitas.dart';
import 'package:http/http.dart' as http;

import '../../configuration.dart';

class HttpFakultas extends HttpBase {
  Future<List<dynamic>?> detailFakultas(String? idfak) async {
    Map<String, String> headers = await getHeader();
    Uri uri = configuration.uri('/lokasi/tampil/FAK/$idfak');
    try {
      http.Response response = await http.get(uri, headers: headers);

      ph(response.body);
      return json.decode(response.body);
    } catch (e) {
      ph(e);
      return null;
    }
  }

  Future<Map<String, dynamic>?> createFakultas(Fakultas outlet) async {
    Map<String, String> headers = await getHeader();
    Uri uri = configuration.uri('/lokasi/fakultas_create');
    http.Response? response;
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(outlet.toJson()),
      );
      if (response.statusCode == 200) {
        ph(response.body);
        return json.decode(response.body);
      } else {
        ph(response.body);
        return null;
      }
    } catch (e) {
      ph(e);
      ph(response?.body);
      return null;
    }
  }

  Future<Map<String, dynamic>?> updateFakultas(Fakultas outlet) async {
    Map<String, String> headers = await getHeader();
    Uri uri = configuration.uri('/lokasi/fakultas_update/${outlet.idfak}');
    http.Response? response;
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(outlet.toJson()),
      );
      if (response.statusCode == 200) {
        ph(response.body);
        return json.decode(response.body);
      } else {
        ph(response.body);
        return null;
      }
    } catch (e) {
      ph(e);
      ph(response?.body);
      return null;
    }
  }

  Future<List<Universitas>?> getComboUniv() async {
    Uri uri = configuration.uri('/combobox/universitas');
    try {
      Map<String, String> headers = await getHeader();
      http.Response response = await http.get(uri, headers: headers);

      ph(response.body);
      // return json.decode(response.body);
      return _olahComboUniv(json.decode(response.body));
    } catch (e) {
      ph(e);
      return null;
    }
  }

  List<Universitas> _olahComboUniv(dynamic value) {
    List<Universitas> luniv = [];

    List<dynamic> ld = value;
    if (ld.isNotEmpty) {
      for (int i = 0; i < ld.length; i++) {
        Map<String, dynamic> map = ld[i];
        Universitas kec = Universitas.fromJson(map);
        luniv.add(kec);
      }
    }
    return luniv;
  }
}
