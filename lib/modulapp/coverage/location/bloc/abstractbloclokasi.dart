import 'package:hero/http/httplokasi/httpsearchlocation.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/lokasi/lokasimodel.dart';

abstract class AbsBlocLokasi {
  ControllLokasi? controllLokasi;

  void init(EnumEditorState enumEditorState, String? idkelurahan) {
    // controllLokasi = ControllLokasi(initlokasiComplete, finishPickProv,
    //     finishPickKab, finishPickKec, finishPickKel);
    controllLokasi = ControllLokasi(operationCompleted);
    if (enumEditorState == EnumEditorState.baru) {
      controllLokasi!.initLokasi();
    } else {
      controllLokasi!.initLokasiEdit(idkelurahan);
    }
  }

  void operationCompleted();
  bool isValid();
  void setValueBeforeCreateUpdate();
// void initlokasiComplete(List<Provinsi> lprov);
// void finishPickProv(List<Kabupaten> lkab, Provinsi prov);
// void finishPickKab(List<Kecamatan> lkab, Kabupaten kab);
// void finishPickKec(List<Kelurahan> lkec, Kecamatan kec);
// void finishPickKel(Kelurahan kel);
}

class ControllLokasi {
  // Function(List<Provinsi>) lprovComplete;
  // Function(List<Kabupaten>, Provinsi) finishPickProv;
  // Function(List<Kecamatan>, Kabupaten kab) finishPickKab;
  // Function(List<Kelurahan>, Kecamatan kec) finishPickKec;
  // Function(Kelurahan) finishPickKel;
  Function operationCompleted;
  DataLokasiAlamat? dataLokasiAlamat;
  late HttpSearchLocation _httpDashboard;
  // ControllLokasi(this.lprovComplete, this.finishPickProv, this.finishPickKab,
  //     this.finishPickKec, this.finishPickKel);

  ControllLokasi(this.operationCompleted);

  void initLokasi() {
    dataLokasiAlamat = DataLokasiAlamat();
    _httpDashboard = new HttpSearchLocation();
    _httpDashboard.getDaftarProvinsi().then((value) {
      dataLokasiAlamat!.lprov = value;
      operationCompleted();
    });
  }

  void initLokasiEdit(String? idkelurahan) {
    _httpDashboard = new HttpSearchLocation();
    _setupinitEdit(idkelurahan).then((value) {
      if (value) {
        operationCompleted();
      }
    });
  }

  Future<bool> _setupinitEdit(String? idkelurahan) async {
    dataLokasiAlamat = DataLokasiAlamat();
    if (idkelurahan != null) {
      Kecamatan? kec = await _httpDashboard.getKec(idkelurahan);
      if (kec != null) {
        dataLokasiAlamat!.currentKec = kec;

        Kabupaten? kab = await _httpDashboard.getKab(kec.realid);

        if (kab != null) {
          dataLokasiAlamat!.currentKab = kab;
          Provinsi? prov = await _httpDashboard.getProv(kab.realid);
          if (prov != null) {
            dataLokasiAlamat!.currentProv = prov;
            dataLokasiAlamat!.lkab =
                await _httpDashboard.getListKabupaten(prov.realid);
          }

          dataLokasiAlamat!.lkec =
              await _httpDashboard.getListKecamatan(kab.realid);
        }

        dataLokasiAlamat!.lkel =
            await _httpDashboard.getListKelurahan(kec.realid);
        dataLokasiAlamat!.lprov = await _httpDashboard.getDaftarProvinsi();

        dataLokasiAlamat!.lkel!.forEach((element) {
          if (element.idkel == idkelurahan) {
            dataLokasiAlamat!.currentKelurahan = element;
          }
        });

        dataLokasiAlamat!.kondisikan();
      }
    }
    return true;
  }

  void comboProvPicked(Provinsi? prov) {
    bool doit = true;
    if (dataLokasiAlamat!.currentProv != null) {
      if (dataLokasiAlamat!.currentProv == prov) {
        doit = false;
      }
    }
    if (doit) {
      _httpDashboard.getListKabupaten(prov!.realid).then((value) {
        dataLokasiAlamat!.currentProv = prov;
        dataLokasiAlamat!.lkab = value;
        dataLokasiAlamat!.currentKab = null;
        dataLokasiAlamat!.lkec = null;
        dataLokasiAlamat!.currentKec = null;
        dataLokasiAlamat!.lkel = null;
        dataLokasiAlamat!.currentKelurahan = null;
        operationCompleted();
      });
    }
  }

  void comboKabPicked(Kabupaten? kab) {
    bool doit = true;
    if (dataLokasiAlamat!.currentKab != null) {
      if (dataLokasiAlamat!.currentKab == kab) {
        doit = false;
      }
    }

    if (doit) {
      _httpDashboard.getListKecamatan(kab!.realid).then((value) {
        dataLokasiAlamat!.currentKab = kab;
        dataLokasiAlamat!.lkec = value;
        dataLokasiAlamat!.currentKec = null;
        dataLokasiAlamat!.lkel = null;
        dataLokasiAlamat!.currentKelurahan = null;
        operationCompleted();
      });
    }
  }

  void comboKecPicked(Kecamatan? kec) {
    bool doit = true;
    if (dataLokasiAlamat!.currentKec != null) {
      if (dataLokasiAlamat!.currentKec == kec) {
        doit = false;
      }
    }

    if (doit) {
      _httpDashboard.getListKelurahan(kec!.realid).then((value) {
        dataLokasiAlamat!.currentKec = kec;
        dataLokasiAlamat!.lkel = value;
        dataLokasiAlamat!.currentKelurahan = null;
        operationCompleted();
      });
    }
  }

  void comboKelPicked(Kelurahan? kel) {
    dataLokasiAlamat!.currentKelurahan = kel;
    operationCompleted();
  }

  String? getIdKel() {
    return dataLokasiAlamat!.currentKelurahan == null
        ? null
        : dataLokasiAlamat!.currentKelurahan!.idkel;
  }
}

class DataLokasiAlamat {
  List<Provinsi>? lprov;
  List<Kecamatan>? lkec;
  List<Kabupaten>? lkab;
  List<Kelurahan>? lkel;

  Provinsi? currentProv;
  Kabupaten? currentKab;
  Kecamatan? currentKec;
  Kelurahan? currentKelurahan;

  // method ini mengkondisikan jika misalnya kecamatan di temukan , kemudian saat
  // get list kecamatan, ternyata kecamatan tidak ada di dlm list kecamatan maka
  // current kecamatan di set null. ini terjadi juga untuk  provinsi, kabupaten,
  // kelurahan
  void kondisikan() {
    if (lprov != null) {
      if (!lprov!.contains(currentProv)) {
        currentProv = null;
      }
    }
    if (lkab != null) {
      if (!lkab!.contains(currentKab)) {
        currentKab = null;
      }
    }
    if (lkec != null) {
      if (!lkec!.contains(currentKec)) {
        currentKec = null;
      }
    }
    if (lkel != null) {
      if (!lkel!.contains(currentKelurahan)) {
        currentKelurahan = null;
      }
    }
  }

  @override
  String toString() {
    return 'prov: $currentProv | lprov: $lprov\n'
        'kab: $currentKab | lkab: $lkab\n'
        'kec: $currentKec | lkec: $lkec\n'
        'kel: $currentKelurahan | lkel: $lkel';
  }
}
