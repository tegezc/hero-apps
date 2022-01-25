import 'package:flutter/material.dart';
import 'package:hero/http/httplokasi/httpfakultas.dart';
import 'package:hero/http/httplokasi/httpsearchlocation.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/lokasi/Fakultas.dart';
import 'package:hero/model/lokasi/lokasimodel.dart';
import 'package:hero/modulapp/coverage/location/view/viewpageidentitas.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/widget/component_widget.dart';

import '../widgetforlocation.dart';

class ViewFakultas extends StatefulWidget {
  static const routeName = '/viewFakultas';
  final String? idfakultas;

  ViewFakultas(this.idfakultas);

  @override
  _ViewFakultasState createState() => _ViewFakultasState();
}

class _ViewFakultasState extends State<ViewFakultas> {
  String? _title;
  late bool _isloading;
  Fakultas? fakultas;
  @override
  void initState() {
    _isloading = true;
    _title = 'Detail Fakultas';
    this._setup();
    super.initState();
  }

  void _setup() {
    this._setupdata().then((value) {
      if (value) {
        setState(() {
          _isloading = false;
        });
      }
    });
  }

  Future<bool> _setupdata() async {
    HttpSearchLocation _httpDashboard = HttpSearchLocation();
    HttpFakultas httpOutlet = HttpFakultas();
    List<dynamic> ld = await (httpOutlet.detailFakultas(widget.idfakultas)
        as Future<List<dynamic>>);
    if (ld.length == 1) {
      Map<String, dynamic> map = ld[0];
      fakultas = Fakultas.fromJson(map);

      if (fakultas != null) {
        if (fakultas!.idkel != null) {
          Kecamatan? kec = await _httpDashboard.getKec(fakultas!.idkel);
          if (kec != null) {
            fakultas!.kec = kec;

            Kabupaten? kab = await _httpDashboard.getKab(kec.realid);
            if (kab != null) {
              fakultas!.kab = kab;

              Provinsi? prov = await _httpDashboard.getProv(kab.realid);
              fakultas!.prov = prov;
            }
            List<Kelurahan> lkel = await (_httpDashboard
                .getListKelurahan(kec.realid) as Future<List<Kelurahan>>);

            lkel.forEach((element) {
              if (element.idkel == fakultas!.idkel) {
                fakultas!.kel = element;
              }
            });
          }
        }
        return true;
      }
    }
    return false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isloading) {
      return ScaffoldLocView(title: 'Loading...', body: Container());
    } else {
      return DefaultTabController(
        length: 3,
        child: ScaffoldLocView(
            title: _title,
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                // wallet share, sales broadband share, voucher fisik share
                Tab(
                  child: LabelBlack.size2('Data Fakultas'),
                ),
                Tab(
                  child: LabelBlack.size2('Dekan Fakultas'),
                ),
                Tab(
                  child: LabelBlack.size2('PIC'),
                ),
              ],
            ),
            body: TabBarView(
              children: [
                TabViewFakultas(fakultas),
                ViewPageIdentitas(
                  EnumPicOwner.owner,
                  owner: fakultas!.dekan,
                ),
                ViewPageIdentitas(
                  EnumPicOwner.pic,
                  pic: fakultas!.pic,
                ),
              ],
            )),
      );
    }
  }
}

class TabViewFakultas extends StatelessWidget {
  final Fakultas? sekolah;

  TabViewFakultas(this.sekolah);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20.0),
              Label2row('Nama', sekolah!.nama),
              _spasi(),
              Divider(),
              Label2row('Nama Universitas', sekolah!.namaUniv),
              _spasi(),
              Divider(),
              Label2row('Provinsi:', '${sekolah!.getStrProv()}'),
              _spasi(),
              Divider(),
              Label2row('Kabupaten:', '${sekolah!.getStrKab()}'),
              _spasi(),
              Divider(),
              Label2row('Kecamatan:', '${sekolah!.getStrKec()}'),
              _spasi(),
              Divider(),
              Label2row('Kelurahan:', '${sekolah!.getStrKel()}'),
              _spasi(),
              Divider(),
              Label2row('Alamat:', '${sekolah!.alamat}'),
              _spasi(),
              Divider(),
              Label2row('Jumlah Dosen:', '${sekolah!.jmlDosen}'),
              _spasi(),
              Divider(),
              Label2row('Jumlah Mahasiswa:', '${sekolah!.jmlMahasiswa}'),
              _spasi(),
              SizedBox(
                height: 12,
              ),
              _koordinatWidget(context),
              SizedBox(
                height: 150.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _koordinatWidget(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return ContainerRounded(
      width: s.width - 43,
      radius: 8.0,
      borderColor: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Label2row('Longitude:', '${sekolah!.long}'),
            SizedBox(
              height: 8,
            ),
            Label2row('Latitude:', '${sekolah!.lat}'),
          ],
        ),
      ),
    );
  }

  Widget _spasi() {
    return SizedBox(
      height: 12,
    );
  }
}
