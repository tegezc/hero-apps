import 'dart:convert';
import 'package:hero/core/log/printlog.dart';
import 'package:hero/http/core/httpbase.dart';
import 'package:http/http.dart' as http;

import '../../config/configuration_sf.dart';

class HttpLogin extends HttpBase {
  Future<Map<String, dynamic>?> login(String username, String password) async {
    Map<String, String> map = {
      "username": '$username',
      "password": '$password'
    };
    Map<String, String> headers = await getHeaderLogin();

    try {
      Uri uri = configuration.uri('/auth/login');
      http.Response response = await http.post(
        uri,
        headers: headers,
        body: map,
      );
      ph(response.body);
      ph(response.statusCode);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      ph(e);
      return null;
    }
  }

  Future<bool> logout() async {
    Map<String, String> headers = await getHeader();

    http.Response response;
    try {
      Uri uri = configuration.uri('/auth/logout');
      response = await http.post(
        uri,
        headers: headers,
      );
      ph(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      ph(e);
      return false;
    }
  }
}
