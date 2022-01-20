import 'dart:convert';

import 'package:hero/http/core/httpbase.dart';
import 'package:hero/model/lokasi/sekolah.dart';
import 'package:http/http.dart' as http;

class HttpSekolah extends HttpBase {
  Future<List<dynamic>?> detailSekolah(String? idsekolah) async {
    Map<String, String> headers = await getHeader();

    try {
      Uri uri = configuration.uri('/lokasi/tampil/SEK/$idsekolah');
      http.Response response = await http.get(uri, headers: headers);
      return json.decode(response.body);
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> createSekolah(Sekolah sekolah) async {
    Map<String, String> headers = await getHeader();
    http.Response? response;
    try {
      Uri uri = configuration.uri('/lokasi/sekolah_create');
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(sekolah.toJson()),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> updateSekolah(Sekolah sekolah) async {
    Map<String, String> headers = await getHeader();
    http.Response? response;
    try {
      Uri uri =
          configuration.uri('/lokasi/sekolah_update/${sekolah.idsekolah}');
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(sekolah.toJson()),
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
