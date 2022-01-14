import 'dart:convert';
import 'dart:io';

import 'package:hero/modulapp/coverage/marketaudit/sf/blocsurvey.dart';
import 'package:hero/modulapp/coverage/merchandising/blocmerchandising.dart';
import 'package:hero/util/constapp/accountcontroller.dart';
import 'package:hero/util/constapp/constapp.dart';
import 'package:hero/util/dateutil.dart';
import 'package:hero/util/numberconverter.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../httputil.dart';

class HttpMarketAuditSF {
  Future<bool> createSurvey(Map<String, dynamic> map) async {
    Map<String, String> headers = await HttpUtil.getHeader();
    print(jsonEncode(map));
    Uri uri = ConstApp.uri(
        '/clockinmarketaudit/marketaudit_create_broadband_voucher');
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

  // --form 'id_history_pjp="35"' \
  // --form 'id_jenis_share="BELANJA"' \
  // --form 'telkomsel="1"' \
  // --form 'isat="2"' \
  // --form 'xl="3"' \
  // --form 'tri="4"' \
  // --form 'smartfren="5"' \
  // --form 'axis="6"' \
  // --form 'other="7"' \
  // --form 'myfile1=@"/Users/nofyanugrahputri/Desktop/sa.jpeg"'

  Future<bool> createSurveyBelanja(Map<String, dynamic> map) async {
    Map<String, String> headers = await HttpUtil.getHeader();
    String? idhitory = await AccountHore.getIdHistoryPjp();
    String path1 = map['path'];
    // Map<String, dynamic> mp = {
    //   "id_outlet": _cacheuisurvey.pjp.id,
    //   "id_jenis_share": "BELANJA",
    //   "telkomsel": _cacheuisurvey.telkomsel,
    //   "isat": _cacheuisurvey.isat,
    //   "xl": _cacheuisurvey.xl,
    //   "tri": _cacheuisurvey.tri,
    //   "smartfren": _cacheuisurvey.sf,
    //   "axis": _cacheuisurvey.axis,
    //   "other": _cacheuisurvey.other,
    //   "path":""
    // };
    ///===================================
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '${ConstApp.domain}/clockinmarketaudit/marketaudit_create_belanja'));
    request.headers.addAll(headers);
    request.fields['id_history_pjp'] = idhitory!;
    request.fields['id_jenis_share'] = map['id_jenis_share'];
    request.fields['telkomsel'] = '${map['telkomsel']}';
    request.fields['isat'] = '${map['isat']}';
    request.fields['xl'] = '${map['xl']}';
    request.fields['tri'] = '${map['tri']}';
    request.fields['smartfren'] = '${map['smartfren']}';
    request.fields['axis'] = '${map['axis']}';
    request.fields['other'] = '${map['other']}';

    request.files.add(http.MultipartFile.fromBytes(
      'myfile1', File(path1).readAsBytesSync(),
      filename: path1.split("/").last,
      contentType: MediaType('application', 'jpeg'),
      //      filename: 'myfile1'),
    ));

