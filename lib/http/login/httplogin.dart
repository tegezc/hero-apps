import 'dart:convert';
import 'package:hero/http/httputil.dart';
import 'package:hero/util/constapp/constapp.dart';
import 'package:http/http.dart' as http;

class HttpLogin {
  Future<Map<String, dynamic>?> login(String username, String password) async {
    Map<String, String> map = new Map();
    Map<String, String> headers = await HttpUtil.getHeaderLogin();

    /// login DS
    // map['username'] = 'SDS0199';
    // map['password'] = 'SDS0199';

    /// login SC
    // map['username'] = 'SCS0047';
    // map['password'] = 'SCS0047';

    /// login TAP
    // map['username'] = 'SSF0441';
    // map['password'] = 'SSF0441';

    /// login SF
    // map['username'] = 'SSF0440';
    // map['password'] = 'SSF0440';

    /// production
    map['username'] = '$username';
    map['password'] = '$password';
    try {
      Uri uri = ConstApp.uri('/auth/login');
      http.Response response = await http.post(
        uri,
        headers: headers,
        body: map,
      );
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> logout() async {
    Map<String, String> headers = await HttpUtil.getHeader();

    http.Response response;
    try {
      Uri uri = ConstApp.uri('/auth/logout');
      response = await http.post(
        uri,
        headers: headers,
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
