import 'package:flutter/material.dart';
import 'package:hero/http/httplokasi/httpsearchlocation.dart';
import 'package:hero/http/httplokasi/httpsekolah.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/lokasi/lokasimodel.dart';
import 'package:hero/model/lokasi/sekolah.dart';
import 'package:hero/modulapp/coverage/location/view/viewpageidentitas.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/widget/component_widget.dart';

import '../widgetforlocation.dart';

class ViewSekolah extends StatefulWidget {
  static const routeName = '/viewSekolah';
  final String? idsekolah;

  ViewSekolah(this.idsekolah);

  @override
  _ViewSekolahState createState() => _ViewSekolahState();
}

class _ViewSekolahState extends State<ViewSekolah> {
  String? _title;
  late bool _isloading;
  Sekolah? _sekolah;
  @override
  void initState() {
    _isloading = true;
    _title = 'Detail Sekolah';
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
    HttpSekolah httpOutlet = new HttpSekolah();
    List<dynamic>? ld = await httpOutlet.detailSekolah(widget.idsekolah);
    if (ld == null) {
      return false;
    }
    if (ld.length == 1) {
      Map<String, dynamic> map = ld[0];
      _sekolah = Sekolah.fromJson(map);

      if (_sekolah != null) {
        if (_sekolah!.idkel != null) {
          Kecamatan? kec = await _httpDashboard.getKec(_sekolah!.idkel);
          if (kec != null) {
            _sekolah!.kec = kec;

            Kabupaten? kab = await _httpDashboard.getKab(kec.realid);
            if (kab != null) {
              _sekolah!.kab = kab;

              Provinsi? prov = await _httpDashboard.getProv(kab.realid);
              _sekolah!.prov = prov;
            }
            List<Kelurahan>? lkel =
                await _httpDashboard.getListKelurahan(kec.realid);
            if (lkel != null) {
              lkel.forEach((element) {
                if (element.idkel == _sekolah!.idkel) {
                  _sekolah!.kel = element;
                }
              });
            }
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
                  child: LabelBlack.size2('Data Sekolah'),
                ),
                Tab(
                  child: LabelBlack.size2('Kepala Sekolah'),
                ),
                Tab(
                  child: LabelBlack.size2('PIC'),
                ),
              ],
            ),
            body: TabBarView(
              children: [
                TabViewSekolah(_sekolah),
                ViewPageIdentitas(
                  EnumPicOwner.owner,
                  owner: _sekolah!.owner,
                ),
                ViewPageIdentitas(
                  EnumPicOwner.pic,
                  pic: _sekolah!.pic,
                ),
              ],
            )),
      );
    }
  }
}

class TabViewSekolah extends StatelessWidget {
  final Sekolah? sekolah;

  TabViewSekolah(this.sekolah);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: new Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20.0),
              Label2row('Nama', sekolah!.nama),
              _spasi(),
              Divider(),
              Label2row('NPSN', sekolah!.noNpsn),
              _spasi(),
              Divider(),
              Label2row('Jenjang', '${sekolah!.getStrJenjang()}'),
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
              Label2row('Jumlah Guru:', '${sekolah!.jmlGuru}'),
              _spasi(),
              Divider(),
              Label2row('Jumlah Murid:', '${sekolah!.jmlMurid}'),
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
