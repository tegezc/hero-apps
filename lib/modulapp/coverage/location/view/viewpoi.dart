import 'package:flutter/material.dart';
import 'package:hero/http/httplokasi/httpPoi.dart';
import 'package:hero/http/httplokasi/httpsearchlocation.dart';
import 'package:hero/model/lokasi/lokasimodel.dart';
import 'package:hero/model/lokasi/poi.dart';
import 'package:hero/util/component/component_label.dart';
import 'package:hero/util/component/component_widget.dart';

import '../widgetforlocation.dart';

class ViewPoi extends StatefulWidget {
  static const routeName = '/viewpoi';
  final String? idpoi;

  ViewPoi(this.idpoi);

  @override
  _ViewPoiState createState() => _ViewPoiState();
}

class _ViewPoiState extends State<ViewPoi> {
  String? _title;
  late bool _isloading;
  Poi? _poi;
  @override
  void initState() {
    _isloading = true;
    _title = 'Detail POI';
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
    HttpPoi httpOutlet = new HttpPoi();
    List<dynamic> ld = await (httpOutlet.detailPoi(widget.idpoi) as Future<List<dynamic>>);
    if (ld.length == 1) {
      Map<String, dynamic> map = ld[0];
      _poi = Poi.fromJson(map);

      if (_poi != null) {
        if (_poi!.idkel != null) {
          Kecamatan? kec = await _httpDashboard.getKec(_poi!.idkel);
          if (kec != null) {
            _poi!.kec = kec;

            Kabupaten? kab = await _httpDashboard.getKab(kec.realid);
            if (kab != null) {
              _poi!.kab = kab;

              Provinsi? prov = await _httpDashboard.getProv(kab.realid);
              _poi!.prov = prov;
            }
            List<Kelurahan> lkel =
                await (_httpDashboard.getListKelurahan(kec.realid) as Future<List<Kelurahan>>);

            lkel.forEach((element) {
              if (element.idkel == _poi!.idkel) {
                _poi!.kel = element;
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
      return ScaffoldLocView(
          title: _title,
          body: Container(
            child: SingleChildScrollView(
              child: new Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Label2row('Nama', _poi!.nama),
                    _spasi(),
                    Divider(),
                    Label2row('Provinsi:', '${_poi!.getStrProv()}'),
                    _spasi(),
                    Divider(),
                    Label2row('Kabupaten:', '${_poi!.getStrKab()}'),
                    _spasi(),
                    Divider(),
                    Label2row('Kecamatan:', '${_poi!.getStrKec()}'),
                    _spasi(),
                    Divider(),
                    Label2row('Kelurahan:', '${_poi!.getStrKel()}'),
                    _spasi(),
                    Divider(),
                    Label2row('Alamat:', '${_poi!.alamat}'),
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
          ));
    }
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
            Label2row('Longitude:', '${_poi!.long}'),
            SizedBox(
              height: 8,
            ),
            Label2row('Latitude:', '${_poi!.lat}'),
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
