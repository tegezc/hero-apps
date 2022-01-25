import 'package:flutter/material.dart';
import 'package:hero/http/httplokasi/http_poi.dart';
import 'package:hero/http/httplokasi/httpsearchlocation.dart';
import 'package:hero/model/lokasi/lokasimodel.dart';
import 'package:hero/model/lokasi/poi.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/widget/component_widget.dart';

import '../widgetforlocation.dart';

class ViewPoi extends StatefulWidget {
  static const routeName = '/viewpoi';
  final String? idpoi;

  const ViewPoi(this.idpoi, {Key? key}) : super(key: key);

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
    _setup();
    super.initState();
  }

  void _setup() {
    _setupdata().then((value) {
      if (value) {
        setState(() {
          _isloading = false;
        });
      }
    });
  }

  Future<bool> _setupdata() async {
    HttpSearchLocation _httpDashboard = HttpSearchLocation();
    HttpPoi httpOutlet = HttpPoi();
    List<dynamic> ld =
        await (httpOutlet.detailPoi(widget.idpoi) as Future<List<dynamic>>);
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
            List<Kelurahan> lkel = await (_httpDashboard
                .getListKelurahan(kec.realid) as Future<List<Kelurahan>>);

            for (var element in lkel) {
              if (element.idkel == _poi!.idkel) {
                _poi!.kel = element;
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
      return ScaffoldLocView(
          title: _title,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 20.0),
                  Label2row('Nama', _poi!.nama),
                  _spasi(),
                  const Divider(),
                  Label2row('Provinsi:', '${_poi!.getStrProv()}'),
                  _spasi(),
                  const Divider(),
                  Label2row('Kabupaten:', '${_poi!.getStrKab()}'),
                  _spasi(),
                  const Divider(),
                  Label2row('Kecamatan:', '${_poi!.getStrKec()}'),
                  _spasi(),
                  const Divider(),
                  Label2row('Kelurahan:', '${_poi!.getStrKel()}'),
                  _spasi(),
                  const Divider(),
                  Label2row('Alamat:', '${_poi!.alamat}'),
                  const SizedBox(
                    height: 12,
                  ),
                  _koordinatWidget(context),
                  const SizedBox(
                    height: 150.0,
                  ),
                ],
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
            const SizedBox(
              height: 8,
            ),
            Label2row('Latitude:', '${_poi!.lat}'),
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
