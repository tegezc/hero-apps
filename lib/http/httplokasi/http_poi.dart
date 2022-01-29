import 'dart:convert';

import 'package:hero/http/core/httpbase.dart';
import 'package:hero/model/lokasi/poi.dart';
import 'package:http/http.dart' as http;

import '../../configuration.dart';

class HttpPoi extends HttpBase {
  Future<List<dynamic>?> detailPoi(String? idpoi) async {
    Map<String, String> headers = await getHeader();
    Uri uri = configuration.uri('/location/tampil/POI/$idpoi');
    try {
      http.Response response = await http.get(uri, headers: headers);

      ph(response.body);
      return json.decode(response.body);
    } catch (e) {
      ph(e);
      return null;
    }
  }

  Future<Map<String, dynamic>?> createPoi(Poi poi) async {
    Map<String, String> headers = await getHeader();
    Uri uri = configuration.uri('/location/poi_create');
    http.Response? response;
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(poi.toJson()),
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

  Future<Map<String, dynamic>?> updatePoi(Poi poi) async {
    Map<String, String> headers = await getHeader();
    Uri uri = configuration.uri('/location/poi_update/${poi.idpoi}');
    http.Response? response;
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(poi.toJson()),
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
