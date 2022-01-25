import 'package:flutter/material.dart';
import 'package:hero/http/httplokasi/httpkampus.dart';
import 'package:hero/http/httplokasi/httpsearchlocation.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/lokasi/lokasimodel.dart';
import 'package:hero/model/lokasi/universitas.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/widget/component_widget.dart';

import '../widgetforlocation.dart';
import 'viewpageidentitas.dart';

class ViewKampus extends StatefulWidget {
  static const routeName = '/viewKampus';
  final String? iduniv;

  ViewKampus(this.iduniv);

  @override
  _ViewKampusState createState() => _ViewKampusState();
}

class _ViewKampusState extends State<ViewKampus> {
  String? _title;
  late bool _isloading;
  Universitas? _kampus;
  @override
  void initState() {
    _isloading = true;
    _title = 'Detail Kampus';
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
    HttpKampus httpOutlet = new HttpKampus();
    List<dynamic> ld =
        await (httpOutlet.detailUniv(widget.iduniv) as Future<List<dynamic>>);
    if (ld.length == 1) {
      Map<String, dynamic> map = ld[0];
      _kampus = Universitas.fromJson(map);

      if (_kampus != null) {
        if (_kampus!.idkel != null) {
          Kecamatan? kec = await _httpDashboard.getKec(_kampus!.idkel);
          if (kec != null) {
            _kampus!.kec = kec;

            Kabupaten? kab = await _httpDashboard.getKab(kec.realid);
            if (kab != null) {
              _kampus!.kab = kab;

              Provinsi? prov = await _httpDashboard.getProv(kab.realid);
              _kampus!.prov = prov;
            }
            List<Kelurahan> lkel = await (_httpDashboard
                .getListKelurahan(kec.realid) as Future<List<Kelurahan>>);

            lkel.forEach((element) {
              if (element.idkel == _kampus!.idkel) {
                _kampus!.kel = element;
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
                  child: LabelBlack.size2('Data Kampus'),
                ),
                Tab(
                  child: LabelBlack.size2('Rektor Kampus'),
                ),
                Tab(
                  child: LabelBlack.size2('PIC'),
                ),
              ],
            ),
            body: TabBarView(
              children: [
                TabViewKampus(_kampus),
                ViewPageIdentitas(
                  EnumPicOwner.owner,
                  owner: _kampus!.owner,
                ),
                ViewPageIdentitas(
                  EnumPicOwner.pic,
                  pic: _kampus!.pic,
                ),
              ],
            )),
      );
    }
  }
}

class TabViewKampus extends StatelessWidget {
  final Universitas? sekolah;

  TabViewKampus(this.sekolah);

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
              Label2row('NPSN', sekolah!.npsn),
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
    return const SizedBox(
      height: 12,
    );
  }
}
