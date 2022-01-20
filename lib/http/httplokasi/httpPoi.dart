import 'dart:convert';

import 'package:hero/http/core/httpbase.dart';
import 'package:hero/model/lokasi/poi.dart';
import 'package:http/http.dart' as http;

class HttpPoi extends HttpBase {
  Future<List<dynamic>?> detailPoi(String? idpoi) async {
    Map<String, String> headers = await getHeader();
    Uri uri = configuration.uri('/lokasi/tampil/POI/$idpoi');
    try {
      http.Response response = await http.get(uri, headers: headers);

      print(response.body);
      return json.decode(response.body);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Map<String, dynamic>?> createPoi(Poi poi) async {
    Map<String, String> headers = await getHeader();
    Uri uri = configuration.uri('/lokasi/poi_create');
    http.Response? response;
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(poi.toJson()),
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

  Future<Map<String, dynamic>?> updatePoi(Poi poi) async {
    Map<String, String> headers = await getHeader();
    Uri uri = configuration.uri('/lokasi/poi_update/${poi.idpoi}');
    http.Response? response;
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(poi.toJson()),
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
