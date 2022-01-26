import 'dart:convert';
import 'dart:io';

import 'package:hero/http/core/httpbase.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/merchandising/merchandising.dart';
import 'package:hero/util/constapp/accountcontroller.dart';
import 'package:hero/util/dateutil.dart';
import 'package:hero/util/numberconverter.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../configuration.dart';

class HttpMerchandising extends HttpBase {
  // -form 'id_history_pjp="35"' \
  // --form 'id_jenis_share="SPANDUK"' \
  // --form 'telkomsel="1"' \
  // --form 'isat="2"' \
  // --form 'xl="3"' \
  // --form 'tri="4"' \
  // --form 'smartfren="1"' \
  // --form 'axis="1"' \
  // --form 'other="1"' \
  // --form 'myfile1=@"/Users/nofyanugrahputri/Desktop/sa.jpeg"' \
  // --form 'myfile2=@"/Users/nofyanugrahputri/Desktop/sa.jpeg"' \
  // --form 'myfile3=@"/path/to/file"'

  Future<bool> createMerchadising(Merchandising merchandising) async {
    Map<String, String> headers = await getHeader();
    String? idhitory = await AccountHore.getIdHistoryPjp();
    String? path1 = merchandising.pathPhoto1;
    String? path2 = merchandising.pathPhoto2;
    String? path3 = merchandising.pathPhoto3;
    ph("ID JENIS Share: ${merchandising.idjenisshare}");

    ///===================================
    var request = http.MultipartRequest('POST',
        configuration.uri('/clockinmerchandising/merchandising_create'));
    request.headers.addAll(headers);
    request.fields['id_history_pjp'] = idhitory!;
    request.fields['id_jenis_share'] = merchandising.idjenisshare!;
    request.fields['telkomsel'] = '${merchandising.telkomsel}';
    request.fields['isat'] = '${merchandising.isat}';
    request.fields['xl'] = '${merchandising.xl}';
    request.fields['tri'] = '${merchandising.tri}';
    request.fields['smartfren'] = '${merchandising.sf}';
    request.fields['axis'] = '${merchandising.axis}';
    request.fields['other'] = '${merchandising.other}';

    // request.files.add(http.MultipartFile.fromBytes(
    //   'myfile1', File(path1).readAsBytesSync(),
    //   filename: path1.split("/").last,
    //   contentType: MediaType('application', 'jpeg'),
    //   //      filename: 'myfile1'),
    // ));

    if (path1 != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'myfile1', File(path1).readAsBytesSync(),
        filename: path1.split("/").last,
        contentType: MediaType('application', 'jpeg'),
        //      filename: 'myfile1'),
      ));
    } else {
      request.files.add(http.MultipartFile.fromBytes(
        'myfile1', [],
        filename: '',
        contentType: MediaType('application', 'jpeg'),
        //      filename: 'myfile1'),
      ));
    }

    if (path2 != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'myfile2', File(path2).readAsBytesSync(),
        filename: path2.split("/").last,
        contentType: MediaType('application', 'jpeg'),
        //      filename: 'myfile1'),
      ));
    } else {
      request.files.add(http.MultipartFile.fromBytes(
        'myfile2', [],
        filename: '',
        contentType: MediaType('application', 'jpeg'),
        //      filename: 'myfile1'),
      ));
    }

    if (path3 != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'myfile3', File(path3).readAsBytesSync(),
        filename: path3.split("/").last,
        contentType: MediaType('application', 'jpeg'),
        //      filename: 'myfile1'),
      ));
    } else {
      request.files.add(http.MultipartFile.fromBytes(
        'myfile3', [],
        filename: '',
        contentType: MediaType('application', 'jpeg'),
        //      filename: 'myfile1'),
      ));
    }
    late http.Response response;
    try {
      var res = await request.send();
      response = await http.Response.fromStream(res);
      ph('idhistory:$idhitory');

      ph(response.body);
      ph(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        int? i = ConverterNumber.stringToInt(map['status']);
        if (i == 1) {
          return true;
        }
      }
      return false;
    } catch (e) {
      ph(response.body);
      return false;
    }
  }

  Future<Map<String, Merchandising>?> getDetailMerch(
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
        '/bottommenumerchandising/merchandising_detail/$idoutlet/$namalokasi/$strDt');

    try {
      final Map<String, String> headers = await getHeader();
      final response = await http.get(uri, headers: headers);
      ph(response.body);
      ph(response.statusCode);
      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        return _olahMapMerchandising(value);
      }
      return null;
    } catch (e) {
      ph(e.toString());
      return null;
    }
  }

  Future<String?> uploadDoc(List<int> _selectedFile, String ext) async {
    var request = http.MultipartRequest('POST', Uri.parse(''));
    request.files.add(await http.MultipartFile.fromPath('picture', ''));
    var res = await request.send();
    return res.reasonPhrase;
  }

  Map<String, Merchandising> _olahMapMerchandising(dynamic value) {
    Map<String, Merchandising> moutlet = {};

    try {
      Map<String, dynamic> mp = value;
      List<dynamic> ld = mp['data'];

      if (ld.isNotEmpty) {
        for (int i = 0; i < ld.length; i++) {
          Map<String, dynamic> map = ld[i];
          Merchandising merchandising = Merchandising.fromJson(map);
          merchandising.isServerExist = true;
          ph(merchandising.idjenisshare);
          if (merchandising.idjenisshare == Merchandising.tagPerdana) {
            moutlet[Merchandising.tagPerdana] = merchandising;
          }
          if (merchandising.idjenisshare == Merchandising.tagVoucherFisik) {
            moutlet[Merchandising.tagVoucherFisik] = merchandising;
          } else if (merchandising.idjenisshare == Merchandising.tagSpanduk) {
            moutlet[Merchandising.tagSpanduk] = merchandising;
          } else if (merchandising.idjenisshare == Merchandising.tagPoster) {
            moutlet[Merchandising.tagPoster] = merchandising;
          } else if (merchandising.idjenisshare == Merchandising.tagPapan) {
            moutlet[Merchandising.tagPapan] = merchandising;
          } else if (merchandising.idjenisshare ==
              Merchandising.tagStikerScanQR) {
            moutlet[Merchandising.tagStikerScanQR] = merchandising;
          }
        }
      }

      return moutlet;
    } catch (e) {
      return moutlet;
    }
  }
}
