import 'dart:convert';

import 'package:hero/http/core/httpbase.dart';
import 'package:hero/model/lokasi/outlet.dart';
import 'package:http/http.dart' as http;

class HttpOutlet extends HttpBase {
  Future<List<ItemComboJenisOutlet>?> comboJenisOutlet() async {
    Map<String, String> headers = await getHeader();
    Uri uri = configuration.uri('/combobox/outlet_jenis');
    try {
      http.Response response = await http.get(uri, headers: headers);

      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        return _olahComboJenisOutlet(json.decode(response.body));
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<dynamic>?> detailOutlet(String? idoutlet) async {
    Map<String, String> headers = await getHeader();
    Uri uri = configuration.uri('/lokasi/tampil/OUT/$idoutlet');
    try {
      http.Response response = await http.get(uri, headers: headers);

      // print(response.body);
      return json.decode(response.body);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Map<String, dynamic>?> createOutlet(Outlet outlet) async {
    Map<String, String> headers = await getHeader();
    //  Outlet o = dummyWajib();
    print(jsonEncode(outlet.toJson()));
    Uri uri = configuration.uri('/lokasi/outlet_create');
    http.Response? response;
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(outlet.toJson()),
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

  Future<Map<String, dynamic>?> updateOutlet(Outlet outlet) async {
    Map<String, String> headers = await getHeader();
    print(outlet.toJson());
    Uri uri = configuration.uri('/lokasi/outlet_update/${outlet.idoutlet}');
    http.Response? response;
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(outlet.toJson()),
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

  List<ItemComboJenisOutlet>? _olahComboJenisOutlet(dynamic value) {
    List<ItemComboJenisOutlet> result = [];
    try {
      List<dynamic> ld = value;
      if (ld.length > 0) {
        for (int i = 0; i < ld.length; i++) {
          Map<String, dynamic> map = ld[i];
          ItemComboJenisOutlet itemComboJnsOutlet =
              ItemComboJenisOutlet.fromJson(map);
          result.add(itemComboJnsOutlet);
        }
        return result;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
