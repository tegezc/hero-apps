import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:hero/model/lokasi/lokasimodel.dart';

class CSVReader {
  Future<List<Kecamatan>> getListKecamatan() async {
    List<Kecamatan> lkec = [];
    String value = await rootBundle.loadString('assets/csv/kecamatan.csv');
    List<String> ls = value.split('\n');
    ls.removeAt(0);
    for (var element in ls) {
      List<String> lsplit = element.split(',');
      if (lsplit.length == 4) {
        //   id_kabupaten,id_cluster,id_kecamatan,nama_kecamatan
        //   15.01,CTR003,15.01.01,Gunung Raya
        Kecamatan kecamatan = Kecamatan(
            idkab: lsplit[0],
            idcluster: lsplit[1],
            realid: lsplit[2],
            nama: lsplit[3]);
        lkec.add(kecamatan);
      } else {}
    }
    return lkec;
  }

  Future<List<Kelurahan>> getListKelurahan() async {
    List<Kelurahan> lkec = [];
    String value = await rootBundle.loadString('assets/csv/kelurahan.csv');
    List<String> ls = value.split('\n');
    ls.removeAt(0);
    for (var element in ls) {
      List<String> lsplit = element.split(',');
      if (lsplit.length == 3) {
        //   KELURAHAN ID,KECAMATAN ID,NAMA KELURAHAN
        // KLH0001,KEC051,PENINJAUAN
        Kelurahan kelurahan =
            Kelurahan(idkel: lsplit[0], idkec: lsplit[1], nama: lsplit[2]);
        lkec.add(kelurahan);
      } else if (lsplit.length > 3) {
        String gabungannama = '${lsplit[2]}${lsplit[3]}';
        Kelurahan kelurahan =
            Kelurahan(idkel: lsplit[0], idkec: lsplit[1], nama: gabungannama);
        lkec.add(kelurahan);
      }
    }
    return lkec;
  }

  Future<List<Kabupaten>> getListKabupaten() async {
    List<Kabupaten> lkab = [];
    String value = await rootBundle.loadString('assets/csv/kabupaten.csv');
    List<String> ls = value.split('\n');
    ls.removeAt(0);
    for (var element in ls) {
      List<String> lsplit = element.split(',');
      if (lsplit.length == 3) {
        //   id_provinsi,id_kabupaten,nama_kabupaten
        //   15,         15.01,       Kab. Kerinci
        Kabupaten kabupaten =
            Kabupaten(realid: lsplit[1], nama: lsplit[2], idprov: lsplit[0]);
        lkab.add(kabupaten);
      } else {}
    }
    return lkab;
  }

  Future<List<Provinsi>> getListProvinsi() async {
    List<Provinsi> lprov = [];
    String value = await rootBundle.loadString('assets/csv/provinsi.csv');
    List<String> ls = value.split('\n');
    ls.removeAt(0);
    for (var element in ls) {
      List<String> lsplit = element.split(',');
      if (lsplit.length == 2) {
        //   id_provinsi,nama_provinsi
        //   15,         Jambi
        Provinsi provinsi = Provinsi(realid: lsplit[0], nama: lsplit[1]);
        lprov.add(provinsi);
      } else {}
    }
    return lprov;
  }
}
