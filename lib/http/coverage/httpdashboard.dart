import 'dart:convert';

import 'package:hero/model/enumapp.dart';
import 'package:hero/model/menu.dart';
import 'package:hero/model/pjp.dart';
import 'package:hero/model/tgzlocation.dart';
import 'package:hero/util/constapp/accountcontroller.dart';
import 'package:hero/util/constapp/constapp.dart';
import 'package:hero/util/numberconverter.dart';
import 'package:hero/util/tgzfile.dart';
import 'package:http/http.dart' as http;

import '../httputil.dart';

class HttpDashboard {
  Future<List<Pjp>?> getPjpHariIni() async {
    Uri uri = ConstApp.uri('/lokasi/pjp_daftar');
    try {
      final Map<String, String> headers = await HttpUtil.getHeader();
      final response = await http.get(uri, headers: headers);
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

  // "id_tempat" : "3857",
  // "id_jenis_lokasi" : "OUT",
  // "status" : "OPEN"

  Future<String?> clockin(Pjp pjp, EnumStatusTempat enumStatusTempat) async {
    Map<String, String> headers = await HttpUtil.getHeader();
    String status = 'CLOSE';
    if (enumStatusTempat == EnumStatusTempat.open) {
      status = 'OPEN';
    }

    Map map = {
      "status": status,
      "id_tempat": pjp.id,
      "id_jenis_lokasi": pjp.idjenilokasi,
    };

    Uri uri = ConstApp.uri('/clockin/pjp_clockin');
    http.Response? response;
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );
      print(response.body);
      print(response.statusCode);
        // "status": 201,
        // "message": "Data has been created.",
        // "id_history_pjp": "27"

        Map<String, dynamic> value = json.decode(response.body);
        return value['id_history_pjp'];
      
    } catch (e) {
      print(e);
      print(response?.body);
      return null;
    }
  }

  Future<bool> trackingSales(String sales,TgzLocation userLocation) async {
    // Map<String, String> headers = {
    //   'Auth-Key': 'restapihore',
    //   'Client-Service': 'frontendclienthore',
    //   'User-ID': '${map['User-ID']}',
    //   'Auth-session': '${map['Auth-session']}',
    //   'Id-Level': '${map['Id-Level']}',
    //   'Nama-Sales': '${map['Nama-Sales']}',
    //   'Id-Tap': '${map['Id-Tap']}',
    //   'Nama-Tap': '${map['Nama-Tap']}',
    //   'Id-Cluster': '${map['Id-Cluster']}',
    //   'Nama-Cluster': '${map['Nama-Cluster']}',
    // };
    // Position userLocation = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);

    final Map<String, String> headers = await HttpUtil.getHeader();

    Map param = {
      "id_sales": "${sales}",
      "longitude": "${userLocation.longitute}",
      "latitude": "${userLocation.latitute}"
    };
    Uri uri = ConstApp.uri('/tracking/tracking_pjp');
    http.Response? response;
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(param),
      );
      print("tracking sales : ${response.body}");
      print("tracking sales : ${response.statusCode}");
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

