import 'dart:convert';

import 'package:hero/http/core/httpbase.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/sf/itemsearchoutlet.dart';
import 'package:hero/modulapp/blocpagetabsf.dart';
import 'package:hero/util/dateutil.dart';
import 'package:http/http.dart' as http;

import '../configuration.dart';

class Httphpsearchsf extends HttpBase {
  /// dtstart dab dtfinish tidak boleh null
  Future<UIPageTabSf?> getDaftarOutlet(
      EnumTab enumTab, DateTime? dtstar, DateTime? dtfinish, int page) async {
    String starDt = DateUtility.dateToStringParam(dtstar);
    String finishDt = DateUtility.dateToStringParam(dtfinish);
    String url = '';
    switch (enumTab) {
      case EnumTab.distribution:
        url = 'bottommenudistribusi/distribusi_list';
        break;
      case EnumTab.merchandising:
        url = 'bottommenumerchandising/merchandising_list';
        break;
      case EnumTab.promotion:
        url = 'bottommenupromotion/promotion_list';
        break;
      case EnumTab.marketaudit:
        url = 'bottommenumarketaudit/marketaudit_list';
        break;
      // case EnumTab.mt:
      // ignore: todo
      //   // TODO: Handle this case.
      //   break;
      default:
    }
    Uri uri = configuration.uri('/$url/$starDt/$finishDt/$page');
    try {
      final Map<String, String> headers = await getHeader();
      final response = await http.get(uri, headers: headers);
      ph(response.statusCode);
      ph(response.body);
      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        return _olahDaftarOutlet(value);
      }
      return null;
    } catch (e) {
      ph(e.toString());
      return null;
    }
  }

  Future<List<LokasiSearch>?> cariOutlet(EnumTab enumTab, DateTime? tglAwal,
      DateTime? tglAkhir, String query) async {
    String starDt = DateUtility.dateToStringYYYYMMDD(tglAwal);
    String finishDt = DateUtility.dateToStringYYYYMMDD(tglAkhir);
    Map<String, String> headers = await getHeader();

    String url = '';
    switch (enumTab) {
      case EnumTab.distribution:
        url = 'bottommenudistribusi/distribusi_list_cari';
        break;
      case EnumTab.merchandising:
        url = 'bottommenumerchandising/merchandising_list_cari';
        break;
      case EnumTab.promotion:
        url = 'bottommenupromotion/promotion_list_cari';
        break;
      case EnumTab.marketaudit:
        url = 'bottommenumarketaudit/marketaudit_list_cari';
        break;
      // case EnumTab.mt:
      // ignore: todo
      //   // TODO: Handle this case.
      //   break;
      default:
    }

    Map map = {"tglawal": starDt, "tglakhir": finishDt, "cari": query};
    Uri uri = configuration.uri('/$url');
    http.Response? response;
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );
      ph(response.statusCode);
      ph(response.body);
      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        return _olahDaftarOutletquery(value);
      } else {
        return null;
      }
    } catch (e) {
      ph(e);
      ph(response?.body);
      return null;
    }
  }

  // {
  // "status": 201,
  // "total": 5,
  // "limit_per_halaman": 50,
  // "data": [
  // {
  // "no_nota": "SSF045L-23",
  // "tgl_transaksi": "2020-12-20",
  // "id_digipos": "1300024051",
  // "nama_outlet": "RORIANTI CELL"
  // }
  // ]
  // }
  //
  UIPageTabSf? _olahDaftarOutlet(dynamic value) {
    UIPageTabSf uiPageTabSf = UIPageTabSf();

    List<LokasiSearch> loutlet = [];

    try {
      Map<String, dynamic> map = value;
      uiPageTabSf.total = map['total'];
      uiPageTabSf.maxrecordperhit = map['limit_per_halaman'];

      List<dynamic> ld = map['data'];
      if (ld.length > 0) {
        for (int i = 0; i < ld.length; i++) {
          Map<String, dynamic> map = ld[i];
          LokasiSearch retur = LokasiSearch.fromJson(map);

          loutlet.add(retur);
        }
      }

      uiPageTabSf.loutlet = loutlet;
      return uiPageTabSf;
    } catch (e) {
      return null;
    }
  }
  //
  // [
  // {
  // "no_nota": "SSF045L-23",
  // "tgl_transaksi": "2020-12-20",
  // "id_digipos": "1300024051",
  // "nama_outlet": "RORIANTI CELL"
  // },
  // {
  // "no_nota": "SSF045K-24",
  // "tgl_transaksi": "2020-12-20",
  // "id_digipos": "1300024051",
  // "nama_outlet": "RORIANTI CELL"
  // }
  // ]

  List<LokasiSearch> _olahDaftarOutletquery(dynamic value) {
    List<LokasiSearch> loutlet = [];

    try {
      List<dynamic> ld = value;

      if (ld.length > 0) {
        for (int i = 0; i < ld.length; i++) {
          Map<String, dynamic> map = ld[i];
          LokasiSearch retur = LokasiSearch.fromJson(map);
          loutlet.add(retur);
        }
      }

      return loutlet;
    } catch (e) {
      return loutlet;
    }
  }
}