    var res = await request.send();
    var response = await http.Response.fromStream(res);
    print('idhistory:$idhitory');

    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<UISurvey?> getDetailMarketAuditSF(
      EnumSurvey enumSurvey, String? idoutlet, DateTime? tgl) async {
    String idshare = '';
    // BELANJA
    // SALES_BROADBAND
    // VOUCHER_FISIK

    switch (enumSurvey) {
      case EnumSurvey.belanja:
        idshare = 'BELANJA';
        break;
      case EnumSurvey.broadband:
        idshare = 'SALES_BROADBAND';
        break;
      case EnumSurvey.fisik:
        idshare = 'VOUCHER_FISIK';
        break;
    }
    String strDt = DateUtility.dateToStringParam(tgl);
    Uri uri = ConstApp.uri(
        '/bottommenumarketaudit/marketaudit_detail/$idshare/$idoutlet/$strDt');
    try {
      final Map<String, String> headers = await HttpUtil.getHeader();
      final response = await http.get(uri, headers: headers);
      print("$idshare : ${response.body}");
      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        if (enumSurvey == EnumSurvey.belanja) {
          return _olahDetailSurveyBelanja(value);
        } else {
          return _olahDetailSurvey(value, enumSurvey);
        }
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  UISurvey? _olahDetailSurvey(dynamic value, EnumSurvey enumSurvey) {
    UISurvey? item;
    List<ItemSurveyVoucher> lsurvey = [];
    Map<String, dynamic> mp = value;
    if (mp['data'] != null) {
      List<dynamic> ld = mp['data'];
      print('ld.length: ${ld.length}');
      if (ld.isEmpty) {
        return null;
      }
      Map<String, dynamic> map = ld[0];
      ItemSurveyVoucher p = ItemSurveyVoucher(EnumOperator.telkomsel);
      p.ld = ConverterNumber.stringToInt(map['telkomsel_ld']);
      p.md = ConverterNumber.stringToInt(map['telkomsel_md']);
      p.hd = ConverterNumber.stringToInt(map['telkomsel_hd']);
      lsurvey.add(p);

      ItemSurveyVoucher p1 = ItemSurveyVoucher(EnumOperator.isat);
      p1.ld = ConverterNumber.stringToInt(map['isat_ld']);
      p1.md = ConverterNumber.stringToInt(map['isat_md']);
      p1.hd = ConverterNumber.stringToInt(map['isat_hd']);
      lsurvey.add(p1);

      ItemSurveyVoucher p2 = ItemSurveyVoucher(EnumOperator.xl);
      p2.ld = ConverterNumber.stringToInt(map['xl_ld']);
      p2.md = ConverterNumber.stringToInt(map['xl_md']);
      p2.hd = ConverterNumber.stringToInt(map['xl_hd']);
      lsurvey.add(p2);

      ItemSurveyVoucher p3 = ItemSurveyVoucher(EnumOperator.tri);
      p3.ld = ConverterNumber.stringToInt(map['tri_ld']);
      p3.md = ConverterNumber.stringToInt(map['tri_md']);
      p3.hd = ConverterNumber.stringToInt(map['tri_hd']);
      lsurvey.add(p3);

      ItemSurveyVoucher p4 = ItemSurveyVoucher(EnumOperator.sf);
      p4.ld = ConverterNumber.stringToInt(map['smartfren_ld']);
      p4.md = ConverterNumber.stringToInt(map['smartfren_ld']);
      p4.hd = ConverterNumber.stringToInt(map['smartfren_ld']);
      lsurvey.add(p4);

      ItemSurveyVoucher p5 = ItemSurveyVoucher(EnumOperator.axis);
      p5.ld = ConverterNumber.stringToInt(map['axis_ld']);
      p5.md = ConverterNumber.stringToInt(map['axis_md']);
      p5.hd = ConverterNumber.stringToInt(map['axis_hd']);
      lsurvey.add(p5);

      ItemSurveyVoucher p6 = ItemSurveyVoucher(EnumOperator.other);
      p6.ld = ConverterNumber.stringToInt(map['other_ld']);
      p6.md = ConverterNumber.stringToInt(map['other_md']);
      p6.hd = ConverterNumber.stringToInt(map['other_hd']);
      lsurvey.add(p6);

      if (lsurvey.isNotEmpty) {
        item = UISurvey();
        if (enumSurvey == EnumSurvey.broadband) {
          item.lsurveyBroadband = lsurvey;
        } else {
          item.lsurveyFisik = lsurvey;
        }
      }
    }
    return item;
  }

  UISurvey? _olahDetailSurveyBelanja(dynamic value) {
    UISurvey? item;
    Map<String, dynamic> mp = value;
    if (mp['data'] != null) {
      List<dynamic> ld = mp['data'];
      if (ld.isEmpty) {
        return null;
      } else {
        item = UISurvey();
        for (int i = 0; i < ld.length; i++) {
          Map<String, dynamic> map = ld[i];
          item.telkomsel = ConverterNumber.stringToInt(map['telkomsel']);
          item.isat = ConverterNumber.stringToInt(map['isat']);
          item.xl = ConverterNumber.stringToInt(map['xl']);
          item.tri = ConverterNumber.stringToInt(map['tri']);
          item.axis = ConverterNumber.stringToInt(map['axis']);
          item.other = ConverterNumber.stringToInt(map['other']);
          item.sf = ConverterNumber.stringToInt(map['smartfren']);
          item.pathphotobelanja = map['foto_belanja'];
        }
      }
    }
    return item;
  }
}
