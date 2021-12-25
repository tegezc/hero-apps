import 'dart:convert';

import 'package:hero/http/httputil.dart';
import 'package:hero/model/pjp.dart';
import 'package:hero/util/constapp/constapp.dart';
import 'package:hero/util/numberconverter.dart';
import 'package:http/http.dart' as http;

class HttpPjp {
  Future<List<Pjp>?> getHistoryPJP(String key, String? idlokasi, int? page) async {
    Uri uri = ConstApp.uri('/lokasi/tampil_history_pjp/$key/$idlokasi/$page');
    try {
      final Map<String, String> headers = await HttpUtil.getHeader();
      final response = await http.get(uri, headers: headers);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        return this._olahDaftarPjp(value);
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<int?> getJmlHistoryPjp(String? idlokasi, String key) async {
    Uri uri = ConstApp.uri('/lokasi/jumlah_history_pjp/$key/$idlokasi');
    try {
      final Map<String, String> headers = await HttpUtil.getHeader();
      final response = await http.get(uri, headers: headers);
      print(response.statusCode);
      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        return this._olahJumlahHistoryPjp(value);
      }
      return 0;
    } catch (e) {
      print(e.toString());
      return 0;
    }
  }

  List<Pjp> _olahDaftarPjp(dynamic value) {
    List<Pjp> lpjp = [];

    try {
      List<dynamic> ld = value;

      if (ld.length > 0) {
        for (int i = 0; i < ld.length; i++) {
          Map<String, dynamic> map = ld[i];

          Pjp pjp = Pjp.fromJsonHistory(map);

          print('nama: ${pjp.tempat!.nama}');
          lpjp.add(pjp);
        }
      }
      return lpjp;
    } catch (e) {
      return lpjp;
    }
  }

  int? _olahJumlahHistoryPjp(dynamic value) {
    try {
      List<dynamic> ld = value;

      if (ld.length > 0) {
        Map<String, dynamic> map = ld[0];

        int? jml = ConverterNumber.stringToInt(map['jumlah']);
        return jml;
      }

      return 0;
    } catch (e) {
      return 0;
    }
  }
}
