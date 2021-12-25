import 'package:hero/http/httplokasi/httpsearchlocation.dart';
import 'package:hero/model/enumapp.dart';
import 'package:rxdart/subjects.dart';

class BlocSearchLocation {
  UISearchLocation? _cacheItem;

  final BehaviorSubject<UISearchLocation?> _uidashboard = BehaviorSubject();

  Stream<UISearchLocation?> get uidashboard => _uidashboard.stream;

  void firstTime() {
    // Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
    //     .then((value) {
    //   print(value);
    // });
    _cacheItem = UISearchLocation();
    _cacheItem!.ltempat = [];

    this._sinkItem(_cacheItem);
  }

  void searchLokasi(String query, EnumJenisLokasi enumJenisLokasi) {
    _cacheItem!.isloading = true;
    _cacheItem!.ltempat = [];
    this._sinkItem(_cacheItem);
    HttpSearchLocation httpDashboard = new HttpSearchLocation();
    List<LokasiSimple?> ltempat = [];
    httpDashboard.cari(query, enumJenisLokasi).then((value) {
      if (value != null) {
        List<dynamic> list = value;

        for (int i = 0; i < list.length; i++) {
          Map<String, dynamic> map = list[i];
          LokasiSimple? lokasiSimple;
          switch (enumJenisLokasi) {
            case EnumJenisLokasi.outlet:
              lokasiSimple = LokasiSimple.fromJsonOutlet(map);
              break;
            case EnumJenisLokasi.poi:
              lokasiSimple = LokasiSimple.fromJsonPoi(map);
              break;
            case EnumJenisLokasi.sekolah:
              lokasiSimple = LokasiSimple.fromJsonSekolah(map);
              break;
            case EnumJenisLokasi.kampus:
              lokasiSimple = LokasiSimple.fromJsonKampus(map);
              break;
            case EnumJenisLokasi.fakultas:
              lokasiSimple = LokasiSimple.fromJsonFakultas(map);
              break;
          }

          ltempat.add(lokasiSimple);
        }
        _cacheItem!.ltempat = ltempat;
        _cacheItem!.isloading = false;
        this._sinkItem(_cacheItem);
      }
    });
  }

  void reset() {
    if (_cacheItem!.ltempat != null) {
      _cacheItem!.ltempat!.clear();
    }
  }

  void _sinkItem(UISearchLocation? item) {
    _uidashboard.sink.add(item);
  }

  void dispose() {
    _uidashboard.close();
  }
}

class UISearchLocation {
  List<LokasiSimple?>? ltempat;
  // EnumStateWidget enumStateWidget;
  bool isloading = false;
}

class LokasiSimple {
  String? idutama;
  String? idminor;
  String? text;
  String? text2;
  EnumJenisLokasi? enumJenisLokasi;

  LokasiSimple.fromJsonOutlet(Map<String, dynamic> map) {
    // "id_outlet": "1",
    // "id_digipos": "1",
    // "nama_outlet": "OUTLET 11",
    // "no_rs": "NO RS 11"
    //
    enumJenisLokasi = EnumJenisLokasi.outlet;
    idutama = map['id_outlet'];
    idminor = map['id_digipos'];
    text = map['nama_outlet'];
    text2 = map['no_rs'];
  }

  LokasiSimple.fromJsonPoi(Map<String, dynamic> map) {
    // "id_poi": "1",
    // "nama_poi": "POI 1",
    // "alamat_poi": "ALAMAT 1"
    enumJenisLokasi = EnumJenisLokasi.poi;
    idutama = map['id_poi'];
    text = map['nama_poi'];
    text2 = map['alamat_poi'];
  }

  LokasiSimple.fromJsonSekolah(Map<String, dynamic> map) {
    //  "id_sekolah": "1",
    //  "no_npsn": "1",
    //  "nama_sekolah": "SEKOLAH 1"

    enumJenisLokasi = EnumJenisLokasi.sekolah;
    idutama = map['id_sekolah'];
    idminor = map['no_npsn'];
    text = map['nama_sekolah'];
  }

  LokasiSimple.fromJsonKampus(Map<String, dynamic> map) {
    // "id_universitas": "1",
    // "no_npsn": "1",
    // "nama_universitas": "KAMPUS 1"
    enumJenisLokasi = EnumJenisLokasi.kampus;
    idutama = map['id_universitas'];
    idminor = map['no_npsn'];
    text = map['nama_universitas'];
  }

  LokasiSimple.fromJsonFakultas(Map<String, dynamic> map) {
    //  "id_fakultas": "1",
    //  "nama_fakultas": "FAKULTAS 1",
    //  "nama_universitas": "KAMPUS 1"

    enumJenisLokasi = EnumJenisLokasi.fakultas;
    idutama = map['id_fakultas'];
    text = map['nama_fakultas'];
    text2 = map['nama_universitas'];
  }
}
