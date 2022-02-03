import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:hero/core/log/printlog.dart';
import 'package:hero/http/core/httpbase.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/promotion/promotion.dart';
import 'package:hero/util/constapp/accountcontroller.dart';
import 'package:hero/util/dateutil.dart';
import 'package:hero/util/numberconverter.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class HttpPromotion extends HttpBase {
  // Future<bool> createPromotionj(Promotion promotion) async {
  //   Map<String, String> headers = await getHeader();
  //
  //   http.Response? response;
  //   Uri uri = configuration.uri('/clockinpromotion/promotion_create');
  //   try {
  //     response = await http.post(
  //       uri,
  //       headers: headers,
  //       body: jsonEncode(promotion.toJson()),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     return false;
  //   }
  // }

  Future<List<Promotion>?> getDaftarPromotion() async {
    Uri uri = configuration.uri('/clockinpromotion/promotion_jenis');
    try {
      final Map<String, String> headers = await getHeader();
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        return _olahDaftarPromotion(value);
      }
      return null;
    } catch (e) {
      ph(e.toString());
      return null;
    }
  }

  Future<List<Promotion>?> getPromotionFinish() async {
    Map<String, String> headers = await getHeader();
    String? idhistorypjp = await AccountHore.getIdHistoryPjp();
    Map<String, String?> map = {"id_history_pjp": idhistorypjp};
    Uri uri = configuration.uri('/clockinpromotion/promotion_list');
    http.Response? response;
    try {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );

      ph('promotion : ${response.body}');
      ph(response.statusCode);
      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        return _olahDaftarPromotion(value);
      } else {
        return null;
      }
    } catch (e) {
      ph(e);
      ph(response?.body);
      return null;
    }
  }

  Future<List<Promotion>?> getDetailPromotion(
      String? idoutlet, DateTime? tgl, EnumJenisLokasi? enumJenisLokasi) async {
    String strDt = DateUtility.dateToStringParam(tgl);
    String namalokasi = '';
    switch (enumJenisLokasi) {
      case EnumJenisLokasi.outlet:
        namalokasi = 'OUT';
        break;
      case EnumJenisLokasi.poi:
        namalokasi = 'POI';
        break;
      case EnumJenisLokasi.sekolah:
        namalokasi = 'SEK';
        break;
      case EnumJenisLokasi.kampus:
        namalokasi = 'KAM';
        break;
      case EnumJenisLokasi.fakultas:
        namalokasi = 'FAK';
        break;
      default:
        namalokasi = '';
    }

    Uri uri = configuration.uri(
        '/bottommenupromotion/promotion_detail/$idoutlet/$namalokasi/$strDt');
    ph('url detail promotion: ${uri.path}');

    try {
      final Map<String, String> headers = await getHeader();
      final response = await http.get(uri, headers: headers);
      ph(response.body);
      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        return _olahDaftarPromotionDetail(value);
      }
      return null;
    } catch (e) {
      ph(e.toString());
      return null;
    }
  }

  // --form 'id_history_pjp="35"' \
  // --form 'id_jenis_weekly="8"' \
  // --form 'nama_program_lokal="test"' \
  // --form 'myfile1=@"/Users/nofyanugrahputri/Downloads/file_example_MP4_480_1_5MG.mp4"'

  Future<bool> uploadVideo(String filepath, Promotion promotion) async {
    Map<String, String> headers = await getHeader();
    String? idhitory = await AccountHore.getIdHistoryPjp();
    Uint8List file = File(filepath).readAsBytesSync();

    ///===================================
    var request = http.MultipartRequest(
        'POST', configuration.uri('/clockinpromotion/promotion_create'));
    request.headers.addAll(headers);
    request.fields['id_history_pjp'] = idhitory!;
    request.fields['id_jenis_weekly'] = promotion.idjnsweekly!;
    request.fields['nama_program_lokal'] =
        promotion.nmlocal == null ? '' : promotion.nmlocal!;
    request.files.add(http.MultipartFile.fromBytes(
      'myfile1',
      file,
      // filename: filepath.split("/").last,
      contentType: MediaType('video', 'mp4'),
      filename: 'myfile1',
    ));

    try {
      var res = await request.send();
      var response = await http.Response.fromStream(res);

      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        int? i = ConverterNumber.stringToInt(map['status']);
        ph(i);
        if (i == 1) {
          return true;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // {
  // "status": 200,
  // "data": [
  // {
  // "id_promotion": "6",
  // "nama_jenis": "BROADBAND & VAS",
  // "nama_program_lokal": ""
  // }
  // ]
  // }

  List<Promotion> _olahDaftarPromotionDetail(dynamic value) {
    List<Promotion> lp = [];
    Map<String, dynamic> mp = value;
    if (mp['data'] != null) {
      List<dynamic> ld = mp['data'];
      for (int i = 0; i < ld.length; i++) {
        Map<String, dynamic> map = ld[i];
        Promotion p = Promotion.fromJsonDetail(map);
        lp.add(p);
      }
    }
    return lp;
  }

  List<Promotion> _olahDaftarPromotion(dynamic value) {
    List<Promotion> lp = [];
    Map<String, dynamic> mp = value;
    if (mp['data'] != null) {
      List<dynamic> ld = mp['data'];
      for (int i = 0; i < ld.length; i++) {
        Map<String, dynamic> map = ld[i];
        Promotion p = Promotion.fromJson(map);
        lp.add(p);
      }
    }
    return lp;
  }
}
