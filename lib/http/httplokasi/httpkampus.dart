import 'dart:convert';

import 'package:hero/model/lokasi/universitas.dart';
import 'package:hero/util/constapp/constapp.dart';
import 'package:http/http.dart' as http;

import '../httputil.dart';

class HttpKampus {
  Future<List<dynamic>?> detailUniv(String? iduniv) async {
    Map<String, String> headers = await HttpUtil.getHeader();
    Uri uri = ConstApp.uri('/lokasi/tampil/KAM/$iduniv');
    try {
      http.Response response = await http.get(uri, headers: headers);

      print(response.body);
      return json.decode(response.body);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Map<String, dynamic>?> createKampus(Universitas univ) async {
    Map<String, String> headers = await HttpUtil.getHeader();
    //  Outlet o = dummyWajib();
    print(univ.toJson());
    Uri uri = ConstApp.uri('/lokasi/kampus_create');
    http.Response? response;
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(univ.toJson()),
      );
      if (response.statusCode == 200) {
        print(response.body);
        return json.decode(response.body);
      } else {
        print(response.body);
        return null;
      }
    } catch (e) {
      print(e);
      print(response?.body);
      return null;
    }
  }

  Future<Map<String, dynamic>?> updateKampus(Universitas univ) async {
    Map<String, String> headers = await HttpUtil.getHeader();
    Uri uri = ConstApp.uri('/lokasi/kampus_update/${univ.iduniv}');
    http.Response? response;
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(univ.toJson()),
      );
      if (response.statusCode == 200) {
        print(response.body);
        return json.decode(response.body);
      } else {
        print(response.body);
        return null;
      }
    } catch (e) {
      print(e);
      print(response?.body);
      return null;
    }
  }
}
