import 'dart:convert';

import 'package:hero/core/log/printlog.dart';
import 'package:hero/http/core/httpbase.dart';
import 'package:hero/model/lokasi/universitas.dart';
import 'package:http/http.dart' as http;

import '../../config/configuration_sf.dart';

class HttpKampus extends HttpBase {
  Future<List<dynamic>?> detailUniv(String? iduniv) async {
    Map<String, String> headers = await getHeader();
    Uri uri = configuration.uri('/location/tampil/KAM/$iduniv');
    try {
      http.Response response = await http.get(uri, headers: headers);

      ph(response.body);
      return json.decode(response.body);
    } catch (e) {
      ph(e);
      return null;
    }
  }

  Future<Map<String, dynamic>?> createKampus(Universitas univ) async {
    Map<String, String> headers = await getHeader();
    //  Outlet o = dummyWajib();
    ph(univ.toJson());
    Uri uri = configuration.uri('/location/kampus_create');
    http.Response? response;
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(univ.toJson()),
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

  Future<Map<String, dynamic>?> updateKampus(Universitas univ) async {
    Map<String, String> headers = await getHeader();
    Uri uri = configuration.uri('/location/kampus_update/${univ.iduniv}');
    http.Response? response;
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(univ.toJson()),
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
}
