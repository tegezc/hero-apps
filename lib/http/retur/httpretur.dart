import 'dart:convert';

import 'package:hero/model/retur.dart';
import 'package:hero/model/serialnumber.dart';
import 'package:hero/util/constapp/constapp.dart';
import 'package:hero/util/dateutil.dart';
import 'package:http/http.dart' as http;

import '../httputil.dart';

class HttpRetur {
  Future<List<AlasanRetur>?> comboAlasanRetur() async {
    try {
      final Map<String, String> headers = await HttpUtil.getHeader();
      Uri uri = ConstApp.uri('/combobox/retur_alasan');
      final response = await http.get(uri, headers: headers);
      print(response.statusCode);
      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        return this._olahDaftarAlasan(value);
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  /// dtstart dab dtfinish tidak boleh null
  Future<List<Retur>?> getRetur(
      DateTime? dtstar, DateTime? dtfinish, int? page) async {
    String starDt = DateUtility.dateToStringParam(dtstar);
    String finishDt = DateUtility.dateToStringParam(dtfinish);
    try {
      final Map<String, String> headers = await HttpUtil.getHeader();
      Uri uri = ConstApp.uri('/lokasi/retur_list/$starDt/$finishDt/$page');
      final response = await http.get(uri, headers: headers);
      print(response.statusCode);
      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        return this._olahDaftarRetur(value);
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<Retur>?> cariRetur(
      DateTime? tglAwal, DateTime? tglAkhir, String serial) async {
    String starDt = DateUtility.dateToStringYYYYMMDD(tglAwal);
    String finishDt = DateUtility.dateToStringYYYYMMDD(tglAkhir);
    Map<String, String> headers = await HttpUtil.getHeader();
    //  Outlet o = dummyWajib();
    Map map = {
      "tglawal": starDt,
      "tglakhir": finishDt,
      "serial_number": serial
    };
    Uri uri = ConstApp.uri('/lokasi/retur_list_sn');
    http.Response? response;
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        return this._olahDaftarRetur(value);
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

  Future<List<SerialNumber>?> getSerialnumberByRange(
      String serialawal, String serialakhir) async {
    Map<String, String> headers = await HttpUtil.getHeader();
    //  Outlet o = dummyWajib();
    // "sn_awal" : "9000011113",
    // "sn_akhir" : "9000011121"

    Map map = {"sn_awal": serialawal, "sn_akhir": serialakhir};
    Uri uri = ConstApp.uri('/lokasi/retur_sn');
    http.Response? response;
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        print(response.body);
        return _olahDaftarSn(json.decode(response.body));
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

  Future<bool> submitRetur(List<SerialNumber> lsn, String alasan) async {
    Map<String, String> headers = await HttpUtil.getHeader();

    List<Map> lmap = [];
    lsn.forEach((element) {
      lmap.add(element.toJson());
    });
    Map map = {"alasan": alasan, "data": lmap};
    Uri uri = ConstApp.uri('/lokasi/retur_submit');
    http.Response? response;
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      print(response?.body);
      return false;
    }
  }

  List<Retur> _olahDaftarRetur(dynamic value) {
    List<Retur> lretur = [];

    try {
      List<dynamic> ld = value;

      if (ld.length > 0) {
        for (int i = 0; i < ld.length; i++) {
          Map<String, dynamic> map = ld[i];
          Retur retur = Retur.fromJson(map);
          lretur.add(retur);
        }
      }
      return lretur;
    } catch (e) {
      return lretur;
    }
  }

  List<SerialNumber> _olahDaftarSn(dynamic value) {
    List<SerialNumber> lsn = [];

    try {
      List<dynamic> ld = value;

      if (ld.length > 0) {
        for (int i = 0; i < ld.length; i++) {
          Map<String, dynamic> map = ld[i];
          SerialNumber serialNumber = SerialNumber.fromJson(map);
          lsn.add(serialNumber);
        }
      }
      return lsn;
    } catch (e) {
      return lsn;
    }
  }

  List<AlasanRetur> _olahDaftarAlasan(dynamic value) {
    List<AlasanRetur> lsn = [];

    try {
      List<dynamic> ld = value;

      if (ld.length > 0) {
        for (int i = 0; i < ld.length; i++) {
          Map<String, dynamic> map = ld[i];
          AlasanRetur alasanretur = AlasanRetur.fromJson(map);
          if (alasanretur.isvalid()) {
            lsn.add(alasanretur);
          }
        }
      }
      return lsn;
    } catch (e) {
      return lsn;
    }
  }
}
