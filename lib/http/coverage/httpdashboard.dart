import 'dart:convert';

import 'package:hero/core/log/printlog.dart';
import 'package:hero/http/core/httpbase.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/menu.dart';
import 'package:hero/model/pjp.dart';
import 'package:hero/core/domain/entities/tgzlocation.dart';
import 'package:hero/util/constapp/accountcontroller.dart';
import 'package:hero/util/numberconverter.dart';
import 'package:http/http.dart' as http;

class HttpDashboard extends HttpBase {
  Future<List<Pjp>?> getPjpHariIni() async {
    Uri uri = configuration.uri('/location/pjp_daftar');
    try {
      final Map<String, String> headers = await getHeader();
      final response = await http
          .get(uri, headers: headers)
          .timeout(const Duration(seconds: 20));
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

  // "id_tempat" : "3857",
  // "id_jenis_lokasi" : "OUT",
  // "status" : "OPEN"

  Future<String?> clockin(Pjp pjp, EnumStatusTempat enumStatusTempat) async {
    Map<String, String> headers = await getHeader();
    String status = 'CLOSE';
    if (enumStatusTempat == EnumStatusTempat.open) {
      status = 'OPEN';
    }

    Map map = {
      "status": status,
      "id_tempat": pjp.id,
      "id_jenis_lokasi": pjp.idjenilokasi,
    };
    ph(map);
    Uri uri = configuration.uri('/clockin/pjp_clockin');
    http.Response? response;
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );
      ph(response.body);
      ph(response.statusCode);
      // "status": 201,
      // "message": "Data has been created.",
      // "id_history_pjp": "27"

      Map<String, dynamic> value = json.decode(response.body);
      return value['id_history_pjp'];
    } catch (e) {
      ph(e);
      ph(response?.body);
      return null;
    }
  }

