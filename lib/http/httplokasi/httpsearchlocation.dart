import 'dart:convert';

import 'package:hero/core/log/printlog.dart';
import 'package:hero/http/core/httpbase.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/lokasi/lokasimodel.dart';
import 'package:http/http.dart' as http;

class HttpSearchLocation extends HttpBase {
  Future<List<dynamic>?> cari(
      String query, EnumJenisLokasi enumJenisLokasi) async {
    Map<String, String> headers = await getHeader();

    Map<String, dynamic> map;
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
    }
    map = {"id_jenis_lokasi": namalokasi, "cari": query};
    Uri uri = configuration.uri('/location/cari');
    ph(uri);
    try {
      http.Response response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );
      ph(response.statusCode);
      ph(response.body);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      return null;
    } catch (e) {
      ph(e);
      return null;
    }
  }

  Future<List<Provinsi>?> getDaftarProvinsi() async {
    Uri uri = configuration.uri('/combobox/provinsi');
    try {
      final Map<String, String> headers = await getHeader();
      final response = await http.get(uri, headers: headers);
      //  ph(json.decode(response.body));
      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        return _olahProvinsi(value);
      }
      return null;
    } catch (e) {
      ph(e.toString());
      return null;
    }
  }

  Future<List<Kecamatan>?> getListKecamatan(String? idkab) async {
    Uri uri = configuration.uri('/combobox/kecamatan');
    try {
      final Map<String, String> headers = await getHeader();
      final response = await http.post(uri,
          headers: headers, body: jsonEncode({"id_kabupaten": "$idkab"}));
      //  ph(json.decode(response.body));
      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        return _olahKecamatan(value);
      }
      return null;
    } catch (e) {
      ph(e.toString());
      return null;
    }
  }

  Future<List<Kabupaten>?> getListKabupaten(String? idprov) async {
    Uri uri = configuration.uri('/combobox/kabupaten');
    try {
      final Map<String, String> headers = await getHeader();
      final response = await http.post(uri,
          headers: headers, body: jsonEncode({"id_provinsi": "$idprov"}));
      //   ph(json.decode(response.body));
      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        return _olahKabupaten(value);
      }
      return null;
    } catch (e) {
      ph(e.toString());
      return null;
    }
  }

  Future<List<Kelurahan>?> getListKelurahan(String? idkecamatan) async {
    try {
      final Map<String, String> headers = await getHeader();
      Uri uri = configuration.uri('/combobox/kelurahan');
      final response = await http.post(uri,
          headers: headers, body: jsonEncode({"id_kecamatan": "$idkecamatan"}));
      // ph(response.statusCode);
      //  ph(json.decode(response.body));
      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        //   ph(value);
        return _olahKelurahan(value);
      }
      return null;
    } catch (e) {
      ph(e.toString());
      return null;
    }
  }

  Future<Kecamatan?> getKec(String? idkelurahan) async {
    try {
      final Map<String, String> headers = await getHeader();
      Uri uri = configuration.uri('/combobox/select_kecamatan/$idkelurahan');
      final response = await http.get(uri, headers: headers);
      //  ph(json.decode(response.body));
      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        return _olahKec(value);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<Kabupaten?> getKab(String? idkec) async {
    try {
      final Map<String, String> headers = await getHeader();
      Uri uri = configuration.uri('/combobox/select_kabupaten/$idkec');
      final response = await http.get(uri, headers: headers);
      //   ph(json.decode(response.body));
      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        return _olahKab(value);
      }
      return null;
    } catch (e) {
      ph(e.toString());
      return null;
    }
  }

  Future<Provinsi?> getProv(String? idkab) async {
    try {
      final Map<String, String> headers = await getHeader();
      Uri uri = configuration.uri('/combobox/select_provinsi/$idkab');
      final response = await http.get(uri, headers: headers);
      //  ph(json.decode(response.body));
      if (response.statusCode == 200) {
        dynamic value = json.decode(response.body);
        return _olahProv(value);
      }
      return null;
    } catch (e) {
      ph(e.toString());
      return null;
    }
  }

  Provinsi? _olahProv(dynamic value) {
    try {
      List<dynamic> ld = value;
      if (ld.isNotEmpty) {
        Map<String, dynamic> map = ld[0];
        Provinsi provinsi = Provinsi.fromJson(map);
        return provinsi;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Kabupaten? _olahKab(dynamic value) {
    try {
      List<dynamic> ld = value;
      if (ld.isNotEmpty) {
        Map<String, dynamic> map = ld[0];
        Kabupaten kabupaten = Kabupaten.fromJson(map);
        return kabupaten;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Kecamatan? _olahKec(dynamic value) {
    try {
      List<dynamic> ld = value;
      if (ld.isNotEmpty) {
        Map<String, dynamic> map = ld[0];
        Kecamatan kec = Kecamatan.fromJson(map);
        return kec;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  List<Kabupaten> _olahKabupaten(dynamic value) {
    ph(value);
    List<Kabupaten> lkab = [];
    try {
      List<dynamic> ld = value;
      if (ld.isNotEmpty) {
        for (int i = 0; i < ld.length; i++) {
          Map<String, dynamic> map = ld[i];
          Kabupaten kab = Kabupaten.fromJson(map);
          lkab.add(kab);
        }
      }
      return lkab;
    } catch (e) {
      ph(e);
      return lkab;
    }
  }

  List<Kecamatan> _olahKecamatan(dynamic value) {
    List<Kecamatan> lkec = [];
    try {
      List<dynamic> ld = value;
      if (ld.isNotEmpty) {
        for (int i = 0; i < ld.length; i++) {
          Map<String, dynamic> map = ld[i];
          Kecamatan kec = Kecamatan.fromJson(map);
          lkec.add(kec);
        }
      }
      return lkec;
    } catch (e) {
      return lkec;
    }
  }

  List<Provinsi> _olahProvinsi(dynamic value) {
    List<Provinsi> lprov = [];
    try {
      List<dynamic> ld = value;
      if (ld.isNotEmpty) {
        for (int i = 0; i < ld.length; i++) {
          Map<String, dynamic> map = ld[i];
          Provinsi kec = Provinsi.fromJson(map);
          lprov.add(kec);
        }
      }
      return lprov;
    } catch (e) {
      return lprov;
    }
  }

  List<Kelurahan> _olahKelurahan(dynamic value) {
    List<Kelurahan> lprov = [];
    try {
      List<dynamic> ld = value;
      if (ld.isNotEmpty) {
        for (int i = 0; i < ld.length; i++) {
          Map<String, dynamic> map = ld[i];
          Kelurahan kec = Kelurahan.fromJson(map);
          lprov.add(kec);
        }
      }
      return lprov;
    } catch (e) {
      return lprov;
    }
  }
}