  Future<Menu?> getMenu() async {
    Map<String, String> headers = await HttpUtil.getHeader();
    String? idhistoryPjp = await AccountHore.getIdHistoryPjp();
    Map map = {"id_history_pjp": idhistoryPjp};

    Uri uri = ConstApp.uri('/clockinmenu/pjp_clockin_menu_status');
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
        //  "status": "OPEN",
        //  "clockin_distribusi": "ENABLED",
        //  "clockin_merchandising": "ENABLED",
        //  "clockin_promotion": "ENABLED",
        //  "clockin_marketaudit": "ENABLED",
        //  "clockin_report_mt": "ENABLED"

        List<dynamic> ld = json.decode(response.body);
        if (ld.length > 0) {
          Map<String, dynamic> mvalue = ld[0];
          return Menu.fromJson(mvalue);
        }
        return null;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      print(response?.body);
      return null;
    }
  }

  // DISTRIBUTION
  // MERCHANDISING
  // PROMOTION
  // MARKET AUDIT
  // REPORT MT

  Future<bool> startMenu(EnumTab enumTab) async {
    Map<String, String> headers = await HttpUtil.getHeader();
    String? idhistoryPjp = await AccountHore.getIdHistoryPjp();
    String keyTag = '';
    switch (enumTab) {
      case EnumTab.distribution:
        keyTag = 'DISTRIBUTION';
        break;
      case EnumTab.merchandising:
        keyTag = 'MERCHANDISING';
        break;
      case EnumTab.promotion:
        keyTag = 'PROMOTION';
        break;
      case EnumTab.survey:
        keyTag = 'MARKET AUDIT';
        break;
      case EnumTab.mt:
        keyTag = 'REPORT MT';
        break;
    }
    Map map = {"menu_clockin": keyTag, "id_history_pjp": idhistoryPjp};
    Uri uri = ConstApp.uri('/clockinmenu/pjp_clockin_menu_start');
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
      }
      return false;
    } catch (e) {
      print(e);
      print(response?.body);
      return false;
    }
  }

  Future<FinishMenu> finishMenu(EnumTab enumTab) async {
    /// saat finish delete directory untuk menghapus semua photo dan video
    TgzFile tgzFile = TgzFile();
    bool hasildelete = await tgzFile.deleteDirectory();
    if (hasildelete) {
      print('delete directory berhasil');
    } else {
      print('delete directory tidak berhasil');
    }

    Map<String, String> headers = await HttpUtil.getHeader();
    String? idhistoryPjp = await AccountHore.getIdHistoryPjp();
    String keyTag = '';
    switch (enumTab) {
      case EnumTab.distribution:
        keyTag = 'DISTRIBUTION';
        break;
      case EnumTab.merchandising:
        keyTag = 'MERCHANDISING';
        break;
      case EnumTab.promotion:
        keyTag = 'PROMOTION';
        break;
      case EnumTab.survey:
        keyTag = 'MARKET AUDIT';
        break;
      case EnumTab.mt:
        keyTag = 'REPORT MT';
        break;
    }
    Map map = {"menu_clockin": keyTag, "id_history_pjp": idhistoryPjp};
    print("liat map: $map");
    http.Response? response;
    Uri uri = ConstApp.uri('/clockinmenu/pjp_clockin_menu_finish');
    FinishMenu finishMenu = FinishMenu(false, null);
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );
      print('=======================');
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        int? i = ConverterNumber.stringToInt(map['status']);
        String? message = map['message'];
        finishMenu.message = message;
        print(i);
        if (i == 1) {
          finishMenu.issuccess = true;
          return finishMenu;
        }
      }
      return finishMenu;
    } catch (e) {
      print(e);
      print(response?.body);

      return finishMenu;
    }
  }

  Future<bool> clockout() async {
    Map<String, String> headers = await HttpUtil.getHeader();
    String? idhistorypjp = await AccountHore.getIdHistoryPjp();

    Map map = {"id_history_pjp": idhistorypjp};
    print(jsonEncode(map));

    Uri uri = ConstApp.uri('/clockout/pjp_clockout');
    http.Response? response;
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );
      print('cloclout: ${response.contentLength}');
      print('cloclout: ${response.body}');
      print('cloclout SC: ${response.statusCode}');
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        int? i = ConverterNumber.stringToInt(map['status']);
        print(i);
        // if (i == 1) {
          return true;
        // }
      }
      return false;
    } catch (e) {
      print('error $e');
      print(response?.body);
      return false;
    }
  }

  List<Pjp> _olahDaftarPjp(dynamic value) {
    List<Pjp> lpjp = [];

    try {
      List<dynamic> ld = value;

      if (ld.length > 0) {
        for (int i = 0; i < ld.length; i++) {
          Map<String, dynamic> map = ld[i];

          Pjp pjp = Pjp.fromJson(map);

          print('nama: ${pjp.idjenilokasi}');
          lpjp.add(pjp);
        }
        lpjp.sort((a, b) => a.nokunjungan!.compareTo(b.nokunjungan!));
        lpjp.forEach((element) {
          print(element.nokunjungan);
        });
      }
      return lpjp;
    } catch (e) {
      return lpjp;
    }
  }
}

class FinishMenu {
  bool issuccess;
  String? message;

  FinishMenu(this.issuccess, this.message);
}
