import 'dart:convert';

import 'package:hero/http/core/httpbase.dart';
import 'package:hero/model/pjp.dart';
import 'package:hero/util/numberconverter.dart';
import 'package:http/http.dart' as http;

import '../../../configuration.dart';

class HttpPjp extends HttpBase {
  Future<List<Pjp>?> getHistoryPJP(
      String key, String? idlokasi, int? page) async {
    Uri uri =
        configuration.uri('/location/tampil_history_pjp/$key/$idlokasi/$page');
    try {
      final Map<String, String> headers = await getHeader();
      final response = await http.get(uri, headers: headers);
      ph(response.statusCode);
      ph(response.body);
      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        return _olahDaftarPjp(value);
      }
      return null;
    } catch (e) {
      ph(e.toString());
      return null;
    }
  }

  Future<int?> getJmlHistoryPjp(String? idlokasi, String key) async {
    Uri uri = configuration.uri('/location/jumlah_history_pjp/$key/$idlokasi');
    try {
      final Map<String, String> headers = await getHeader();
      final response = await http.get(uri, headers: headers);
      ph(response.statusCode);
      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        return _olahJumlahHistoryPjp(value);
      }
      return 0;
    } catch (e) {
      ph(e.toString());
      return 0;
    }
  }

  List<Pjp> _olahDaftarPjp(dynamic value) {
    List<Pjp> lpjp = [];

    try {
      List<dynamic> ld = value;

      if (ld.isNotEmpty) {
        for (int i = 0; i < ld.length; i++) {
          Map<String, dynamic> map = ld[i];

          Pjp pjp = Pjp.fromJsonHistory(map);

          ph('nama: ${pjp.tempat!.nama}');
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

      if (ld.isNotEmpty) {
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
