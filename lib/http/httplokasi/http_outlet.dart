import 'dart:convert';

import 'package:hero/core/log/printlog.dart';
import 'package:hero/http/core/httpbase.dart';
import 'package:hero/model/lokasi/outlet.dart';
import 'package:http/http.dart' as http;

import '../../config/configuration_sf.dart';

class HttpOutlet extends HttpBase {
  Future<List<ItemComboJenisOutlet>?> comboJenisOutlet() async {
    Map<String, String> headers = await getHeader();
    Uri uri = configuration.uri('/combobox/outlet_jenis');
    try {
      http.Response response = await http.get(uri, headers: headers);

      ph(response.statusCode);
      ph(response.body);
      if (response.statusCode == 200) {
        return _olahComboJenisOutlet(json.decode(response.body));
      }
      return null;
    } catch (e) {
      ph(e);
      return null;
    }
  }

  Future<List<dynamic>?> detailOutlet(String? idoutlet) async {
    Map<String, String> headers = await getHeader();
    Uri uri = configuration.uri('/location/tampil/OUT/$idoutlet');
    try {
      http.Response response = await http.get(uri, headers: headers);

      // ph(response.body);
      return json.decode(response.body);
    } catch (e) {
      ph(e);
      return null;
    }
  }

  Future<Map<String, dynamic>?> createOutlet(Outlet outlet) async {
    Map<String, String> headers = await getHeader();
    //  Outlet o = dummyWajib();
    ph(jsonEncode(outlet.toJson()));
    Uri uri = configuration.uri('/location/outlet_create');
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

  Future<Map<String, dynamic>?> updateOutlet(Outlet outlet) async {
    Map<String, String> headers = await getHeader();
    ph(outlet.toJson());
    Uri uri = configuration.uri('/location/outlet_update/${outlet.idoutlet}');
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

  List<ItemComboJenisOutlet>? _olahComboJenisOutlet(dynamic value) {
    List<ItemComboJenisOutlet> result = [];
    try {
      List<dynamic> ld = value;
      if (ld.isNotEmpty) {
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