  Future<bool> trackingSales(
      String sales, TgzLocationData? userLocation, String dateString) async {
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

    final Map<String, String> headers = await getHeader();
    Map param;
    if (userLocation == null) {
      param = {
        "id_sales": sales,
        "longitude": '',
        "latitude": '',
        "waktu_user": '$dateString'
      };
    } else {
      param = {
        "id_sales": sales,
        "longitude": '${userLocation.longitude}',
        "latitude": '${userLocation.latitude}',
        "waktu_user": '$dateString'
      };
    }

    Uri uri = configuration.uri('/tracking/tracking_pjp');
    http.Response? response;
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(param),
      );
      //   ph("tracking sales : ${response.body}");
      //   ph("tracking sales : ${response.statusCode}");
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // ph(e);
      // ph(response?.body);
      return false;
    }
  }

  Future<Menu?> getMenu() async {
    Map<String, String> headers = await getHeader();
    String? idhistoryPjp = await AccountHore.getIdHistoryPjp();
    Map map = {"id_history_pjp": idhistoryPjp};
    ph("ID HISTORY: $idhistoryPjp");
    Uri uri = configuration.uri('/clockinmenu/pjp_clockin_menu_status');
    http.Response? response;
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );
      ph(response.body);
      ph(response.statusCode);
      if (response.statusCode == 200) {
        //  "status": "OPEN",
        //  "clockin_distribusi": "ENABLED",
        //  "clockin_merchandising": "ENABLED",
        //  "clockin_promotion": "ENABLED",
        //  "clockin_marketaudit": "ENABLED",
        //  "clockin_report_mt": "ENABLED"

        List<dynamic> ld = json.decode(response.body);
        if (ld.isNotEmpty) {
          Map<String, dynamic> mvalue = ld[0];
          return Menu.fromJson(mvalue);
        }
        return null;
      } else {
        return null;
      }
    } catch (e) {
      ph(e);
      ph(response?.body);
      return null;
    }
  }

  // DISTRIBUTION
  // MERCHANDISING
  // PROMOTION
  // MARKET AUDIT
  // REPORT MT

  Future<bool> startMenu(EnumTab enumTab) async {
    Map<String, String> headers = await getHeader();
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
      case EnumTab.marketaudit:
        keyTag = 'MARKET AUDIT';
        break;
      case EnumTab.mt:
        keyTag = 'REPORT MT';
        break;
    }
    Map map = {"menu_clockin": keyTag, "id_history_pjp": idhistoryPjp};
    Uri uri = configuration.uri('/clockinmenu/pjp_clockin_menu_start');
    http.Response? response;
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );
      ph(response.body);
      ph(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      ph(e);
      ph(response?.body);
      return false;
    }
  }

  Future<FinishMenu> finishMenu(EnumTab enumTab) async {
    /// saat finish delete directory untuk menghapus semua photo dan video
    // TgzFile tgzFile = TgzFile();
    // bool hasildelete = await tgzFile.deleteDirectory();
    // if (hasildelete) {
    //   ph('delete directory berhasil');
    // } else {
    //   ph('delete directory tidak berhasil');
    // }

    Map<String, String> headers = await getHeader();
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
      case EnumTab.marketaudit:
        keyTag = 'MARKET AUDIT';
        break;
      case EnumTab.mt:
        keyTag = 'REPORT MT';
        break;
    }
    Map map = {"menu_clockin": keyTag, "id_history_pjp": idhistoryPjp};
    ph("liat map: $map");
    http.Response? response;
    Uri uri = configuration.uri('/clockinmenu/pjp_clockin_menu_finish');
    FinishMenu finishMenu = FinishMenu(false, null);
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );
      ph('=======================');
      ph(response.body);
      ph(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        int? i = ConverterNumber.stringToIntOrZero(map['status']);
        String? message = map['message'];
        finishMenu.message = message;
        ph(i);
        if (i == 1) {
          finishMenu.issuccess = true;
          return finishMenu;
        }
      }
      return finishMenu;
    } catch (e) {
      ph(e);
      ph(response?.body);

      return finishMenu;
    }
  }

  Future<bool> clockout() async {
    Map<String, String> headers = await getHeader();
    String? idhistorypjp = await AccountHore.getIdHistoryPjp();

    Map map = {"id_history_pjp": idhistorypjp};
    ph(jsonEncode(map));

    Uri uri = configuration.uri('/clockout/pjp_clockout');
    http.Response? response;
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );
      ph('cloclout: ${response.contentLength}');
      ph('cloclout: ${response.body}');
      ph('cloclout SC: ${response.statusCode}');
      if (response.statusCode == 200) {
        Map<String, dynamic>? map = json.decode(response.body);
        _olahCreateSuccess(map);
        return true;
      }
      return false;
    } catch (e) {
      ph('error $e');
      ph(response?.body);
      return false;
    }
  }

  bool _olahCreateSuccess(dynamic value) {
    try {
      Map<String, dynamic> map = value;
      if (map['status'] is String) {
        int? i = int.tryParse(map['status']);
        ph('nilai status berapa $i');
        if (i == 1) {
          return true;
        }
      } else if (map['status'] is int) {
        if (map['status'] == 1) {
          return true;
        }
      }

      return false;
    } catch (e) {
      ph(e.toString());
      return false;
    }
  }

  Future<EnumStatusClockIn?> checkStatusClockIn(String idpjp) async {
    ph("IDPJP CHECK: $idpjp");
    Map<String, String> headers = await getHeader();
    //  String? idhistoryPjp = await AccountHore.getIdHistoryPjp();
    Map map = {"id_history_pjp": idpjp};

    Uri uri = configuration.uri('/clockin/pjp_clockin_status');
    http.Response? response;
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );
      ph(response.body);
      ph(response.statusCode);
      if (response.statusCode == 200) {
        //  {
        //  "status":"0"
        //  "message": "0:belum clockin,1:OPEN,2:Close",
        //  }"

        Map<String, dynamic>? ld = json.decode(response.body);
        if (ld != null) {
          if (ld["status"] != null) {
            String status = ld["status"];
            //ph(status == "2");
            if (status == "0") {
              return EnumStatusClockIn.belum;
            } else if (status == "1") {
              return EnumStatusClockIn.open;
            } else if (status == "2") {
              return EnumStatusClockIn.close;
            }
          }
        }
        return null;
      } else {
        return null;
      }
    } catch (e) {
      ph(e);
      ph(response?.body);
      return null;
    }
  }

  List<Pjp> _olahDaftarPjp(dynamic value) {
    List<Pjp> lpjp = [];

    try {
      List<dynamic> ld = value;

      if (ld.isNotEmpty) {
        for (int i = 0; i < ld.length; i++) {
          Map<String, dynamic> map = ld[i];

          Pjp pjp = Pjp.fromJson(map);

          ph('nama: ${pjp.idjenilokasi}');
          lpjp.add(pjp);
        }
        lpjp.sort((a, b) => a.nokunjungan!.compareTo(b.nokunjungan!));
        // lpjp.forEach((element) {
        //   ph(element.nokunjungan);
        // });
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
