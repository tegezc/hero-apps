import 'package:flutter/material.dart';
import 'package:hero/http/httplokasi/httpOutlet.dart';
import 'package:hero/http/httplokasi/httpsearchlocation.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/lokasi/lokasimodel.dart';
import 'package:hero/model/lokasi/outlet.dart';
import 'package:hero/modulapp/coverage/location/view/viewpageidentitas.dart';
import 'package:hero/util/component/component_label.dart';
import 'package:hero/util/component/component_widget.dart';

import '../widgetforlocation.dart';

class ViewOutlet extends StatefulWidget {
  static const routeName = '/viewOutlet';
  final String? idoutlet;

  ViewOutlet(this.idoutlet);

  @override
  _ViewOutletState createState() => _ViewOutletState();
}

class _ViewOutletState extends State<ViewOutlet> {
  String? _title;
  late bool _isloading;
  Outlet? _outlet;
  @override
  void initState() {
    _isloading = true;
    _title = 'Detail Outlet';
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
    HttpOutlet httpOutlet = new HttpOutlet();
    List<dynamic>? ld = await (httpOutlet.detailOutlet(widget.idoutlet));
    if (ld!.length == 1) {
      Map<String, dynamic> map = ld[0];
      _outlet = Outlet.fromJson(map);

      if (_outlet != null) {
        if (_outlet!.idkelurahan != null) {
          Kecamatan? kec = await _httpDashboard.getKec(_outlet!.idkelurahan);
          if (kec != null) {
            _outlet!.kec = kec;

            Kabupaten? kab = await _httpDashboard.getKab(kec.realid);
            if (kab != null) {
              _outlet!.kab = kab;

              Provinsi? prov = await _httpDashboard.getProv(kab.realid);
              _outlet!.prov = prov;
            }
            List<Kelurahan>? lkel =
                await (_httpDashboard.getListKelurahan(kec.realid));

            for (var element in lkel!) {
              if (element.idkel == _outlet!.idkelurahan) {
                _outlet!.kel = element;
              }
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
                  child: LabelWhite.size2('Data Outlet'),
                ),
                Tab(
                  child: LabelWhite.size2('Owner Outlet'),
                ),
                Tab(
                  child: LabelWhite.size2('PIC'),
                ),
              ],
            ),
            body: TabBarView(
              children: [
                TabViewOutlet(_outlet),
                ViewPageIdentitas(
                  EnumPicOwner.owner,
                  owner: _outlet!.owner,
                ),
                ViewPageIdentitas(
                  EnumPicOwner.pic,
                  pic: _outlet!.pic,
                ),
              ],
            )),
      );
    }
  }
}

class TabViewOutlet extends StatelessWidget {
  final Outlet? outlet;

  TabViewOutlet(this.outlet);

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
              Label2row('Nama', outlet!.nama),
              _spasi(),
              Divider(),
              Label2row('Nomor RS', outlet!.nors),
              _spasi(),
              Divider(),
              Label2row('Jenis Outlet', '${outlet!.getStrJenisOutlet()}'),
              _spasi(),
              Divider(),
              Label2row('Provinsi:', '${outlet!.getStrProv()}'),
              _spasi(),
              Divider(),
              Label2row('Kabupaten:', '${outlet!.getStrKab()}'),
              _spasi(),
              Divider(),
              Label2row('Kecamatan:', '${outlet!.getStrKec()}'),
              _spasi(),
              Divider(),
              Label2row('Kelurahan:', '${outlet!.getStrKel()}'),
              _spasi(),
              Divider(),
              Label2row('Alamat:', '${outlet!.alamat}'),
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
            Label2row('Longitude:', '${outlet!.long}'),
            SizedBox(
              height: 8,
            ),
            Label2row('Latitude:', '${outlet!.lat}'),
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
